#!/usr/bin/env bash

input=$(cat)

# ── Parse ──────────────────────────────────────────────────────────────────────
model=$(echo "$input" | jq -r '.model.display_name // "Unknown"')
model_id=$(echo "$input" | jq -r '.model.id // ""')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // 0')
cwd=$(echo "$input" | jq -r '.cwd // .workspace.current_dir // ""')
transcript=$(echo "$input" | jq -r '.transcript_path // empty')
session_id=$(echo "$input" | jq -r '.session_id // empty')

# ── TrueColor palette (Tokyo Night) ───────────────────────────────────────────
CLR_BLUE="\033[38;2;122;162;247m"    # #7aa2f7
CLR_PURPLE="\033[38;2;187;154;247m"  # #bb9af7
CLR_MUTED="\033[38;2;86;95;137m"     # #565f89
CLR_GREEN="\033[38;2;158;206;106m"   # #9ece6a
CLR_CYAN="\033[38;2;125;207;255m"    # #7dcfff
CLR_YELLOW="\033[38;2;224;175;104m"  # #e0af68
CLR_RED="\033[38;2;247;118;145m"     # #f77691
RESET="\033[0m"
BOLD="\033[1m"

# ── Model (shortened) ──────────────────────────────────────────────────────────
model_short=$(echo "$model" | sed 's/Claude //')
model_str="${CLR_PURPLE}${BOLD}${model_short}${RESET}"

# ── Context bar ────────────────────────────────────────────────────────────────
ctx_int=$(printf "%.0f" "$used_pct" 2>/dev/null || echo 0)
bar=""
for i in 1 2 3 4 5; do
  if [ $(( (i - 1) * 20 )) -lt "$ctx_int" ]; then
    bar="${bar}■"
  else
    bar="${bar}□"
  fi
done
if [ "$ctx_int" -gt 80 ]; then
  ctx_clr="$CLR_RED"
elif [ "$ctx_int" -gt 50 ]; then
  ctx_clr="$CLR_YELLOW"
else
  ctx_clr="$CLR_CYAN"
fi
ctx_str="${ctx_clr}[${bar}] ${ctx_int}%${RESET}"

# ── Git branch ─────────────────────────────────────────────────────────────────
git_str=""
if [ -n "$cwd" ]; then
  branch=$(git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null \
           || git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
  [ -n "$branch" ] && git_str="${CLR_GREEN} ${branch}${RESET}"
fi

# ── Session duration ───────────────────────────────────────────────────────────
dur_str=""
if [ -n "$transcript" ] && [ -f "$transcript" ]; then
  first_ts=$(jq -r '[.. | objects | select(has("timestamp")) | .timestamp] | first // empty' "$transcript" 2>/dev/null)
  if [ -n "$first_ts" ]; then
    start_epoch=$(date -j -f "%Y-%m-%dT%H:%M:%S" "${first_ts%%.*}" "+%s" 2>/dev/null \
                  || date -d "$first_ts" "+%s" 2>/dev/null)
    if [ -n "$start_epoch" ]; then
      elapsed=$(( $(date "+%s") - start_epoch ))
      h=$(( elapsed / 3600 ))
      m=$(( (elapsed % 3600) / 60 ))
      s=$(( elapsed % 60 ))
      if [ "$h" -gt 0 ]; then
        dur_str="${CLR_MUTED}⏱ $(printf "%dh%02dm" "$h" "$m")${RESET}"
      elif [ "$m" -gt 0 ]; then
        dur_str="${CLR_MUTED}⏱ $(printf "%dm%02ds" "$m" "$s")${RESET}"
      else
        dur_str="${CLR_MUTED}⏱ ${s}s${RESET}"
      fi
    fi
  fi
fi

# ── Thinking ───────────────────────────────────────────────────────────────────
if echo "$model_id" | grep -qi "thinking"; then
  think_str="${CLR_YELLOW}${BOLD}✦ extended thinking${RESET}"
else
  think_str="${CLR_MUTED}✦ extended thinking${RESET}"
fi

# ── Other sessions ─────────────────────────────────────────────────────────────
raw_sessions=$(pgrep -f "claude" 2>/dev/null | wc -l | tr -d ' ')
other=$(( raw_sessions > 1 ? raw_sessions - 1 : 0 ))
if [ "$other" -gt 0 ]; then
  sess_str="${CLR_BLUE}${BOLD}⊡ ${other} session$([ "$other" -gt 1 ] && echo s)${RESET}"
else
  sess_str="${CLR_MUTED}⊡ 1 session${RESET}"
fi

# ── Working directory ──────────────────────────────────────────────────────────
cwd_str=""
if [ -n "$cwd" ]; then
  short_cwd="${cwd/#$HOME/~}"
  cwd_str="${CLR_MUTED}${short_cwd}${RESET}"
fi

# ── Assemble ───────────────────────────────────────────────────────────────────
SEP=" ${CLR_MUTED}│${RESET} "
SEGS=("${CLR_BLUE}${BOLD}Claude${RESET}" "$model_str" "$ctx_str")
[ -n "$cwd_str" ]  && SEGS+=("$cwd_str")
[ -n "$git_str" ]  && SEGS+=("$git_str")
[ -n "$dur_str" ]  && SEGS+=("$dur_str")
SEGS+=("$think_str" "$sess_str")

out=""
for seg in "${SEGS[@]}"; do
  [ -z "$out" ] && out="$seg" || out="${out}${SEP}${seg}"
done

echo -e "$out"
