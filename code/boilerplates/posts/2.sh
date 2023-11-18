#!/bin/bash

input="$1"
path="${2}posts/"
output="$(basename "${input%.*}").html"
DATE="$(date +"%d.%m.%Y")"

echo "Processing $input"
echo

cat $input >> $path$DATE-$output
echo "Done"
echo