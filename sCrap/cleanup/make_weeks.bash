# This script creates a set of folders for organizing the weekly handouts and work
# encountered in a typical class.

# ToDo: Create better extendability and abstraction.

function make_directory_with_markdown_notes_file {
    if [ -z "$1" ]
    then
        echo "NO DIRECTORY NAME PASSED IN!"
    elif [ -z "$2" ]
    then
        echo "IN make_directory_with_markdown_notes_file : NO DATE PASSED IN!"
    else
        mkdir "$1"
        cd "$1"
        create_markdown_file "notes" "$2" "$3"
        cd ..
    fi
}

function create_markdown_file {
    
    # Check if there is is a third arg passed in. 
    if [ -z "$3" ]
    then
        append_string=" - NOTES"
    else
        append_string="$3 - NOTES"
    fi
    
    if [ -z "$1" ]
    then
        echo "NO FILE NAME PASSED IN!"
    elif [ -z "$2" ]
    then
        echo "In create_markdown_file : NO DATE PASSED IN!"
    else
cat > $1.md << EOF
# $2 $append_string
EOF
    fi
}

function create_list_of_weeks {
    
    if [ \( -z "$1" \) -o \( -z "$2" \) -o \( -z "$3" \) ]
    then
        read -p "Enter the date to start from (m d y) : " m d y rest_ignored
        read -p "Enter time class is held in 24hr format (hh:mm) : " time rest_ignored
        read -p "Enter number of weeks to create  : " num_weeks_to_count rest_ignored
    else
        IFS=- read m d y <<< "$1"
        time="$2"
        num_weeks_to_count="$3"
    fi
    
    inputed_date=$(date -d "$y-$m-$d $time")
    num_days_to_increment=7
    num_days_to_add_to_date=0

    for i in `seq 1 $num_weeks_to_count`;
        do
                calculated_date=$(date -d "$inputed_date $num_days_to_add_to_date days" '+%B %d %Y %R')
                echo "$calculated_date"
                let "num_days_to_add_to_date = $num_days_to_increment * $i"
        done 
}
 

date_to_start_from="3-2-16"
time_of_class="12:30"
number_of_weeks="15"
name_of_class="Basic Electronics Engineering (36564-01)"
directory_name="week_"

count=1
create_list_of_weeks "$date_to_start_from" "$time_of_class" "$number_of_weeks" | while read -r line; do make_directory_with_markdown_notes_file "$directory_name$count" "$line" "$name_of_class"; let "count=$count+1"; done
