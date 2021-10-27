#!/bin/bash
URL_prefix='https://example.com/filename_'
URL_var_range_start=1
URL_var_range_stop=10000
URL_var_range_zero_padding=5
URL_sufix='.ts'

echo "Creating videos folder..."
mkdir videos && cd "$_"

echo "Creating video folder..."
mkdir video && cd "$_"

echo "Downloading ts files..."
for i in $(seq -f "%0"$URL_var_range_zero_padding"g" $URL_var_range_start $URL_var_range_stop)
do
  DOWNLOAD_URL=$URL_prefix$i$URL_sufix
  SAVED_FILE="video_"$i".ts"
  CURL_COMMAND="curl -f -s "$DOWNLOAD_URL" -o "$SAVED_FILE
  if $CURL_COMMAND; then
    echo "Downloading "$SAVED_FILE"..."
  else
    echo "No more files to download."
    break
  fi;
done


echo "Creating playlist mylist.txt..."
printf "file '%s'\n" ./*.ts > mylist.txt

echo "Saving the video files into a single final-video.ts file..."
ffmpeg -f concat -safe 0 -i mylist.txt -c copy final-video.ts

echo "Cleaning unused files..."
rm video*.* mylist.txt
