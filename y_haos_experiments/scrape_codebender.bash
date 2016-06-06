# Going for :
# wget https://codebender.cc/user/KoreaHaos
# https://codebender.cc/sketch:271253
# https://codebender.cc/utilities/download/302618?referrer=KoreaHaos

default_user_name="koreahaos"

function get_user_name()
{
    
    read -p "Enter CodeBender user name : " codebender_user_name
    
    if [ "$codebender_user_name" = "" ]
    then
        codebender_user_name="$default_user_name"
    fi
}

# get_user_name
codebender_user_name="$default_user_name"

url_to_scrape="https://codebender.cc/user/$codebender_user_name"
echo "scrape = $url_to_scrape"

wget  $url_to_scrape -q -O - |grep -Po '(?<=href="/sketch:)[^"]*' | awk '{print "https://codebender.cc/utilities/download/"$1"?referrer=KoreaHaos"}'|xargs wget  -q -O - |xargs unzip
