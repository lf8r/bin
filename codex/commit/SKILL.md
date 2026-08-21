---
name: commit
description: Generates commit message.
tools:
   - git
---
DO NOT COMMIT the changes without my approval.

Run "git add -u" to stage the changes before generating the commit message.

Generate a commit message in two sections:
 - First section: Comprehensive description of the changes made, including the purpose and context of the changes.

 - Second section: Bullet points for:
   * Structural changes.
   * Program flow changes.
   * Before these changes.
   * After these changes.

Show the complete commit message you generated. Ask me for my approval. If I give the approval, commit the changes with the complete commit message. DO NOT generate a "conventional commit" message -- USE the one you generated above. NEVER push the changes.