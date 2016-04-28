# This scripts take a new GitHub repository URL and creates a reveal.js gh-pages site.

# Use at your own risk!

function setup_reveal_js_on_gh_pages() {

    remote_url=$1
    git clone https://github.com/hakimel/reveal.js.git
    cd reveal.js/
    git remote set-url origin "$1" 
    git checkout -b gh-pages
    git branch -D master
    
    # ToDo : Delete things things that are not needed. REQUIRES THOUGHT!
    
    git push -u origin gh-pages
}

function prompt_user_for_url() {
    echo "Hi! This script works best with a URL for a new GitHub repository."
    echo "1 * Visit this URL : https://github.com/new"
    echo "Create a new repository and copy the repositories URL to your clipboard."
    echo "You can do that now, i'll wait here."
    
    read -p "Enter the GitHub repository : " repo_to_put_reveal_in
    
    echo "URL : $repo_to_put_reveal_in"
    
    setup_reveal_js_on_gh_pages "$repo_to_put_reveal_in"
    
    echo "Everything should be setup and ready to go!"
    echo ""
}
:<<EOF
EOF

if [ -z "$1" ]
then
    prompt_user_for_url
else
    setup_reveal_js_on_gh_pages "$1"
fi

# WISHLIST : Have it create a html file linking to all the decks.