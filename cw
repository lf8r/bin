#!/usr/bin/env bash

# Colors
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

USAGE="Usage: cw [--create] [--prune] [--help]

--create                Create worktrees for all remote branches
--prune                 Remove worktrees for defunct branches
--help                  Show this help message"

fetch_and_prepare() {
    echo "Fetching all branches..."
    set +o pipefail
    git fetch --prune origin '+refs/heads/*:refs/remotes/origin/*' 2>/dev/null || true
    git fetch --all --prune 2>/dev/null || true
    set -o pipefail
}

is_bare_repo() {
    local result
    result=$(git rev-parse --is-bare-repository 2>/dev/null)
       [ "$result" = "true" ]
}

create_worktrees() {
    local branches=("$@")
    
    echo "Creating worktrees..."
    local created=0
    local failed=0

    for branch in "${branches[@]}"; do
        local worktree_dir="$branch"
        echo "Creating worktree for '$branch' at '$worktree_dir'..."

        if is_bare_repo; then
              # For bare repos, use git clone to create the worktree
            if git clone --no-checkout "$(git rev-parse --git-dir)" "$worktree_dir" 2>/dev/null; then
                cd "$worktree_dir" && git checkout "$branch" 2>/dev/null
                if [ $? -eq 0 ]; then
                      ((created++))
                    echo "  Created: $worktree_dir"
                    cd - >/dev/null
                else
                    echo "  Failed: checkout of '$branch'"
                    rm -rf "$worktree_dir"
                      ((failed++))
                fi
            else
                echo "  Failed: clone"
                  ((failed++))
            fi
        else
            if git worktree add "$worktree_dir" "$branch" 2>/dev/null; then
                  ((created++))
                echo "  Created: $worktree_dir"
            else
                echo "  Failed: branch '$branch' or worktree exists"
                  ((failed++))
            fi
        fi
    done

    echo ""
    echo "Created $created worktree(s)"
    if [ "$failed" -gt 0 ]; then
        echo "Failed: $failed worktree(s)"
    fi
}

auto_create_worktrees() {
    echo "Fetching remote branches..."
    fetch_and_prepare

    local branches=()
    
    # Get remote branches, exclude HEAD
    while read -r remote; do
        [ "$remote" = "HEAD" ] && continue
        [ -z "$remote" ] && continue
        
        # Remove remote prefix (e.g., "origin/" -> "")
        local branch="${remote#*/}"
        
        # Skip if branch name is empty after stripping prefix
        [ -z "$branch" ] && continue
        
        branches+=("$branch")
    done < <(git branch -r 2>/dev/null | grep -v HEAD)
    
    if [ ${#branches[@]} -eq 0 ]; then
        echo "No remote branches found"
        return
    fi
    
    create_worktrees "${branches[@]}"
}

get_branch_status() {
    local branch="$1"
    local worktree="$2"
    local status="up-to-date"

       # Check if remote branch still exists (refs/heads/branch format)
    if ! git ls-remote origin 2>/dev/null | grep -q "refs/heads/$branch\$"; then
        status="gone"
        echo "$status"
        return
    fi

       # Check if branch needs pull
    local worktree_full="$worktree"
    local behind=$(git -C "$worktree_full" rev-list "origin/$branch"..HEAD --count 2>/dev/null || echo "0")

    if [ "$behind" -gt 0 ] 2>/dev/null; then
        status="stale"
    fi

    echo "$status"
}

print_status() {
    local branch="$1"
    local worktree="$2"
    local status="$3"

    local color="$GREEN"
    case "$status" in
              "gone") color="$RED";;
              "stale") color="$YELLOW";;
              *) color="$GREEN";;
    esac

    printf "${color}%-30s %-30s ${color}%-50s${NC}\n" "$branch" "$status" "$worktree"
}

make_relative() {
    local path="$1"
    local cwd=$(pwd)
    local repo_root

       # Try to get repo root, fall back to cwd
    repo_root=$(git rev-parse --show-toplevel 2>/dev/null)
    if [ $? -ne 0 ]; then
        repo_root="$cwd"
    fi

    if [[ "$path" == "$repo_root" ]]; then
        echo "."
        return
    fi

       # Check if path starts with repo_root/
    if [[ "$path" == "$repo_root/"* ]]; then
              # Worktree is inside repo
        local rel="${path#$repo_root/}"
        echo "./$rel"
        return
    fi

       # Worktree is sibling of repo root
    local worktree_name=$(basename "$path")
    echo "../$worktree_name"
}

prune_defunct_worktrees() {
    echo "Checking for defunct branches..."
    
       # Get list of worktrees with their branches
    local worktrees=$(git worktree list 2>/dev/null)
    local removed_count=0
    local failed_count=0

       # Parse worktree list and check each
    while read -r line; do
              # Skip header line
              [[ "$line" =~ ^# ]] && continue
        
              # Extract worktree path and branch
        worktree_path=$(echo "$line" | awk '{print $1}')
        branch=$(echo "$line" | awk '{print $3}' | sed 's/\[//' | sed 's/\]//')
        
              # Skip current worktree
              [[ "$worktree_path" == "$(pwd)" ]] && continue
        
              # Check if remote branch exists
        if ! git ls-remote origin 2>/dev/null | grep -q "refs/heads/$branch\$"; then
            echo "Removing worktree for defunct branch '$branch' at '$worktree_path'..."
            if git worktree remove "$worktree_path" 2>/dev/null; then
                      ((removed_count++))
            else
                echo "  Failed to remove '$worktree_path'"
                      ((failed_count++))
            fi
        fi
    done <<< "$worktrees"

    echo ""
    echo "Prune complete: removed $removed_count worktree(s)"
    if [ "$failed_count" -gt 0 ]; then
        echo "Failed: $failed_count worktree(s)"
    fi
}

# Parse arguments
create_mode=false
prune_mode=false

if [ "$1" = "--create" ]; then
    create_mode=true
elif [ "$1" = "--prune" ]; then
    prune_mode=true
elif [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    echo "$USAGE"
    exit 0
elif [ -n "$1" ]; then
    echo "Unknown option: $1"
    echo ""
    echo "$USAGE"
    exit 1
fi

if [ "$create_mode" = true ]; then
    auto_create_worktrees
elif [ "$prune_mode" = true ]; then
    prune_defunct_worktrees
else
    fetch_and_prepare
    
    echo ""
    printf "%-30s %-30s %s\n" "BRANCH" "STATUS" "WORKTREE"
    printf "%-30s %-30s %s\n" "------" "------" "--------"

       # Get list of worktrees (strip brackets from branch names)
    worktrees=$(git worktree list 2>/dev/null | awk '{print $1, $3}' | sed 's/\[//' | sed 's/\]//' | sort -u)

       # Check remote branches
    while read -r remote; do
              [ "$remote" = "HEAD" ] && continue
              [ -z "$remote" ] && continue

        remote_branch="${remote#*/}"
        worktree_dir=$(echo "$worktrees" | awk -v branch="$remote_branch" '$2 == branch {print $1}')
        worktree_rel=$(make_relative "$worktree_dir")

        status=$(get_branch_status "$remote_branch" "$worktree_dir")
        print_status "$remote_branch" "$worktree_rel" "$status"
    done < <(git branch -r 2>/dev/null | grep -v HEAD)

    echo ""
    printf "Color guide: ${RED}gone${NC} (remote deleted) | ${YELLOW}stale${NC} (needs pull) | ${GREEN}up-to-date${NC}\n"
fi
