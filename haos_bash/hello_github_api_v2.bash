#GET /koreahaos/repos

function auth_user() {
    echo "Authentication"
    curl https://api.github.com/authorizations \
    --user "caspyin" \
    --data '{"scopes":["gist"],"note":"Demo"}'    
    
}

function run_loop() {
    
    local user_wants_to_continue="true"
    while [ "$user_wants_to_continue" == "true" ]
    do
        read -p "Continue? (y/n) : " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Nn]$ ]]
        then
            user_wants_to_continue="false"
        else
            echo "Doing loop thing"
        fi
    done
}

function display_user_status() {
    echo "current user : $github_user_name"
}


function set_up_user() {
    read -p "Enter your GitHub user name : " github_user_name
    #read -p "Enter label for repo folder : " name_for_repos_folder
}

function init() {
    set_up_user
    display_user_status
}


display_user_status
init
display_user_status






#auth_user
#run_loop

#curl -u USERNAME https://api.github.com/user/repos -d "{\"name\":\"REPONAME\",\"description\":\"REPODESCRIPTION\",\"gitignore_template\":\"LANG\", \"auto_init\":true}"

#curl -i -H "Accept: application/json" -H "Content-Type: application/json" -X GET http://hostname/resource
#curl -u "KoreaHaos" https://api.github.com
#curl https://api.github.com/users/KoreaHaos




