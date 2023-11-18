#!/bin/bash

# This function adds a new blog post to the landing page.
# It generates the HTML code for the blog post preview and appends it to the index file.
output="$1"
title="$2"
DATE="$(date +"%d.%m.%Y")"
path="'posts/$DATE-$title.html'"
info="$3"
info="$(head -n 1 $info)"


echo "Processing post "$DATE-$title""
echo "..."

echo '
<main>
    <article class="blog-post" onclick="location.href='$path'">
        <md-block>'$title'</md-block>
        <md-block>'$info'</md-block>
        <p>Post from the '$DATE'</p>
    </article>

' >> $output

echo "Done"
echo