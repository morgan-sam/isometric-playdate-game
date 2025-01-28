#!/bin/bash

# Check if PLAYDATE_SDK_PATH is set
if [ -z "$PLAYDATE_SDK_PATH" ]; then
    echo "Error: PLAYDATE_SDK_PATH environment variable is not set"
    exit 1
fi

# Function to kill existing simulator instances
kill_simulator() {
    for PROCESS in "PlaydateSimulator" "playdate" "simulator" "Simulator"; do
        pgrep -f "$PROCESS" | while read -r pid; do
            kill -9 "$pid" 2>/dev/null || true
        done
    done
    sleep 0.5
}

# Function to compile and run
compile_and_run() {
    "$PLAYDATE_SDK_PATH/bin/pdc" "source" "MyGame.pdx"
    
    if [ $? -eq 0 ]; then
        kill_simulator
        "$PLAYDATE_SDK_PATH/bin/PlaydateSimulator" "MyGame.pdx" &
    fi
}

# Trap to kill simulator on script exit
trap kill_simulator EXIT INT TERM

# Initial compilation and run
compile_and_run

# Using inotifywait for Linux
if ! command -v inotifywait >/dev/null 2>&1; then
    echo "Error: inotifywait is not installed. Install it using 'sudo apt-get install inotify-tools'"
    exit 1
fi

# Suppress the watch setup message
while inotifywait -r -e modify,create,delete source 2>/dev/null; do
    compile_and_run
done