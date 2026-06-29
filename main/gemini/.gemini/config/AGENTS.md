# Global Antigravity (Gemini) Rules

This is the global rules configuration file for the Antigravity (Gemini) environment.

## 🚨 CRITICAL FIRST STEP: Load Preferences

Before executing any instructions or tasks, you MUST read and conform to the global preference rules defined in:
```
~/.gemini/GEMINI.md
```

And consult the Second Brain at:
```
~/personal/second-brain/.ai-operator/AGENTS.md
```

## Core Behavioral Guidelines

1. **Rule of Least Surprise**: Adhere strictly to the `GEMINI.md` preferences. Do not make assumptions, do not add unsolicited comments or files, and do not perform git write commands.
2. **Dynamic Subagents**: When solving tasks, prioritize standard dynamic subagent orchestration. If a task requires a specialized custom agent (e.g. `infra-reviewer`, `ci-debugger`, `docs-writer`, or `pattern-finder`), use the custom agent.
3. **Sandbox Policy**: Terminal commands run without restrictions (`enableTerminalSandbox: false` and `toolPermission: "always-proceed"` as per global settings). However, maintain high standards of caution and verify destructive commands before running them.
