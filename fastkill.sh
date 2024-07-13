#!/bin/bash

# Define colors
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
RESET=$(tput sgr0)

# Define icons (using Nerd Fonts)
CPU_ICON=""
MEMORY_ICON=""
PATH_ICON=""

# Function to display top processes using CPU
display_top_cpu() {
    echo "${CYAN}${CPU_ICON} Top 7 processes using the most CPU:${RESET}"
    ps -Ao pid,ppid,comm,%cpu,args | sort -rk 4 | head -n 8 | awk -v icon="$CPU_ICON" -v path_icon="$PATH_ICON" -v reset="$RESET" '
    NR==1 {print; next}
    {
        split($5, arr, "/"); 
        if (NR == 2 || $3 != prev_comm) {
            color = (color == "green") ? "yellow" : "green"
            printf("\n%s%s %5d %5d %-20s %5.1f%% %s %s%s\n", icon, color, $1, $2, $3, $4, path_icon, "", reset)
        } else {
            printf("%s%s %5d %5d %-20s %5.1f%% %s %s%s\n", icon, color, $1, $2, $3, $4, path_icon, "", reset)
        }
        prev_comm = $3
    }'
}

# Function to display top processes using memory
display_top_mem() {
    echo "${MAGENTA}${MEMORY_ICON} Top 7 processes using the most memory:${RESET}"
    ps -Ao pid,ppid,comm,%mem,args | sort -rk 4 | head -n 8 | awk -v icon="$MEMORY_ICON" -v path_icon="$PATH_ICON" -v reset="$RESET" '
    NR==1 {print; next}
    {
        split($5, arr, "/"); 
        if (NR == 2 || $3 != prev_comm) {
            color = (color == "green") ? "yellow" : "green"
            printf("\n%s%s %5d %5d %-20s %5.1f%% %s %s%s\n", icon, color, $1, $2, $3, $4, path_icon, "", reset)
        } else {
            printf("%s%s %5d %5d %-20s %5.1f%% %s %s%s\n", icon, color, $1, $2, $3, $4, path_icon, "", reset)
        }
        prev_comm = $3
    }'
}

# Main function to display live info
gather_and_display_live_info() {
    while true; do
        clear
        echo "${GREEN}🌟 FastKill Live Monitoring 🌟${RESET}"
        display_top_cpu
        echo ""
        display_top_mem
        echo ""
        sleep 2
    done
}

# Start gathering and displaying live info
gather_and_display_live_info