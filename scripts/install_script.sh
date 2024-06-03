#!/bin/bash

SCRIPTS_DIR="$HOME/dotfiles/scripts"
SCRIPTS_PATH_FILE="$SCRIPTS_DIR/scripts_paths"

function add_script_repo {
    read -p "Enter script name: " script_name
    read -p "Enter repo URL: " repo_url
    read -p "Enter directory to clone the repo into: " clone_dir

    # Expand the tilde manually to resolve the absolute path
    clone_dir="${clone_dir/#\~/$HOME}"

    # Create a Makefile in the scripts directory if it doesn't exist
    makefile_path="$SCRIPTS_DIR/${script_name}_Makefile"
    if [ ! -f "$makefile_path" ]; then
        cat <<EOL > "$makefile_path"
# Makefile for $script_name

SCRIPT_NAME=$script_name
SCRIPT_DIR=$clone_dir/\$(SCRIPT_NAME)
BIN_DIR=\$(SCRIPT_DIR)/bin
SCRIPTS_PATH_FILE=$SCRIPTS_PATH_FILE
REPO_URL=$repo_url

all: install

install: setup
	@echo "Installing \$(SCRIPT_NAME)..."
	@echo "export PATH=\\\$\$PATH:\$(BIN_DIR)" >> \$(SCRIPTS_PATH_FILE)

setup:
	@echo "Setting up \$(SCRIPT_NAME)..."
	@mkdir -p \$(SCRIPT_DIR)
	@if [ ! -d "\$(SCRIPT_DIR)/.git" ]; then git clone \$(REPO_URL) \$(SCRIPT_DIR); fi
	# Default make command
	@make -C \$(SCRIPT_DIR)

remove:
	@echo "Removing \$(SCRIPT_NAME)..."
	@sed -i.bak "/\$(BIN_DIR)/d" \$(SCRIPTS_PATH_FILE)

update:
	@echo "Updating \$(SCRIPT_NAME)..."
	@git -C \$(SCRIPT_DIR) pull
	@make -C \$(SCRIPT_DIR)

.PHONY: all install setup remove update
EOL
    fi

    echo "Makefile for $script_name created at $makefile_path."
    echo
    echo "To ensure it works, make sure to adapt the setup step so that the bin folder contains an executable."
    echo
    echo "To use the Makefile, run the following commands:"
    echo "cd $SCRIPTS_DIR"
    echo "make -f ${script_name}_Makefile install"
    echo "make -f ${script_name}_Makefile setup"
    echo "make -f ${script_name}_Makefile remove (to remove the script)"
    echo "make -f ${script_name}_Makefile update (to update the script)"
}

add_script_repo

