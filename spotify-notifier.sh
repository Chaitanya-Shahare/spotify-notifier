#!/bin/bash

# Initialize variables to keep track of the current song and update interval
current_song=""
update_interval=1  # Default update interval

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --version)
            echo "v1.0.3"
            exit 0
            ;;
        --update-interval)
            update_interval="$2"
            shift 2
            ;;
        *)
            echo "Invalid argument: $1" >&2
            exit 1
            ;;
    esac
done

# Check if terminal-notifier is installed, and if not, install it
if ! command -v terminal-notifier &> /dev/null; then
    echo "Installing terminal-notifier..."
    brew install terminal-notifier
fi

# Function to send a notification with song information as an argument
send_notification() {
    local song_info="$1"
    terminal-notifier -title "Now Playing" -message "$song_info" -group "spotify_notification" -sender com.spotify.client
}

# Send the initial notification
initial_song_info=$(osascript -e 'tell application "Spotify" to name of current track & " - " & artist of current track')
send_notification "$initial_song_info"
current_song="$initial_song_info"

# Check for song changes in a loop
while true; do
    # Get the current song and artist from Spotify
    new_song_info=$(osascript -e 'tell application "Spotify" to name of current track & " - " & artist of current track')

    # Check if the song has changed
    if [ "$new_song_info" != "$current_song" ]; then
        # Send or update the notification with new_song_info
        send_notification "$new_song_info"
        current_song="$new_song_info"
    fi

    # Sleep for the specified interval before checking again
    sleep "$update_interval"
done
