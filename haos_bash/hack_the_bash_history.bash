function modify_history() {
    cd $GOPATH
    cd ..
    
    echo "$most_imporant_history_item" > $GOPATH/tempfile
    echo "$line_2" >> $GOPATH/tempfile
    
    cat .bash_history >> $GOPATH/tempfile
    
    cp $GOPATH/tempfile .bash_history
    
    rm $GOPATH/tempfile
}

function set_scripts_path() {
    SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" 
}

function set_scripts_path_and_name() {
    SCRIPTS_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"    
}

set_scripts_path
set_scripts_path_and_name

most_imporant_history_item="bash $SCRIPTS_DIR/manage_git_directories.bash"
line_2="bash $SCRIPTS_DIR/manage_git_directories.bash A"


modify_history


#n ToDo : Figure out how to make the new line available with terminsal restart
# kill -9 $PPID



echo "You need to close your terminal and reopen before history mods will occure."