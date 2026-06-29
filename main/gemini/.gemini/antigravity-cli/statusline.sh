#!/bin/bash

# Read stdin
input=$(cat)

# Exit if input is empty
if [ -z "$input" ]; then
  exit 0
fi

# Parse fields with jq safely
STATE=$(echo "$input" | jq -r '.agent_state // .agentState // "idle"')
CWD=$(echo "$input" | jq -r '.workspace.current_dir // .workspace.currentDir // .cwd // ""')
BRANCH=$(echo "$input" | jq -r '.vcs.branch // .vcsBranch // ""')
DIRTY=$(echo "$input" | jq -r '.vcs.dirty // .vcsDirty // "false"')
MODEL=$(echo "$input" | jq -r '.model.display_name // .model.name // .model // ""')
CTX_PCT=$(echo "$input" | jq -r '.context_window.used_percentage // .contextWindow.usedPercentage // 0')

# TrueColor ANSI codes (Tokyo Night Theme)
CLR_PRIMARY="\033[38;2;122;162;247m"   # #7aa2f7 - Soft Blue
CLR_ACCENT="\033[38;2;187;154;247m"    # #bb9af7 - Lavender/Magenta
CLR_MUTED="\033[38;2;86;95;137m"        # #565f89 - Muted Gray

# Status colors
CLR_GREEN="\033[38;2;158;206;106m"      # #9ece6a - Green
CLR_CYAN="\033[38;2;125;207;255m"       # #7dcfff - Cyan
CLR_YELLOW="\033[38;2;224;175;104m"     # #e0af68 - Yellow
CLR_RED="\033[38;2;247;118;145m"        # #f77691 - Red

RESET="\033[0m"
BOLD="\033[1m"

# 1. State segment
case "$STATE" in
  "idle")
    STATE_STR="${CLR_GREEN}● idle${RESET}"
    ;;
  "thinking")
    STATE_STR="${CLR_CYAN}◉ thinking...${RESET}"
    ;;
  "running"|"working")
    STATE_STR="${CLR_YELLOW}▲ running${RESET}"
    ;;
  "tool_calling"|"tool_use")
    STATE_STR="${CLR_PRIMARY}⚙ tools${RESET}"
    ;;
  "initializing")
    STATE_STR="${CLR_MUTED}○ init${RESET}"
    ;;
  *)
    # Capitalize first letter
    STATE_STR="${CLR_CYAN}● $(echo "$STATE" | awk '{print toupper(substr($0,1,1))tolower(substr($0,2))}')${RESET}"
    ;;
esac

# 2. Model segment
if [ -n "$MODEL" ] && [ "$MODEL" != "null" ]; then
  # Shorten the model name for a cleaner status bar
  MODEL_SHORT=$(echo "$MODEL" | sed -E 's/Gemini //' | sed -E 's/ \(High\)//')
  MODEL_STR="${CLR_ACCENT}🤖 ${MODEL_SHORT}${RESET}"
else
  MODEL_STR=""
fi

# 3. Context Window segment
CTX_INT=$(printf "%.0f" "$CTX_PCT" 2>/dev/null || echo 0)
BAR=""
for i in {1..5}; do
  if [ $((i * 20)) -le "$CTX_INT" ]; then
    BAR="${BAR}■"
  else
    BAR="${BAR}□"
  fi
done

if [ "$CTX_INT" -gt 80 ]; then
  CTX_COLOR="$CLR_RED"
elif [ "$CTX_INT" -gt 50 ]; then
  CTX_COLOR="$CLR_YELLOW"
else
  CTX_COLOR="$CLR_CYAN"
fi
CTX_STR="${CTX_COLOR}ctx [${BAR}] ${CTX_INT}%${RESET}"

# 4. VCS Segment
if [ -n "$BRANCH" ] && [ "$BRANCH" != "null" ]; then
  if [ "$DIRTY" = "true" ]; then
    VCS_STR="${CLR_RED} ${BRANCH}*${RESET}"
  else
    VCS_STR="${CLR_GREEN} ${BRANCH}${RESET}"
  fi
else
  VCS_STR=""
fi

# 5. Directory Segment
if [ -n "$CWD" ] && [ "$CWD" != "null" ]; then
  CWD_DISPLAY="${CWD/#\/Users\/fl/~}"
  if [ ${#CWD_DISPLAY} -gt 35 ]; then
    CWD_DISPLAY="…/${CWD_DISPLAY##*/}"
  fi
  DIR_STR="${CLR_PRIMARY} ${CWD_DISPLAY}${RESET}"
else
  DIR_STR=""
fi

# Assemble segments
SEGMENTS=()
SEGMENTS+=("${CLR_PRIMARY}${BOLD}AGY${RESET}")
SEGMENTS+=("$STATE_STR")
[ -n "$MODEL_STR" ] && SEGMENTS+=("$MODEL_STR")
[ -n "$CTX_STR" ] && SEGMENTS+=("$CTX_STR")
[ -n "$VCS_STR" ] && SEGMENTS+=("$VCS_STR")
[ -n "$DIR_STR" ] && SEGMENTS+=("$DIR_STR")

# Join with muted dividers
OUTPUT=""
for seg in "${SEGMENTS[@]}"; do
  if [ -z "$OUTPUT" ]; then
    OUTPUT="$seg"
  else
    OUTPUT="${OUTPUT} ${CLR_MUTED}│${RESET} ${seg}"
  fi
done

echo -e "$OUTPUT"
