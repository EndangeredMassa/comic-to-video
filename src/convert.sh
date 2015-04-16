#!/bin/bash

# set global variables
fps=5
seconds_per_image=$1
framerate=1/$seconds_per_image

mkdir -p comics
mkdir -p videos
mkdir -p tmp

for comic in comics/*.cbz; do
  echo "[comic] $comic"
  comic=$(basename "$comic")

  item=${comic%.*}
  audio="$item.mp3"
  video="$item.mp4"
  comic="$item.cbz"

  echo "+ [audio] comics/$audio"


  # clean
  rm -f tmp/*
  rm -f movies/*

  # unzip comic into ./tmp
  unzip -q comics/$comic -d tmp

  # set video variables
  images=$(ls tmp/*.jpg | wc -l)
  images=`echo "$images - 1" | bc`
  time=`echo "$images * $fps" | bc`

  # create video
  ffmpeg \
    -loglevel fatal \
    -y \
    -framerate $framerate \
    -i tmp/%03d.jpg \
    -i comics/$audio \
    -c:a aac \
    -strict experimental \
    -b:a 192k \
    -c:v libx264 \
    -vf fps=$fps \
    -pix_fmt yuv420p \
    -t $time \
    videos/$video

  echo "= [video] videos/$video"
done

