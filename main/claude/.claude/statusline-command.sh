#!/usr/bin/env bash

input=$(cat)

# ── Model ──────────────────────────────────────────────────────────────────────
model=$(echo "$input" | jq -r '.model.display_name // "Unknown"')
model_id=$(echo "$input" | jq -r '.model.id // ""')

# ── Context window ─────────────────────────────────────────────────────────────
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
ctx_window=$(echo "$input" | jq -r '.context_window.context_window_size // empty')

if [ -n "$ctx_window" ]; then
  ctx_k=$(echo "$ctx_window" | awk '{printf "%dk", $1/1000}')
else
  ctx_k="?"
fi

if [ -n "$used_pct" ]; then
  used_int=$(printf "%.0f" "$used_pct")
  ctx_display="${used_int}%%"
else
  ctx_display="0%%"
  used_int=0
fi

# ── Git branch ─────────────────────────────────────────────────────────────────
cwd=$(echo "$input" | jq -r '.cwd // .workspace.current_dir // ""')
git_branch=""
if [ -n "$cwd" ]; then
  git_branch=$(git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null \
               || git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
fi

# ── Session duration ───────────────────────────────────────────────────────────
transcript=$(echo "$input" | jq -r '.transcript_path // empty')
session_duration="n/a"
if [ -n "$transcript" ] && [ -f "$transcript" ]; then
  first_ts=$(jq -r '[.. | objects | select(has("timestamp")) | .timestamp] | first // empty' "$transcript" 2>/dev/null)
  if [ -n "$first_ts" ]; then
    # macOS date (BSD)
    start_epoch=$(date -j -f "%Y-%m-%dT%H:%M:%S" "${first_ts%%.*}" "+%s" 2>/dev/null \
                  || date -d "$first_ts" "+%s" 2>/dev/null)
    if [ -n "$start_epoch" ]; then
      now_epoch=$(date "+%s")
      elapsed=$(( now_epoch - start_epoch ))
      h=$(( elapsed / 3600 ))
      m=$(( (elapsed % 3600) / 60 ))
      s=$(( elapsed % 60 ))
      if [ "$h" -gt 0 ]; then
        session_duration=$(printf "%dh%02dm" "$h" "$m")
      elif [ "$m" -gt 0 ]; then
        session_duration=$(printf "%dm%02ds" "$m" "$s")
      else
        session_duration="${s}s"
      fi
    fi
  fi
fi

# ── Thinking enabled ───────────────────────────────────────────────────────────
thinking="off"
if echo "$model_id" | grep -qi "thinking"; then
  thinking="on"
fi

# ── Other active Claude Code sessions ─────────────────────────────────────────
# Count distinct Claude Code processes; subtract 1 for the current one.
raw_sessions=$(pgrep -f "claude" 2>/dev/null | wc -l | tr -d ' ')
other_sessions=$(( raw_sessions > 1 ? raw_sessions - 1 : 0 ))

# ── Agents running in current session ─────────────────────────────────────────
session_id=$(echo "$input" | jq -r '.session_id // empty')
agents=0
if [ -n "$session_id" ]; then
  agents=$(pgrep -f "$session_id" 2>/dev/null | wc -l | tr -d ' ')
fi

# ── Render ─────────────────────────────────────────────────────────────────────
RESET='\033[0m'
BOLD='\033[1m'
DIM='\033[2m'

C_PURPLE='\033[35m'
C_CYAN='\033[36m'
C_YELLOW='\033[33m'
C_GREEN='\033[32m'
C_BLUE='\033[34m'
C_RED='\033[31m'
C_WHITE='\033[37m'
C_ORANGE='\033[38;5;208m'

PIPE="${DIM}  |  ${RESET}"

# -- Model block
model_block="${C_PURPLE}${BOLD}${model}${RESET}"

# -- Context block: color reflects pressure
if [ "$used_int" -ge 80 ] 2>/dev/null; then
  ctx_color="$C_RED"
elif [ "$used_int" -ge 50 ] 2>/dev/null; then
  ctx_color="$C_YELLOW"
else
  ctx_color="$C_GREEN"
fi
ctx_block="${ctx_color}ctx ${ctx_display}${RESET}"

# -- Git block
if [ -n "$git_branch" ]; then
  git_block="${C_CYAN} ${git_branch}${RESET}"
else
  git_block=""
fi

# -- Duration block
dur_block="${C_BLUE}⏱ ${session_duration}${RESET}"

# -- Thinking block
if [ "$thinking" = "on" ]; then
  think_block="${C_YELLOW}${BOLD}✦ thinking on${RESET}"
else
  think_block="${DIM}thinking off${RESET}"
fi

# -- Sessions block
if [ "$other_sessions" -gt 0 ]; then
  sess_label="${other_sessions} other session(s)"
  sess_block="${C_ORANGE}⊡ ${sess_label}${RESET}"
else
  sess_block="${DIM}⊡ solo session${RESET}"
fi

# -- Agents block
if [ "$agents" -gt 0 ]; then
  agent_block="${C_YELLOW}⚙ ${agents} agent(s)${RESET}"
else
  agent_block="${DIM}⚙ no agents${RESET}"
fi

# ── Assemble two groups ────────────────────────────────────────────────────────
#   Group A: identity  →  model | context | git branch
#   Group B: session   →  duration | thinking | sessions | agents

group_a="${model_block}${PIPE}${ctx_block}"
if [ -n "$git_block" ]; then
  group_a="${group_a}${PIPE}${git_block}"
fi

group_b="${dur_block}${PIPE}${think_block}${PIPE}${sess_block}${PIPE}${agent_block}"

# Wide separator between the two groups
GSEP="${DIM}    //    ${RESET}"

printf "${group_a}${GSEP}${group_b}\n"
