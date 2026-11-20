---
name: commit
description: Generates commit message using only the approved commit message body.
tools:
   - git
---

IMPORTANT: Do NOT commit without your approval.

Run "git add -u" to stage all tracked files that have been modified or deleted. This will NOT add new untracked files.

Generate a commit message in two sections:
 - First section: Comprehensive description of the changes made, including the purpose and context of the changes.

 - Second section: Bullet points for:
   * Structural changes.
   * Program flow changes.
   * Before these changes.
   * After these changes.

Show the complete commit message you generated. Ask me for my approval. If I give the approval, commit the changes using ONLY the exact commit message I approved. DO NOT generate a "conventional commit" message. NEVER push the changes.

IMPORTANT: When committing after approval, use the EXACT commit message body that you showed to the user for approval - preserve all formatting, line breaks, and wording precisely as approved. DO NOT modify, rephrase, or reformat the commit message in any way.
