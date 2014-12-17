#!/bin/bash

mkdir -p img
mkdir tmp-img

#flavicon.ico
convert -background none -colors 8 -geometry 16 icon.svg tmp-img/icon-16.png
convert -background none -colors 8 -geometry 32 icon.svg tmp-img/icon-32.png
convert -background none -colors 8 -geometry 48 icon.svg tmp-img/icon-48.png
convert tmp-img/icon-16.png tmp-img/icon-32.png tmp-img/icon-48.png flavicon.ico

#icons
convert -background none -geometry 64 icon.svg img/icon-64.png
convert -background none -geometry 152 icon.svg img/icon-152.png
convert -background none -geometry 192 icon.svg img/icon-192.png
cp icon.svg img/icon.svg

rm -r ./tmp-img
