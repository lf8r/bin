---
name: commit-message
description: Generate a comprehensive commit message for uncommitted changes. Use when the user asks to write, draft, or generate a commit message, or when they want to summarize staged or unstaged changes into a commit message without actually committing.
---

# Commit Message

Generate a comprehensive commit message for uncommitted changes. Do not commit anything, just generate the message.

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

4. Output only the commit message. Do not run `git commit` or suggest the user to do so unless they ask.

## Tips

- Keep the subject line concise and in imperative mood ("Add feature" not "Added feature").
- Use the body to explain **why** the change was made, not just **what** changed.
- If multiple unrelated changes exist, suggest splitting into separate commits.
- If there are no uncommitted changes, inform the user that the working tree is clean.
