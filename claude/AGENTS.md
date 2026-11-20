# Codex Agent Instructions

## Code Modification Rules
- NEVER use, search for, or execute the `apply_patch` tool or command.
- NEVER attempt to use `sed` or bash stream editors to modify files.
- ALWAYS write and execute a short Python script using the standard library (e.g., `open()`, `.read()`, `.replace()`) to patch or rewrite source code.
- Proceed directly to creating and executing the Python script on the first attempt without executing tool fallbacks.
