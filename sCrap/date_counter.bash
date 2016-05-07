function produce_date_that_is_x_days_from_another_date()
{
    echo "Today is : $(date)"
    read -p "Enter a date (return for today) : " users_inputed_date_string;
    # echo "Received : ->$users_input<-"
    local user_inputed_date=$(date -d "$users_inputed_date_string");
    echo "Start Date : $user_inputed_date";

    read -p "Enter days to count off : " users_inputed_days_to_count_off_string;
    # echo "Received : ->$users_inputed_days_to_count_off_string<-"
    local user_inputed_date_with_days_added=$(date -d "$user_inputed_date+"$users_inputed_days_to_count_off_string" DAYS");
    echo "$user_inputed_date_with_days_added";
}

produce_date_that_is_x_days_from_another_date
