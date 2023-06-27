#!/bin/bash

# Project Idea: File Organizer

# Description:
# Create a Bash script that organizes files in a specified directory based on their file extensions. The script should scan the target directory, identify each file's extension, and move them to corresponding folders based on their extensions.


tries=3
file_types=('tar' 'txt' 'sh' 'zip' 'png' 'jpg' 'pdf' 'deb' 'csv' 'mp4' 'mkv')


# Features:

#     Prompt the user to provide the target directory to organize.
directory(){
    declare -g get_directory
    while [ ! -d "$get_directory" ]; do
        read -e -p 'List the directory that needs to be organized: ' get_directory
        echo "$get_directory"
        if [ ! -d $get_directory ]; then
            echo "Directory does not exist. Please list the directories using 'ls' and try again. You have $tries attempts left."
            ((tries -= 1))
        fi
    done

    if [ -d "$get_directory" ]; then
        if [ ! -d "$get_directory/file_organizer" ]; then
            for i in "${file_types[@]}"; do
                mkdir -p "$get_directory/file_organizer/$i"
            done
        fi
    else
        echo "Directory does not exist. Please list the directories using 'ls' and try again. You have $tries attempts left."
        ((tries -= 1))
    fi

    declare -g ls_files
    lsfiles=`ls $get_directory`

}


#     Create separate folders for each unique file extension found in the target directory.
separate_folder() {
    while read -ra current_file; do
        # if ls grep .* mkdir if dir doesn't already exist then copy the file to that folder
        for i in "${file_types[@]}"; do
            if [[ $current_file =~ $i ]]; then
                mv "$get_directory/$current_file" "$get_directory/file_organizer/$i/$current_file"
                echo "currently moving $current_file"
            fi 
            
        done
    done <<<"$lsfiles"
}

#     Move each file to the appropriate folder based on its extension.



#     Display a summary of the files moved and their respective destinations.

directory
separate_folder
