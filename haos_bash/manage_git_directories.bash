:<<EOF

# Pretty sure this is not needed!

function work_with_git_directory {
    echo "$1"
}
EOF

# This script attempts to add, commit, and push to remote, all the git repos it finds.

# Status : Being developed!

# DO NOT USE UNLESS YOU UNDERSTAND WHAT IT DOES!! READ THE CODE!! IT CAN CAUSE PROBLEMS!!

# ToDo : figure out some way to only work on the user's repositories and ignore 
# any repos that were clone from sources without push rights.

# ToDo : Have UI display menu options.

# ToDo : Have UI display commit message.

# ToDo : Designate and set up an arguement so the UI can be bypassed.

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
            e)
               add_all_commit_all_no_push
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
    if [ -z "$1" ]
    then
        COMMIT_MESSAGE_FOR_HAOS_manage_git_directories_SCRIPT="Wholesale commit...(next time add message to call!)";
    else
        COMMIT_MESSAGE_FOR_HAOS_manage_git_directories_SCRIPT="$1"
    fi
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
      git commit -m "$COMMIT_MESSAGE_FOR_HAOS_manage_git_directories_SCRIPT"
      git push --all
      cd $CALLED_FROM_DIR;
    done
}

function add_all_commit_all_no_push {
    for git_directory in "${GIT_DIRS[@]}"
    do
      cd $git_directory;
      cd ..
     
      git add .
      git commit -m "$COMMIT_MESSAGE_FOR_HAOS_manage_git_directories_SCRIPT"
      # git push --all
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
init_program "$1"
run_program_loop

:<<EOF
EOF

