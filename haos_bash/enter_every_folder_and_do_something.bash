function the_something_to_do() {
    echo "Doing stuffs to : $1"
    # SOMETHING TO DO GOES HERE!
}

function recurse_directories() {
for file in "$1"/*
do
    if [ -d "${file}" ]
    then
        if [ "$2" == "true" ]
        then
            echo "location acting on : ${file}"
            the_something_to_do "${file}"
            recurse_directories "${file}" "$2"
        else
            echo "location acting on : ${file}"
            recurse_directories "${file}" "$2"
        fi
    fi
done
}

function main() {
    echo ""
    echo "Start directory : $PWD"
    echo ""
    echo "Acted on directories :"
    echo ""
    
    recurse_directories "$PWD" "false"
    
    echo ""
    echo ""
    echo ""
    read -p "Do action? (y/n) : " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        recurse_directories "$PWD" "true"
    fi
    
}

main
