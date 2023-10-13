# spotify-notifier

**spotify-notifier** notifies you about the currently playing song on spotify and shows the song name, artist.
It is written in bash and uses applescript to get the currently playing song.

It is made for MacOS.

## Installation

```bash
brew tap Chaitanya-Shahare/formulae
brew install spotify-notifier
```

## Usage

```bash
$ spotify-notifier
```

By default it shows all the output and doesn't run in the background.

### Custom update interval

```bash
$ spotify-notifier --update-interval 5
```

This will update the output every 5 seconds.
By default it updates every 1 second.
It's recommended to at least set it to 3 seconds.

### Background

```bash
$ nohup ./spotify-notifier.sh --update-interval 5 > /dev/null &
```

This will run the script in the background and will update the output every 3 seconds

### Stop

```bash
$ kill -9 $(ps aux | grep "spotify-notifier" | awk '{print $2}')
```

This will stop the script from running in the background

## License

[MIT](https://choosealicense.com/licenses/mit/)

