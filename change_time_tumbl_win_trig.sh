#!/bin/bash

# Specify the path to the JSON file
json_file="pipeline.json"

# Specify the new start time
#new_start_time="2023-11-24T10:00:00Z"
new_start_time=$(date -u +%Y-%m-%dT%H:%M:%SZ)

# Update the start time for the specified type in the JSON file
jq --arg new_start_time "$new_start_time" '.resources |= map(if .type == "Microsoft.Synapse/workspaces/triggers" then .properties.typeProperties.startTime = $new_start_time else . end)' "$json_file" > temp.json \
&& mv temp.json "$json_file"

echo "Start time updated successfully."
