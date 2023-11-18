#!/bin/bash

# Constants
CONFIG_FILE="./code/.env"
DATE_FORMAT="%d.%m.%Y"
INDEX_SCRIPT="./code/boilerplates/index"
POST_SCRIPT="./code/boilerplates/posts"

# Functions

# Function to initialize or renew the configuration
setup() {
    if [ -f "$CONFIG_FILE" ]; then
        echo "Configuration found:"
        display_config
    else
        echo "------------------------------------------"
        echo "Running initial setup..."
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
    echo "Thanks for using Webber!"
    echo "Press q: Save and quit"
    echo "Press c: Exit without saving"
    echo "Press s: Save and continue"
    echo "Press r: Redo Setup"
    echo "Press u: Uninstall"
    echo
    read -n 1 state
    echo

    case "$state" in
    q)
        echo "Saving and exiting"
        exit 0
        ;;
    c)
        echo "Exiting without saving"
        rm "$CONFIG_FILE"
        exit 0
        ;;
    s)
        echo "Continuing..."
        ;;
    r)
        rm "$CONFIG_FILE"
        setup
        ;;
    u)
        uninstall
        ;;
    *)
        echo "No known argument provided, try again"
        prompt
        ;;
    esac
}

# Function to uninstall Webber
uninstall() {
    echo "Uninstalling, are you sure?"
    read -p "Type \"Webber\" to uninstall, to exit press CTRL+C: " -n 6 uninstall
    echo

    if [ "$uninstall" = "Webber" ]; then
        echo "Uninstalling..."
        rm -rf ./code
        rm ./webber.sh
        echo "Done"
        exit 0
    else
        echo "Exiting (not uninstalling)"
        exit 1
    fi
}

# Function to display the current configuration
display_config() {
    echo ".env found"
    echo "To use different directories run \"./webber.sh --renew\""
    input="$(head -n 1 "$CONFIG_FILE")"
    output="$(tail -n 1 "$CONFIG_FILE")"
    echo "Input Path: $input"
    echo "Output Index: ${output}index.html"
    echo "Output Posts: ${output}posts/post1.html"
    echo
}

# Function to create the overview page
create_overview() {
    mkdir -p "${output}posts/"

    echo
    echo "Creating Overview Page"
    bash "$INDEX_SCRIPT/1.sh" "$output/index.html"

    for unProcessed in "${input}"*.md; do
        baseUnProcessed="${unProcessed%.*}"
        outputFormat="$(date +"$DATE_FORMAT")-${baseUnProcessed##*/}"

        for processed in "${output}"*.html; do
            echo "Adding $unProcessed to $output"
            echo
            info="$(head -n 1 "$unProcessed")"
            bash "$INDEX_SCRIPT/2.sh" "$output/index.html" "${baseUnProcessed##*/}" "$unProcessed"
        done
    done

    bash "$INDEX_SCRIPT/3.sh" "$output/index.html"
}

# Function to process and create posts
process_posts() {
    for unProcessed in "${input}"*.md; do
        run="true"

        for processed in "${output}posts/"*.html; do
            baseProcessed="$(basename "${processed%.*}")"
            cutBaseProcessed="${baseProcessed:11}"
            baseUnProcessed="$(basename "${unProcessed%.*}")"

            if [ "$cutBaseProcessed" == "$baseUnProcessed" ]; then
                run="false"
                break
            fi
        done

        if [ "$run" == "true" ]; then
            echo "Processing: $unProcessed"
            bash "$POST_SCRIPT/1.sh" "$unProcessed" "${output}"
            bash "$POST_SCRIPT/2.sh" "$unProcessed" "${output}"
            bash "$POST_SCRIPT/3.sh" "$unProcessed" "${output}"
        else
            echo "Skipping: $unProcessed"
        fi
    done
}

# Main Script

if [ "$1" = "--renew" ]; then
    echo "Renewing your config, are you sure?"
    read -p "y/n: " -n 1 confirm
    echo

    if [ "$confirm" = "y" ]; then
        echo "Renewing..."
        echo
        rm "$CONFIG_FILE"
        setup
    elif [ "$confirm" = "n" ]; then
        echo "Exiting"
        echo
        exit 0
    else
        echo "UNKNOWN INPUT ($confirm) EXITING"
        exit 1
    fi
fi

if [ "$1" = "-u" ]; then
    uninstall
fi

setup
create_overview
process_posts

echo
echo
echo "Finished"
echo "Thanks for using Webber"
echo "~ItsNik"
echo
