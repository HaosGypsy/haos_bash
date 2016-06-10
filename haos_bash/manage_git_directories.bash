:<<EOF
EOF

# This script performs some routine repository management tasks.

# Status : Being developed! (clearly! %)

# ToDo : Figure out if it is tracking and pushing all branches. (Pretty sure it is (5/2/16))

# ToDo : Add viewing of remotes to options. 

# ToDo : Offer to pull if push fails.

# ToDo : Signal remote when script queries for username!

# DO NOT USE UNLESS YOU UNDERSTAND WHAT IT DOES!! READ THE CODE!! IT WILL MOST LIKELY CAUSE PROBLEMS!!

# ToDo : figure out some way to only work on the user's repositories and ignore any repos that were clone from sources without push rights.

# ToDo : Setup machine generate commit message to use Cloud9 enviornmental variables or some other value relavent to the machine generating and/or the repository itself.
# ToDo : Clean up the output!

# ToDo : Have UI display menu options. (see show_options function.)

# ToDo : Have UI display commit message.

# ToDo : Designate and set up an arguement so the UI can be bypassed.

# ToDo : Make output more readable.
#           - Create white spacing.
#           - Signal errors!
#           -

# ToDo : Have it create logs of what its done in each repo it's worked on.

# ToDo : Offer menu chose to show repos' remote URLs.

# ToDo : Automate production and management of gh-pages branches.
# ToDo : Offer an option to switch all the repos that have gh-pages to that branch.
# ToDo : Add auto quit after input.
# ToDo : 
# ToDo : 

# ToDo : Abstract (is that the right word?) out the switch statement into a menu system.

function run_program_loop {
    populate_array
    
    local users_choice
    local user_wants_to_quit="false"
    
    while [ "$user_wants_to_quit" != "true" ]
    do
        read -p "Enter your choice : " users_choice
        printf "\nYou choose : %s\n\n" $users_choice
        
        case "$users_choice" in
            "a")
               pull_all_repos
               ;;
            "b")
               add_all_commit_all_no_push
               ;;
            "B")
               add_all_commit_all_push_all
               ;;
            "c")
               cache_git_dits
               ;;
            "d")
               display_git_directories
               ;;
            "w")
               display_git_directories_their_branches_and_their_status            
               ;;
            "f")
               show_status_of_all_repos
                ;;
            "t")
               run_latest_testing
                ;;
            "q")
                user_wants_to_quit="true"
                ;;
            *)
                echo "Do not understand input!";
        esac
    done
    
}

# This functions is used for script testing during debug, update, da-de-da, deet-da-dee. (NEEDS TO BE FINISHED!)
function run_latest_testing() # currently testing function
{
    local test_var="no commit msg yet"
    echo "in (testing), \"test_var=$test_var"
    create_commit_message $test_var 
    echo "$test_var"
}

# ToDo : ^2 This lists all the functions in the script. (NEEDS TO BE FINISHED!)
function show_options() # Show a list of functions
{
    grep "^function" $0
}

function cache_git_dits {
    local num_minutes
    read -p "Time in minutes to cashe the dits? : " num_minutes;
    
    # ToDo : Figure out how to display the timeout value and echo it back!
    let "num_minutes = $num_minutes * 60"
    git config --global credential.helper "cache --timeout=$num_minutes"
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

      local string_cut_front="${git_directory#./}"
      echo ${string_cut_front%/.*}
      
    done
}

function display_git_directories_their_branches_and_their_status {
    for git_directory in "${GIT_DIRS[@]}"
    do
        #printf "\n\n";
        cd $git_directory;
        cd ..
        printf "\nIn : %s \n" $PWD;
        printf "\nGIT STATUS\n";
        git status
        printf "\nREPOSITORY BRANCHES\n\n";
        git branch -v
        cd $CALLED_FROM_DIR;
    done
}

function say_hello {
    echo "Work with git directories!"
    printf "Working directory is : %s\n" $PWD
}

function init_program {
    clear
    print_a_bunch_of_blank_lines 10
    count=0;
    GIT_DIRS=();
    CALLED_FROM_DIR="$PWD";
    if [ -z "$1" ]
    then
        COMMIT_MESSAGE_FOR_HAOS_manage_git_directories_SCRIPT="WHOLESALE COMMIT - ADD COMMIT MESSAGE NEXT TIME!"
    else
        COMMIT_MESSAGE_FOR_HAOS_manage_git_directories_SCRIPT="$1"
    fi
}

function print_a_bunch_of_blank_lines {
    
    local num_lines_to_print=15;
    
    if [ ! -z "$1" ]
    then
        num_lines_to_print="$1"
    fi
    
    for i in `seq 1 $num_lines_to_print`;
        do
                #printf "%s\n" "$1";    # <--- Usefull for experiments,
                printf "\n";            # <--- comment this out to use.
        done
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

# 'B'
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


function create_commit_message {
    local commit_to_return="$COMMIT_MESSAGE_FOR_HAOS_manage_git_directories_SCRIPT"
    return_var=$1
    $return_var="WOOT-WOOT"
}

# ToDo : Remove the duplication of action in the above and below functions.
# 
function add_all_commit_all_no_push {
    for git_directory in "${GIT_DIRS[@]}"
    do
      cd $git_directory;
      cd ..
     
      git add .
      git commit -m "$COMMIT_MESSAGE_FOR_HAOS_manage_git_directories_SCRIPT"
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

