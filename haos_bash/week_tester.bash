function create_list_of_weeks {
    
    if [ \( -z "$1" \) -o \( -z "$2" \) -o \( -z "$3" \) ]
    then
        read -p "Enter the date (m d y) : " m d y rest_ignored
        read -p "Enter a time in 24hr format (hh:mm) : " time rest_ignored
        read -p "Enter number of weeks to create  : " num_weeks_to_count rest_ignored
    else
        IFS=- read m d y <<< "$1"
        time="$2"
        num_weeks_to_count="$3"
    fi
    
    inputed_date=$(date -d "$y-$m-$d $time")
    num_days_to_increment=7

    echo "inputed_date = $inputed_date"
    
    num_days_to_add_to_date=0
    for i in `seq 1 $num_weeks_to_count`;
        do
                calculated_date=$(date -d "$inputed_date $num_days_to_add_to_date days" '+%B %d %Y %R')
                echo "$calculated_date"
                let "num_days_to_add_to_date = $num_days_to_increment * $i"
        done 
    
}

create_list_of_weeks "2-10-17" "12:30" "5"