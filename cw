#!/bin/bash
set -euo pipefail
REPO_DIR="${1:-.}"

if [[ -d "$REPO_DIR/.git/worktrees" ]]; then
    echo "Warning: Currently in a git worktree, switching to $REPO_DIR root"
    cd "$REPO_DIR"
fi
cd "$REPO_DIR"

git fetch --prune origin 2>/dev/null || git fetch --prune

git branch -r --format='%(refname:lstrip=3)' | grep -v '^HEAD$' | while read -r branch; do
    worktree_path="$REPO_DIR/$branch"
    parent_dir=$(dirname "$worktree_path")
     [[ "$parent_dir" != "$REPO_DIR" ]] && mkdir -p "$parent_dir"
    
    if [[ "$(git rev-parse --abbrev-ref HEAD 2>/dev/null)" == "$branch" ]]; then
        if [[ -d "$worktree_path" ]]; then
            echo "Removing existing worktree: $worktree_path"
            git worktree remove "$worktree_path" -f 2>/dev/null || true
            rm -rf "$worktree_path"
        fi
        
        echo "Branch $branch in main repo, creating worktree..."
        git worktree add "$worktree_path" "origin/$branch" 2>/dev/null || true
        if [[ -d "$worktree_path" ]]; then
            git -C "$worktree_path" checkout "$branch" 2>/dev/null || true
        fi
        echo "Created worktree: $worktree_path for branch $branch"
        continue
    fi
    
    if [[ -d "$worktree_path" ]]; then
        echo "Removing existing worktree: $worktree_path"
        git worktree remove "$worktree_path" -f 2>/dev/null || true
        rm -rf "$worktree_path"
    fi
    
    if git worktree add "$worktree_path" "origin/$branch"; then
        if [[ -d "$worktree_path" ]]; then
            git -C "$worktree_path" checkout "$branch" 2>/dev/null || true
        fi
        echo "Created worktree: $worktree_path for branch $branch"
    else
        echo "Error creating worktree for $branch"
    fi
done

echo ""
echo "Worktree setup complete"
echo "To list all worktrees: git worktree list"
