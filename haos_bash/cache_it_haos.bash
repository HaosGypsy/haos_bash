# Make git rememember passwords for 30 minutes.
git config --global credential.helper 'cache --timeout=1800'

function explain() {
    printf "\n"
    printf "This script stores credentials for remote repositories.\n"
    printf "\n"
    printf "It is still in need of polish, use at your own risk!\n"
    printf "(It's pretty harmless though...)\n"
    printf "\n"
}
