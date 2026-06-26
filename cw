#!/usr/bin/env bash

# Colors
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

fetch_and_prepare() {
    echo "Fetching all branches..."
    set +o pipefail
    git fetch origin '+refs/heads/*:refs/remotes/origin/*' 2>/dev/null || true
    git fetch --all --prune 2>/dev/null || true
    set -o pipefail
}

get_branch_status() {
    local branch="$1"
    local worktree="$2"
    local status="up-to-date"

                                       # Check if remote branch still exists (refs/heads/branch format)
    if ! git ls-remote origin | grep -q "refs/heads/$branch$"; then
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

main() {
    fetch_and_prepare

    echo ""
    printf "%-30s %-30s %s\n" "BRANCH" "STATUS" "WORKTREE"
    printf "%-30s %-30s %s\n" "------" "------" "--------"

                                       # Get list of worktrees (strip brackets from branch names)
    local worktrees=$(git worktree list 2>/dev/null | awk '{print $1, $3}' | sed 's/\[//' | sed 's/\]//' | sort -u)

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
}

main
