#!/bin/bash

# Get the name of the currently focused output
FOCUSED_OUTPUT=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')

# Get a list of all workspace names
WORKSPACES=$(swaymsg -t get_workspaces | jq -r '.[].name')

# Loop through each workspace and move it to the focused output
for WS in $WORKSPACES; do
    swaymsg "workspace \"$WS\"; move workspace to output $FOCUSED_OUTPUT"
done
