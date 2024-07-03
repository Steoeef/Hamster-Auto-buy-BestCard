#!/bin/bash

# Colors
green='\033[0;32m'
yellow='\033[0;33m'
purple='\033[0;35m'
cyan='\033[0;36m'
rest='\033[0m'

# Clear the screen
clear
echo -e "${purple}=======${yellow} Hamster Combat Periodic Connector ${purple}=======${rest}"

# Prompt for Authorization
echo ""
echo -en "${green}Enter Authorization [${cyan}Example: ${yellow}Bearer 171852....${green}]: ${rest}"
read -r Authorization
echo -e "${purple}============================${rest}"

while true; do
    # Current timestamp
    current_time=$(date +%s)

    # Connect to the application
    response=$(curl -s -X POST \
        https://api.hamsterkombat.io/clicker/sync \
        -H "Content-Type: application/json" \
        -H "Authorization: $Authorization" \
        -d '{}')

    # Extract and display relevant information
    taps=$(echo "$response" | jq -r '.clickerUser.availableTaps')
    echo -e "${cyan}$(date '+%Y-%m-%d %H:%M:%S')${rest} - Connected to application. Available taps: ${yellow}$taps${rest}"

    # Calculate time for next connection (2 hours 59 minutes = 10740 seconds)
    next_connection=$((current_time + 10740))

    echo -e "Next connection at: ${cyan}$(date -d @$next_connection '+%Y-%m-%d %H:%M:%S')${rest}"
    echo -e "${purple}============================${rest}"

    # Sleep for 2 hours 59 minutes
    sleep 10740
done
