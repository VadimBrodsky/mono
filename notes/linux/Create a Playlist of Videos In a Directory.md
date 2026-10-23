[Mpv](https://mpv.io/) can play `m3u` video playlists which is just a list of file names.
```shell
rg --files -g '*.mp4' -g '*.mkv' -g '*.avi' /path/to/videos > /path/to/videos/playlist.m3u
```
To play the playlist
```shell
mpv playlist.m3u
```
To start Mpv at a specific item in a playlist
```shell
mpv --playlist-start=3 playlist.m3u
```
And can also set a specific speed for playback
```shell
mpv --speed=1.25 playlist.m3u
```