#!/usr/bin/bash

target_dir=$1
mode=$2
shift 2


appendMode() {
    # Appends a new field to a given section with a field name and value
    # 
    # Args
    # $1: Section name
    # $2: New field name
    # $3: New field value
    find "$target_dir" -type f -name "*.ini" \
        -exec sed -i "/$1/ a $2 = $3" "{}" ";"
    return
}

deleteMode() {
    # Removes a field from the config file
    #
    # Args
    # $1: field_name

    find "$target_dir" -type f -name "*.ini" \
        -exec sed -i "/$1/d" "{}" ";" 
    return
}

subMode() {
    # Replaces the value of a particular field with a new one
    #
    # Args
    # $1: field name
    # $2: new_value
    find "$target_dir" -type f -name "*.ini" \
        -exec sed -i "s/.*$1.*/$1 = $2/g" "{}" ";"
    return
}

case $mode in

    '-a')
        appendMode "$@"
        ;;
    '-d')
        deleteMode "$@"
        ;;
    '-s')
        subMode "$@"
        ;;
    *)
        echo 'Unrecongized flag for first argument'
        exit 2
        ;;
esac
