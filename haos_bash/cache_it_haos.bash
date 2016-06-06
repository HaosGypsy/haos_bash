# Make git rememember passwords for 30 minutes.

if [ -z "$1" ]
then
    time_to_cache_dits_for="1800"
    #echo "Def Cred Cash."
else
    time_to_cache_dits_for="$1"
    #echo "Def Cred Cash = $1."
fi


git config --global credential.helper "cache --timeout=$time_to_cache_dits_for"

function explain() {
    printf "/n"
    printf "This script stores credentials for remote repositories./n"
    printf "/n"
    printf "It is still in need of polish, use at your own risk!/n"
    printf "(It's pretty harmless though...)/n"
    printf "/n"
    
}
