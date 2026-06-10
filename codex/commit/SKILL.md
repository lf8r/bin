---
name: commit
description: Commit uncommitted changes with a comprehensive commit message for uncommitted changes. Use when the user asks to commit changes.
---

# Commit all uncommitted changes

Ignore untracked files and directories. Stage all tracked unstaged changes and commmit these with a comprehensive commit message that describes the changes in detail. DO NOT add untracked files and directories. The commit message should follow the Conventional Commits format, providing a clear and structured summary of the changes made. This helps maintain a clean and informative commit history, making it easier for other developers to understand the context and purpose of each commit.

## Workflow

1. Run `git status` and `git diff` (and `git diff --cached` if files are staged) to inspect uncommitted changes.
2. Analyze the diff to identify:
   - What was changed (added, modified, deleted files)
   - The nature of the changes (bug fix, feature, refactor, docs, etc.)
   - Key details about each change
3. Generate a commit message in Conventional Commits format:

   ```
   <type>(<scope>): <subject>

   <body (optional)>

   <footer (optional)>
   ```

   - **Type**: `feat`, `fix`, `docs`, `refactor`, `style`, `test`, `chore`, `ci`, `perf`, `build`
   - **Scope**: Optional module or component affected
   - **Subject**: Short, imperative summary (max ~50 chars)
   - **Body**: Detailed explanation of what changed and why (optional)
   - **Footer**: Breaking changes, issue references (optional)

4. Output the commit message, stage all uncommitted changes, inform the user is ready to commit, and ask for confirmation to proceed with the commit. If the user decides not to commit, keep the changes staged and provide instructions on how to commit manually.

## Tips

- Keep the subject line concise and in imperative mood ("Add feature" not "Added feature").
- Use the body to explain **why** the change was made, not just **what** changed.
- If multiple unrelated changes exist, suggest splitting into separate commits.
- If there are no uncommitted changes, inform the user that the working tree is clean.
