#!/usr/bin/env bash
# set -e

# Usage: ./make_gallery.sh
#
# Run in a directory with a "walls/" subdirectory, and it will create a
# "thumbnails/" subdirectory.
#
# Uses imagemagick's `convert`, so make sure that's installed.
# On Ubuntu install `imagemagick` package via:
# sudo apt install imagemagick

# rm -rf thumbnails
mkdir -p thumbnails walls

url_root="https://raw.githubusercontent.com/DropB1t/wallpapers/main"

echo "## My Wallpaper Collection" >README.md
echo "This repository contains a curated collection of wallpapers that I've gathered from various sources across the internet. All wallpapers in this collection are **not owned by me** and are the property of their respective creators. All credits and copyrights belong to the original artists who created these wonderful images." >>README.md
echo "### Desktop Wallpapers" >>README.md
echo "" >>README.md

total=$(ls walls/ | wc -l)
i=0

for src in walls/*; do
  ((i++))
  filename="$(basename "$src")"
  printf '%4d/%d: %s\n' "$i" "$total" "$filename"

  test -e "${src/walls/thumbnails}" || convert "$src" -resize 200x100^ -gravity center -extent 200x100 "${src/walls/thumbnails}"

  filename_escaped="${filename// /%20}"
  thumb_url="$url_root/thumbnails/$filename_escaped"
  pape_url="$url_root/walls/$filename_escaped"

  echo "[![$filename]($thumb_url)]($pape_url)" >>README.md
done

# Mobile wallpapers section

#mkdir -p mobile
#echo "" >>README.md
#echo "### Mobile Wallpapers" >>README.md
#echo "" >>README.md
#
## for mobile wallpapers to be appended at the bottom of the thumbnails
#total=$(ls mobile/ | wc -l)
#i=0
#
#for src in mobile/*; do
#  ((i++))
#  filename="$(basename "$src")"
#  printf '%4d/%d: %s\n' "$i" "$total" "$filename"
#
#  test -e "${src/mobile/thumbnails}" || magick "$src" -resize 200x400^ -gravity center -extent 200x400 "${src/mobile/thumbnails}"
#
#  filename_escaped="${filename// /%20}"
#  thumb_url="$url_root/thumbnails/$filename_escaped"
#  pape_url="$url_root/mobile/$filename_escaped"
#
#  echo "[![$filename]($thumb_url)]($pape_url)" >>README.md
#done
