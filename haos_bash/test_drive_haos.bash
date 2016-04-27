file_to_test_one="test_haos1.bash"
file_to_test_two="test_haos2.bash"

function display_haos_bash_files_explanation() {
    sed -n "/^function explain()/,/^}/p" "$1" > temp_func_to_explain.sh; source temp_func_to_explain.sh; rm temp_func_to_explain.sh
    if [ "$(type -t explain)" != 'function' ]
    then
    echo "NO EXPLANATION FUNCTION IN FILE : '$1' ";
    else
        explain
        unset explain
    fi
}

display_haos_bash_files_explanation "$file_to_test_one"
display_haos_bash_files_explanation "$file_to_test_two"

