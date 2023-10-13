# spotify-notifier

**spotify-notifier** notifies you about the currently playing song on spotify and shows the song name, artist.
It is written in bash and uses applescript to get the currently playing song.

It is made for MacOS.

## Installation

```bash
$ brew tap Chaitanya-Shahare/formulae
$ brew install spotify-notifier
```

## Usage

```bash
$ spotify-notifier
```

By default it shows all the output and doesn't run in the background

### Custom update interval

```bash
$ spotify-notifier --update-interval 3
```

This will update the output every 3 seconds

### Background

```bash
$ nohup ./spotify-notifier.sh --update-interval 3 > /dev/null &
```

This will run the script in the background and will update the output every 3 seconds

### Stop

```bash
$ kill $(ps aux | grep "spotify-notifier.sh" | awk '{print $2}')
```

This will stop the script from running in the background

## License

[MIT](https://choosealicense.com/licenses/mit/)

