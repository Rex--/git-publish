#!/bin/sh
# This is a simple install script for git-publish.
# It prompts the user to chose a directory on their $PATH and then copies the
# git-publish script to it. It then copies the git-publish manpage to it's
# corresponsing directory.
#
# Copyright (C) 2022 Rex McKinnon
#

        # NR <= 9 && NR != 1 { printf " (%d) %s\n", NR, $1 }; \
# Prompt user for installation directory
echo "Select an install directory on your \$PATH:"
echo "$PATH" | \
awk -- 'BEGIN {RS = ":"}; \
        NR <= 9 { printf " "}; \
        NR == 1 { printf "(1) %s [default]\n", $1}; \
        NR >= 2 { printf "(%d) %s\n", NR, $1 }'
read -p "Input a number (enter for default): " PATH_FIELD
INSTALL_DIR="$(echo $PATH | cut -d: -f${PATH_FIELD:=1})"

# Check if install directory exists and if its writeable
if [ -d "$INSTALL_DIR" ] && [ ! -w "$INSTALL_DIR" ]; then
    echo "Error: You do not have permission to install to: $INSTALL_DIR"
    echo "Error: Re-run as root or choose a different install directory."
    exit 1
fi

# Copy git-publish script to install directory and mark it executable
echo -n "Installing 'git-publish' to '$INSTALL_DIR' -- "
cp git-publish "$INSTALL_DIR"
RET=$?
chmod --silent a+x "$INSTALL_DIR/git-publish"
RET="$(( $RET + $? ))"
if [ $RET -eq 0 ]; then
    echo "success"
else
    echo "FAIL: $RET"
    echo -e "Aborting installation...\n"
    exit 1
fi

# Find where man pages are stored. Right now we just take the first path of the
# 'manpath' command output. I don't know how portable the 'manpath' command is.
MAN_TEST="$(manpath | cut -d: -f1)"
MANPATH_RET=$?
if [ $MANPATH_RET -ne 0 ]; then
    echo "Warn: 'manpath' command not found, so the man page was not installed."
    echo "Warn: Install it yourself by copying git-publish.1 to the correct man directory."
elif [ ! -d "$MAN_TEST" ]; then
    echo "Warn: Man page directory not found, so the man page was not installed."
    echo "Warn: Install it yourself by copying git-publish.1 to the correct man directory."
else
    MAN_DIR="$MAN_TEST"
fi

# Check if the directory we found is writeable.
if [ -w "$MAN_DIR" ]; then
    echo -n "Installing 'docs/git-publish.1' to '$MAN_DIR' -- "
    mkdir -p "$MAN_DIR/man1"
    RET=$?
    cp docs/git-publish.1 "$MAN_DIR/man1/"
    RET="$(( $RET + $? ))"
    if [ $RET -eq 0 ]; then
        echo "success"
    else
        echo "FAIL: $RET"
        echo "Warn: Man page not installed!"
        echo "Warn: Install it yourself by copying git-publish.1 to the correct man directory."
    fi
else
    echo "Warn: You do not have permission to install man pages to: '$MAN_DIR'"
    echo "Warn: Re-run as root or manually copy 'docs/git-publish.1' to the directory."
fi

echo -e "\nSuccessfully installed git-publish."
