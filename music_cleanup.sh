#!/usr/bin/bash


#  1) convert to mp3 [ffmeg]

# - <decimal_number>.<file_format>

# 2) If we cant convert file [delete it]

# 3) convert to artist, name format ( _ in space of spaces ) [ffprobe]

# - <artist_name>_<song_name>.mp3

# - remove previous file

# - use artist not alblum artist

# ffprobe -show_format -loglevel quiet <audio_file>

# Now we should iterate over every file in the directory and do the conversion
# for each file
for i in "$1"/*
  do 
    # Get title and artist
    title=$(ffprobe -show_format "$i" | grep -i TAG:title= | cut -d '=' -f 2)
    artist=$(ffprobe -show_format "$i" | grep -i TAG:artist= | cut -d '=' -f 2)
    # Remove white space
    finalTitle=${title// /}
    finalArtist=${artist// /}
    # Convert to mp3 with new artist_title.mp3 name
    ffmpeg -n -i "$i" \
    -c:a libmp3lame \
    -q:a 2 \
    "$1/${finalArtist}_${finalTitle}.mp3" 
    rm "$i" 
done 
exit 0