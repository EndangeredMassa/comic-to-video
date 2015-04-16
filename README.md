# comic to video

The script at `./src/convert.sh`
loops over `comics/*.cbz`
and combines any `comics/*.mp3`
that match the comic name
into a video at `./videos/*.mp4`.

The video is a slideshow of the images
in the `cbz`. The number of seconds
should be passed in as the first parameter.

## example

```
$ ./src/convert.sh 5
[comic] comics/valiant.cbz
+ [audio] comics/valiant.mp3
= [video] videos/valiant.mp4
```

