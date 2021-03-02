#!/usr/bin/bash

# The only command line argument is a file name
file_name=$1
passed=true

# Iterate over each line of the input file
while IFS= read -r line; do
    if [[ $line =~ ^([[:space:]]*)([_[:alnum:]]+):([[:space:]])(.*+$) ]]; then
        field=${BASH_REMATCH[2]}
        value=${BASH_REMATCH[4]}
    else
        continue
    fi

    case $field in
        first_name)
            pattern='^[[:alpha:]]+$'
            ;;
        last_name)
            pattern='^[[:alpha:]]+$'
            ;;
        phone_number)
            pattern='^[0-9]{3}-[0-9]{3}-[0-9]{4}$'
            ;;
        email) 
            pattern='^[[:alnum:]_#-]+@[[:alnum:]-]+\.[[:alnum:]]{2,4}$'
            ;; 
        street_number)   
            pattern='^[0-9]{1,5}$'
            ;; # <1 to 5 digits>
        street_name)  
            pattern='^[[:alpha:] ]+$'
            ;; # <String of alphabetic characters where spaces are allowed>
        apartment_number)
            pattern='(^[0-9]{1,5})|($)'
            ;; # <1 to 4 digits or the empty string>
        city)   
            pattern='^[[:alpha:] ]+$'
            ;; #<String of alphabetic characters where spaces are allowed>
        state) 
            pattern='^[A-Z]{2}$'
            ;; #<2 capital letters>
        zip)  
            pattern='^[0-9]{5}$'
            ;; #<5 digits>
        card_number)
            pattern='^[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{4}$'
            ;; #<16 digits with a hyphen between every 4 digits>
        expiration_month)
            pattern='^(0[1-9]|1[0-2])$'
            ;; #<a number between 01 and 12>
        expiration_year)
            pattern='^(202[1-9])$'
            ;; #<a number greater than 2021 but strictly less than 2030>
        ccv)
            pattern='^[0-9]{3}$'
            ;; #<3 digits>
        *) # Case where there the field name didn't match anything
            continue
            ;;
    esac

    if ! [[ $value =~ $pattern ]]; then
        # We need to print out a message if the field isn't valid
        echo "field $field with value $value is not valid"
        passed=false
    fi
  
done < "$file_name"

# We need to print something if all fields were valid
# Remember, booleans are useful for this assignment
if [[ $passed = true ]]; then
    echo "purchase is valid"
    exit 0
fi
