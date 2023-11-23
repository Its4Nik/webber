#!/bin/bash

# Constants
CONFIG_FILE="./code/.env"
DATE_FORMAT="%d.%m.%Y"
INDEX_SCRIPT="./code/boilerplates/index"
POST_SCRIPT="./code/boilerplates/posts"

# Colors for formatting
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Functions

# Function to initialize or renew the configuration
setup() {
    if [ -f "$CONFIG_FILE" ]; then
        echo -e "${GREEN}Configuration found:${NC}"
        display_config
    else
        echo -e "${YELLOW}------------------------------------------${NC}"
        echo -e "${YELLOW}Running initial setup...${NC}"
        touch "$CONFIG_FILE"

        read -p "Please enter the absolute path for input files: " input
        echo "$input" >> "$CONFIG_FILE"

        read -p "Please enter the absolute path for output files: " output
        echo "$output" >> "$CONFIG_FILE"

        prompt
    fi
}

# Function to prompt the user for actions
prompt() {
    echo
    echo -e "Thanks for using ${YELLOW}Webber!${NC}"
    echo -e "Press ${YELLOW}q:${NC} Save and quit"
    echo -e "Press ${YELLOW}c:${NC} Exit without saving"
    echo -e "Press ${YELLOW}s:${NC} Save and continue"
    echo -e "Press ${YELLOW}r:${NC} Redo Setup"
    echo -e "Press ${YELLOW}u:${NC} Uninstall"
    echo
    read -n 1 state
    echo

    case "$state" in
    q)
        echo -e "${GREEN}Saving and exiting${NC}"
        exit 0
        ;;
    c)
        echo -e "${GREEN}Exiting without saving${NC}"
        rm "$CONFIG_FILE"
        exit 0
        ;;
    s)
        echo -e "${GREEN}Continuing...${NC}"
        ;;
    r)
        rm "$CONFIG_FILE"
        setup
        ;;
    u)
        uninstall
        ;;
    *)
        echo -e "${RED}No known argument provided, try again${NC}"
        prompt
        ;;
    esac
}

# Function to uninstall Webber
uninstall() {
    echo -e "${YELLOW}Uninstalling, are you sure?${NC}"
    read -p "Type \"Webber\" to uninstall, to exit press CTRL+C: " -n 6 uninstall
    echo

    if [ "$uninstall" = "Webber" ]; then
        echo -e "${GREEN}Uninstalling...${NC}"
        rm -rf ./code
        rm ./webber.sh
        echo -e "${GREEN}Done${NC}"
        exit 0
    else
        echo -e "${GREEN}Exiting (not uninstalling)${NC}"
        exit 1
    fi
}

# Function to display the current configuration
display_config() {
    echo -e "${GREEN}.env found${NC}"
    echo -e "To use different directories run \"./webber.sh --renew\""
    input="$(head -n 1 "$CONFIG_FILE")"
    output="$(tail -n 1 "$CONFIG_FILE")"
    echo -e "${YELLOW}Input Path:${NC} $input"
    echo -e "${YELLOW}Output Index:${NC} ${output}index.html"
    echo -e "${YELLOW}Output Posts:${NC} ${output}posts/post1.html"
    echo
}

# Function to create the overview page
create_overview() {
    mkdir -p "${output}posts/"

    echo
    echo -e "${YELLOW}Creating Overview Page${NC}"
    bash "$INDEX_SCRIPT/1.sh" "$output/index.html"

    echo "starting"

    for file in $(ls -r "${output}posts/"*.html); do
        echo "$file"
        index="${output}index.html"
        base="$(basename "${file%.*}")"
        info="${input}${base:11}.md"
        echo "$INDEX_SCRIPT/2.sh $index $base"
        bash $INDEX_SCRIPT/2.sh $index $base $info
        echo "Done: $file"

    done
    bash "$INDEX_SCRIPT/3.sh" "$output/index.html"
}

# Function to process and create posts
# Function to process and create posts
process_posts() {
    for unProcessed in $(ls -r "${input}"*.md); do  # Removed double quotes around the command substitution
        run="true"

        for processed in $(ls -r "${output}posts/"*.html); do  # Removed double quotes around the command substitution
            baseProcessed="$(basename "${processed%.*}")"
            cutBaseProcessed="${baseProcessed:11}"
            baseUnProcessed="$(basename "${unProcessed%.*}")"

            if [ "$cutBaseProcessed" == "$baseUnProcessed" ]; then
                run="false"
                break
            fi
        done

        if [ "$run" == "true" ]; then
            echo -e "${YELLOW}Processing:${NC} $unProcessed"
            bash "$POST_SCRIPT/1.sh" "$unProcessed" "${output}"
            bash "$POST_SCRIPT/2.sh" "$unProcessed" "${output}"
            bash "$POST_SCRIPT/3.sh" "$unProcessed" "${output}"
        else
            echo -e "${YELLOW}Skipping:${NC} $unProcessed"
        fi
    done
}


# Main Script

if [ "$1" = "-renew" ]; then
    echo -e "${YELLOW}Renewing your config, are you sure?${NC}"
    read -p "y/n: " -n 1 confirm
    echo

    if [ "$confirm" = "y" ]; then
        echo -e "${GREEN}Renewing...${NC}"
        echo
        rm "$CONFIG_FILE"
        setup
    elif [ "$confirm" = "n" ]; then
        echo -e "${GREEN}Exiting${NC}"
        echo
        exit 0
    else
        echo -e "${RED}UNKNOWN INPUT ($confirm) EXITING${NC}"
        exit 1
    fi
fi

if [ "$1" = "-u" ]; then
    uninstall
fi

setup
process_posts
create_overview

echo
echo
echo -e "${GREEN}Finished${NC}"
echo -e "${GREEN}Thanks for using Webber${NC}"
echo -e "${YELLOW}~ItsNik${NC}"
