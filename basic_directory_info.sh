#!/bin/bash

#start date: 2016-04-01
#last modified date: 2016-04-15

#script description#
#The script accounts for any contents of nested subdirectories
#The script requires a single argument (must be a directory) and reports the following information while excluding any hidden files/directories:
#1. Total number of directories that are in the given directory
#2. Total number of files in all the directories starting from the given argument directory name
#3. Total number of files/directories in the given directory that are readable 
#4. Total number of files/directories in the given directory that are writable
#5. Total number of files/directories in the given directory that are executable

#function#
directory() {
	find . -type d \( ! -path '*/.*' ! -name "." \) | wc -l 
	#find files with type directory which excludes any hidden files/directories
}
file() {
	find . -type f \( ! -path '*/.*' \) | wc -l 
	#find files with type regular which excludes any hidden files/directories
}
readable() {
	find . -readable \( ! -path '*/.*' ! -name "." \) | wc -l 
	#find files/directories that is readable and exclude any hidden files/directories
}
writable() {
	find . -writable \( ! -path '*/.*' ! -name "." \) | wc -l 
	#find files/directories that is writable and exclude any hidden files/directories
}
executable() {
	find . -executable \( ! -path '*/.*' ! -name "." \) | wc -l 
	#find files/directories that is executable and exclude any hidden files/directories
}

#here document#
cat << EOF
-----------------------------------------------------------------------------------------------
Created by: Ray Krishardi Layadi
Student ID: 26445549

SYNTAX:
basic_directory_info.sh [directory_name]
-----------------------------------------------------------------------------------------------
EOF

echo "" #throws a new line after here document

if [ $# -eq 0 -o $# -gt 1 ] #check the number of argument given by the user
then
	echo "usage: basic_directory_info.sh [directory_name]"
	exit 1
elif [ -d $1 ] #check whether the given argument is a directory
then
	cd $1
	echo "number of directories: `directory`"
	echo "number of files: `file`"
	echo "number of readable files/directories: `readable`"
	echo "number of writable files/directories: `writable`"
	echo "number of executable items: `executable`"
else #if the given argument is NOT a directory
	echo "$1: no such directory"
	exit 1
fi
