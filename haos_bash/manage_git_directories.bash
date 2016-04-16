function run_program_loop {
    populate_array
    local users_choice
    
    local user_wants_to_quit="false"
    
    while [ "$user_wants_to_quit" != "true" ]
    do
        read -p "Enter your choice : " users_choice
        printf "You choose : %s\n" $users_choice
        
        case $users_choice in
            a)
               pull_all_repos
               ;;
            b)
               add_all_commit_all_push_all
               ;;
            c)
               show_status_of_all_repos
               ;;
            d)
               display_git_directories
               ;;
            q)
                user_wants_to_quit="true"
                ;;
            *)
                echo "Do not understand input!";
        esac
    done
    
}

function ask_for_key_press {
    local user_input
    read -n1 -r -p "Any key to continue : " user_input
    echo ""
}

function ask_for_key_press_allow_quit {
    local user_input
    read -n1 -r -p "Any key to continue (q to quit) : " user_input
    echo ""
    if [ "$user_input" = 'q' ]; then
        exit;
    fi
}

function work_with_git_directory {
    echo "$1"
}

function populate_array {
    count=0;
    GIT_DIRS=()
    while IFS= read -r -d $'\0' file; do
      let "count++"
      GIT_DIRS[$count]="$file"
    done < <(find . -name .git -type d -prune -print0)
    echo "Found $count git directories!"
}

function display_git_directories {
    for git_directory in "${GIT_DIRS[@]}"
    do
      echo "${git_directory}";
    done
}

function say_hello {
    echo "Work with git directories!"
    printf "Working directory is : %s\n" $PWD
}

function init_program {
    count=0;
    GIT_DIRS=();
    CALLED_FROM_DIR="$PWD";
}

function pull_all_repos {
    for git_directory in "${GIT_DIRS[@]}"
    do
      cd $git_directory;
      cd ..

      git pull
      
      cd $CALLED_FROM_DIR;
    done
}


function add_all_commit_all_push_all {
    for git_directory in "${GIT_DIRS[@]}"
    do
      cd $git_directory;
      cd ..
     
      git add .
      git commit -m 'Wholesale commit...(this has got to change!)'
      git push --all
      cd $CALLED_FROM_DIR;
    done
}

function show_status_of_all_repos {
    for git_directory in "${GIT_DIRS[@]}"
    do
      cd $git_directory;
      cd ..

      git status
      
      cd $CALLED_FROM_DIR;
    done
}



say_hello
init_program
run_program_loop

:<<EOF
EOF