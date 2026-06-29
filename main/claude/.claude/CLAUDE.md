# Claude Code — Global Preferences

## Second Brain (Read First)

Before starting any non-trivial task, consult the second brain:

```
~/personal/second-brain/.ai-operator/AGENTS.md
```

This file lists specialized agents and knowledge bases. Match the task to the
right agent and follow any instructions defined there. Do this proactively —
do not wait to be asked.

---

## Mandatory: Plan Before Implementing

**Never jump directly into writing or editing code.**

1. Read the relevant files first.
2. Present a concise plan: what you will change, why, and any trade-offs.
3. Wait for approval before touching anything.

This applies to all non-trivial tasks. Simple one-liner fixes are exempt.

---

## Git Policy (Hard Constraints)

- **Never commit, amend, rebase, push, reset, or checkout.** All write git
  commands are banned across all repositories.
- **Read-only git is allowed**: `git log`, `git diff`, `git show`, `git status`,
  `git blame` for context only.
- **Exception**: the second-brain repository at `~/personal/second-brain/` may
  be managed with full git commands when explicitly asked.

---

## Code Style

- **Minimal changes**: touch only what is necessary. Preserve the surrounding
  style, indentation, and naming conventions of the existing file.
- Do not add comments, docstrings, or type annotations to code you did not
  change.
- Do not refactor, rename, or clean up code unless explicitly asked.
- Do not add error handling or validation beyond what the task requires.

---

## Testing

Write tests only when explicitly asked. Do not add test files as a side-effect
of implementing a feature or fix.

---

## Communication Style

- Explain reasoning briefly — one or two lines per decision.
- Do not write essays. The user will ask for more detail if needed.
- Surface trade-offs when choices exist, but keep it scannable.
- Use concise markdown lists over prose paragraphs.

---

## Tech Stack Context

Primary environment:

| Layer | Tools |
|---|---|
| Cloud | AWS, GCP |
| Containers | EKS, Kubernetes, Helm, ArgoCD |
| CI/CD | Jenkins, ArgoCD |
| IaC | Terraform |
| Language | Python |
| Shell | zsh (macOS), bash (Linux targets) |

When writing infrastructure code, prefer patterns already established in the
repository. Use the `pattern-finder` agent to discover them before proposing
new conventions.

---

## Available Custom Agents

These agents live in `~/.claude/agents/` and should be invoked via the Task
tool when the task matches their domain:

| Agent | Trigger |
|---|---|
| `infra-reviewer` | Review Terraform, K8s manifests, Helm charts |
| `ci-debugger` | Debug Jenkins or ArgoCD pipeline failures |
| `docs-writer` | Write runbooks, READMEs, architecture notes |
| `pattern-finder` | Discover existing patterns before proposing new ones |

Consult `~/personal/second-brain/.ai-operator/AGENTS.md` for additional agents
and routing logic.
