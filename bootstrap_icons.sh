#!/bin/bash

mkdir -p img
mkdir tmp-img

#flavicon.ico
rsvg -w 16 icon.svg tmp-img/icon-16.png
rsvg -w 32 icon.svg tmp-img/icon-32.png
rsvg -w 48 icon.svg tmp-img/icon-48.png
convert tmp-img/icon-16.png tmp-img/icon-32.png tmp-img/icon-48.png flavicon.ico

#icons
rsvg -w 64 icon.svg img/icon-64.png
rsvg -w 152 icon.svg img/icon-152.png
rsvg -w 192 icon.svg img/icon-192.png
cp icon.svg img/icon.svg

rm -r ./tmp-img
