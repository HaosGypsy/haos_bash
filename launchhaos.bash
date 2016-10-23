: <<'EndOfBlockComment'

  This script gets the haos bash script collection started and allows the caller
to select and run scripts.

WARNING : None of this is tested with anything resembling regularity.

USE AT YOUR OWN RISK!!

EndOfBlockComment

: << 'TheToDoList'

ToDo : figure out how to make it a bit safer?
ToDo : Create a find the haos bash function.
ToDo : Set up the intial clickable to offer choices on type of haos bash?
ToDo : 

TheToDoList

function init() {
    clear
    if [ -d "haos_bash" ]
    then
        cd haos_bash;
        explain_what_can_be_done;
    else
        echo "There is no haos bash!!";
    fi
}

function explain_what_can_be_done() {
    
    local directories_and_files_in_current_directory=($(ls))
    declare -a haos_bash_files_in_current_directory;

    local count_of_dir_and_files=0;
    local count_of_haos_bash_files=0;
    
    echo "$directories_and_files_in_current_directory"
    
    for dir_or_file in "${directories_and_files_in_current_directory[@]}"
    
    do
        #echo "$dir_or_file"
        if [[ $dir_or_file == *"_haos.bash" ]]
        then
            haos_bash_files_in_current_directory[$count_of_haos_bash_files]="$dir_or_file"
            let "count_of_haos_bash_files+=1";
        fi
        let "count_of_dir_and_files+=1"
    done

    if [ ${#haos_bash_files_in_current_directory[@]} -gt 0 ]
    then
        
        function display_choices() {
            clear;
            printf "\n"
            for index in "${!haos_bash_files_in_current_directory[@]}"
            do 
              # display the index the user will choose.
              printf "%s : " "$(($index+1))";
              # display the file that choice is associated with.
              printf "%s\n" "${haos_bash_files_in_current_directory[$index]}"
            done
            printf "\n"
        }
        
        local users_choice=-1;
        
        while [[ $users_choice =~ ^-?[0-9]+$ ]] && [ $users_choice -ge -1 ] && [ $users_choice -le $((${#haos_bash_files_in_current_directory[@]}-1)) ]
        
        do
            if [ $users_choice -gt -1 ]
            then
                # Display the command that is going to be called.
                printf "\nbash %s" "${haos_bash_files_in_current_directory[$users_choice]}";
                read -p " : " _pause; # Pause for carriage return.
                printf "\n"
                
                # 
                
                explain_what_the_file_does "${haos_bash_files_in_current_directory[$users_choice]}"

                read -p " : " _pause; # Pause for carriage return.
                printf "\n"
                
                # RUN THE FILE!
                bash ${haos_bash_files_in_current_directory[$users_choice]};

                printf "\n->%s<- : COMPLETED." "${haos_bash_files_in_current_directory[$users_choice]}";
                read -p "" _pause;
                clear
            fi
            
            display_choices;
            
            read -p "Choose one : " users_choice;

            # See if the user entered an integer.
            if [[ $users_choice =~ ^-?[0-9]+$ ]]
            then
                let "users_choice = $(($users_choice-1))"; # Modify the choice to handle off by one concerns.
            fi

            if [[ $users_choice =~ ^-?[0-9]+$ ]] && [ $users_choice -ge 0 ] && [ $users_choice -le $((${#haos_bash_files_in_current_directory[@]}-1)) ]
            then
                let "users_choice = $users_choice";
            elif [ "$users_choice" = "q" ]
            then
                printf "\nBye now!\n";
                sleep 1.5;
                clear;
            else
                printf "I am not sure how to handle your input of : '%s'\n" "$users_choice";
                printf "You can enter 'q' if you would like to quit.\n";
                let "users_choice = -1";
            fi
        done
    else
        printf "There is nothing i can do here...\n";
    fi
}

function explain_what_the_file_does() {
    sed -n "/^function explain()/,/^}/p" "$1" > temp_func_to_explain.sh; source temp_func_to_explain.sh; rm temp_func_to_explain.sh
    if [ "$(type -t explain)" != 'function' ]
    then
    echo "NO EXPLANATION FUNCTION IN FILE : '$1' ";
    else
        explain
        unset explain
    fi
}

init
