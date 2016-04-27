page_title="Haos Decks"
output_file="index.html"

cat >"$output_file"<<EOF
<!DOCTYPE html>
<html>
    <head>
        <title>$page_title</title>
    </head>
    <body>
    <ul>
EOF

ls *.html | cut -f 1 -d '.' | awk '{print "      <li><a href=\""$1".html\">"$1"</a></li>"}' >> $output_file

cat >>"$output_file"<<EOF
    </ul>
    </body>
</html>
EOF
