# This scripts requires the first arguement to be a URL for a newly created GitHub repository.

# It then makes the repo into a reveal.js slide show!

# Use at your own risk!

function do_it() {
    remote_url=$1
    
    git clone https://github.com/hakimel/reveal.js.git
    cd reveal.js/
    rm -Rf .git
    git init
    git add .
    git commit -m 'First commit.'
    git checkout -b gh-pages
    git remote add origin "$1"
    git push -u origin gh-pages
}

if [ -z "$1" ]
then
    echo "Call function with URL of remote!"
else
    do_it "$1"
fi
