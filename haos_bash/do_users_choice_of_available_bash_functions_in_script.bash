# Shows a list of functions available to call in a menu system.

function offer_and_execute_options_available() {

    # Get temp list if runable function in script.
    local temp=$(grep "^function" $0 | tr -d '(){'  |  cut -f2- -d ' ')
    
    # Create seperate key and function lists.
    local key_for_call=$(echo "$temp" | grep -io "^[a-z]_"  |  tr -d '_')
    local function_to_call=$(echo "$temp" | grep -i "^[a-z]_" | cut -f2- -d '_') 
    
    # Create a key/value associative array of the runnable functions.
    declare -A key_letter_and_function_call_map
    
    # Put the keys into the array.
    for line in $key_for_call
    do
        key_letter_and_function_call_map[$line]="tmp"
    done
    
    # Make a key ring!
    KEYS=(${!key_letter_and_function_call_map[@]}) 
    
    # Attach the callable functions to the keys.
    local index=0
    for line in $function_to_call
    do
        KEY=${KEYS[$index]}
        key_letter_and_function_call_map[$KEY]="$line"
        ((index = $index + 1))
    done
    
    # Display the menu of callable functions
    for (( i = 0; $i < ${#key_letter_and_function_call_map[@]}; i+=1 ))
    do
        KEY=${KEYS[$i]}
        echo $KEY : ${key_letter_and_function_call_map[$KEY]}
    done

    # Query for choice frm user.
    read -p "Your choice? : " -n 1 -r
    echo

    if [ ! -z "${key_letter_and_function_call_map[$REPLY]}" ]
    then
        echo "Your choice : $REPLY"
        function_to_run=$REPLY"_"${key_letter_and_function_call_map["$REPLY"]}
        
        read -p "Run function $REPLY_${key_letter_and_function_call_map["$REPLY"]}? (y/n) : " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]
        then
            eval "$function_to_run"
        fi

    else
        echo "Huh? That does not seem to be a valid choice!"
    fi
    
    read -p "return to cont : " varnotuse
}

function a_the_a_example() {
    echo "Test example a."
}
function b_the_example() {
    echo "Test example b."
}
function c_the_c_example() {
    echo "Test example c."
}
function d_the_d_example() {
    echo "Test example d."
}

function A_the_a_example() {
    echo "TEST EXAMPLE A!"
}
function B_the_example() {
    echo "TEST EXAMPLE B!"
}
function C_the_c_example() {
    echo "TEST EXAMPLE C!"
}
function D_the_d_example() {
    echo "TEST EXAMPLE D!"
}

offer_and_execute_options_available
