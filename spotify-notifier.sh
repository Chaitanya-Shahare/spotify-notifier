#!/bin/bash

# Initialize variables to keep track of the current song
current_song=""
current_artist=""

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
    sleep 10
done
