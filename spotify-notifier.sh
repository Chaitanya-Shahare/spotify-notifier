#!/bin/bash

# Initialize variables to keep track of the current song
current_song=""

# Check if the argument is "--version" and return the version
if [ "$1" = "--version" ]; then
    echo "v1.0.1"
    exit 0
fi

# Check if terminal-notifier is installed, and if not, install it
if ! command -v terminal-notifier &> /dev/null; then
    echo "Installing terminal-notifier..."
    brew install terminal-notifier
fi

# Function to send a notification
send_notification() {
    song_info=$(osascript -e 'tell application "Spotify" to name of current track & " - " & artist of current track')
    terminal-notifier -title "Now Playing" -message "$song_info" -group "spotify_notification" -sender com.spotify.client 
}

# Send the initial notification
send_notification

# Check for song changes in a loop
while true; do
    # Get the current song and artist from Spotify
    new_song_info=$(osascript -e 'tell application "Spotify" to name of current track & " - " & artist of current track')

    # Check if the song has changed
    if [ "$new_song_info" != "$current_song" ]; then
        # Send or update the notification
        send_notification
        current_song="$new_song_info"
    fi

    # Sleep for a few seconds before checking again
    sleep 1
done
