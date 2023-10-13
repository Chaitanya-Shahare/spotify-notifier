#!/bin/bash

# Initialize variables to keep track of the current song
current_song=""
current_artist=""

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

# Send the initial notification
initial_song_info=$(osascript -e 'tell application "Spotify" to name of current track & " - " & artist of current track')
terminal-notifier -title "Now Playing" -message "$initial_song_info" -group "spotify_notification" -sender com.spotify.client
current_song="$initial_song_info"

# Check for song changes in a loop
while true; do
    # Get the current song and artist from Spotify
    song_info=$(osascript -e 'tell application "Spotify" to name of current track & " - " & artist of current track')

    # Check if the song has changed
    if [ "$song_info" != "$current_song" ]; then
        # Send or update the notification using terminal-notifier
        terminal-notifier -title "Now Playing" -message "$song_info" -group "spotify_notification" -sender com.spotify.client 

        # Update the current song
        current_song="$song_info"
    fi

    # Sleep for a few seconds before checking again
    sleep 1
done
