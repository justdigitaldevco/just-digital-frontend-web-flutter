#!/bin/bash
magick convert app_icon.png -resize 32x32 favicon.png
magick convert app_icon.png -resize 192x192 Icon-192.png
magick convert app_icon.png -resize 512x512 Icon-512.png
magick convert app_icon.png -resize 192x192 Icon-maskable-192.png
magick convert app_icon.png -resize 512x512 Icon-maskable-512.png
echo "Icons generated successfully!"
