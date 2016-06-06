url_to_scrape="https://codebender.cc/user/KoreaHaos"

mkdir codebender_files
cd codebender_files

wget  $url_to_scrape -q -O - |grep -Po '(?<=href="/sketch:)[^"]*' | awk '{print "https://codebender.cc/utilities/download/"$1"?referrer=KoreaHaos"}'|xargs wget

for file_got in *
do
    unzip $file_got
    rm $file_got
done
