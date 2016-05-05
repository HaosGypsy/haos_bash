# Make git rememember passwords for 30 minutes.

# ToDo: THIS NEEDS TO CHECK IF THE REPOSITORY IS ALREADY LOCAL!!
# ToDo: This is dumb. Figure out how to abstract it create a config file.

# v 0.21 - Added ui menu.

:<<EOF

ToDo: Figure out if the URL for the git repo of this gist is persistent.

on 4/19/16, URL = https://gist.github.com/c00c046814c0deee2c1b489c9931eae5.git

EOF

git config --global credential.helper 'cache --timeout=1800'

function create_array_of_repos {
    git_repos=()
    git_repos+=("https://gitlab.com/ewha_spring_2016/38046_01_financial_technology.git")
    git_repos+=("https://gitlab.com/ewha_spring_2016/36564_01_basic_electronics_engineering.git")
    git_repos+=("https://gitlab.com/koreahaos/37269_01_smart_software_project.git")
    git_repos+=("https://gitlab.com/ewha_spring_2016/36095_02_basic_circuit_lab.git")
    git_repos+=("https://gitlab.com/koreahaos/30490_01_metal_and_expression.git")
    git_repos+=("https://gitlab.com/ewha_spring_2016/z_spring_2016_bash_toolset.git")
}
function display_menu_choices {
    local index=1
    for i in "${git_repos[@]}"
    do
       printf "%d " $index
       echo "$index ) $i" | sed 's/.*\///'
       let "index++"
    done
}

function get_repos_loop {
    local user_continues="true"
    
    create_array_of_repos
    
    while [ "$user_continues" == "true" ]
    do
        display_menu_choices
        
        read -p "Which repo ? (q to quit): " index_to_download
        
        if [ "$index_to_download" == "q" ]
        then
            user_continues="false"
        elif [ $index_to_download -eq $index_to_download 2>/dev/null ] && [ $index_to_download -ge 1 ] && [ $index_to_download -le ${#git_repos[@]} ] && [ ${#git_repos[@]} -gt 0 ]
        then
            let "index_to_download--"
            repo_to_download="${git_repos[index_to_download]}"
            git_repos=(${git_repos[@]:0:$index_to_download} ${git_repos[@]:$(($index_to_download + 1))})
            git clone "$repo_to_download"
        elif [ ${#git_repos[@]} -le 0 ]
        then
            echo "No more repos to download!"
            user_continues="false"
        else
            echo "Your input of $index_to_download is not understood."
        fi
        
        if [ ${#git_repos[@]} -le 0 ]
        then
            echo "No more repos to download!"
            user_continues="false"
        fi
    done
}

get_repos_loop