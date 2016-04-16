# This script downloads your gists!

function get_gists {
    wget \
        $(wget -q -O- \
        $(gist -l | \
        grep -Eo '(http|https)://[^ ]+') | \
        grep -oP '"\K[^"\047]+[^"]/raw/[^"]+(?=["\047])' | \
        awk '{print "https://gist.githubusercontent.com"$1}')
}

if $(gem list gist -i)
then
    echo "Gist ruby gem is installed!"
else
    gem install gist
fi

if [ -e ~/.gist ]
then
    echo "GitHub Auth Token exists!"
else
    echo "Need to create Auth Token!"
    gist --login
fi

get_gists
