#!/bin/bash

input="$1"
path="${2}posts/"
output="$(basename "${input%.*}").html"
DATE="$(date +"%d.%m.%Y")"

echo "Finishing file"
echo
echo "

</md-block>
<a href="//www.itsnik.de/blog">Go Back</a>
</main>
<script type="module" src="https://md-block.verou.me/md-block.js"></script>
<script src="//www.itsnik.de/blog/prism.js"></script>
</body>
</html>" >> $path$DATE-$output
echo "Done"
echo