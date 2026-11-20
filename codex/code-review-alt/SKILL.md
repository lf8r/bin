---
name: code-review-alt
description: Review code changes with focus on bugs, regressions, and risk. First asks for review scope (uncommitted changes only, or against another branch), then performs targeted review prioritizing behavioral correctness, edge cases, test coverage, and security/operational risk.
---

# Code Review Skill

Review code changes with focus on bugs, regressions, risky assumptions, and missing tests. Do NOT perform style-only reviews or general architectural commentary unless it directly relates to correctness or risk.

## Review workflow

### Step 1: Determine review scope

Ask the user which scope they want:

1. **Uncommitted changes only** — review all uncommitted changes against `HEAD`
2. **Uncommitted changes + HEAD against another branch** — show available branches and let user pick one

For scope 2, list branches via `git branch --list` and ask user to select.

### Step 2: Gather the diff

- For scope 1: `git diff HEAD`
- For scope 2: `git diff <selected-branch>...HEAD`

### Step 3: Review priorities

Apply these priorities in order:

1. **Behavioral correctness** — does the code do what it's supposed to do?
2. **Edge cases and failure paths** — are error conditions, invalid inputs, and failure modes handled?
3. **Test coverage and validation quality** — are there tests? Do they validate the right things?
4. **Security, migration, and operational risk** — SQL injection, data loss, breaking changes?
5. **Consistency with existing architecture and conventions** — does it fit the project's patterns?

### Step 4: Report findings

Present findings as a numbered list with severity:

- **P1 Critical** — bugs, data loss, security vulnerabilities, complete failures
- **P2 Medium** — edge cases not handled, poor error messages, maintainability issues
- **P3 Low** — minor inconsistencies, small improvements, style where it matters

For each finding:
1. State what's wrong or missing
2. Cite the file/line or code pattern
3. Explain why it matters
4. Suggest a fix if clear

**End with**: "No meaningful findings discovered" if the review yields nothing significant.

## Guardrails

- Findings first, summary later
- Prioritize by severity (P1 before P2 before P3)
- Cite evidence (file, line, or code snippet)
- Explicitly state when no meaningful findings were discovered
- Skip style-only comments unless they impact correctness or maintenance
- Do not require changes that conflict with documented project standards
