#!/bin/bash

#start date: 2016-04-01
#last modified date: 2016-04-15

#script description#
#The script includes any hidden files/directories (except ".") and descend 1 level of directories below the command line arguments
#The script reports the following information which relates to the options (-fxld) given by the user:
#1. Total number of ordinary (non-executable) files (-f)
#2. Total number of executable files (-x)
#3. Total number of links (-l)
#4. Total number of directories (-d)

#variables#
#if variables are not initialised, when comparing the value there might be "unary operator expected error"
pwd=`pwd` #keep track of the current working directory
numberOfInvalidDir=0 #keep track of the number of invalid directory
stringFormat="" #generate the string to be displayed depending on the options
optionCounter=0 #keep track of the number of option invoked by the user
ordinary=false
executable=false
link=false
directory=false

#function#
ordinary() {
find . -maxdepth 1 -type f ! -executable | wc -l 
#find files with type regular and non executable within 1 level of directories below the command line arguments
}

executable() {
find . -maxdepth 1 -type f -executable | wc -l 
#find files with type regular and executable within 1 level of directories below the command line arguments
}

link() {
find . -maxdepth 1 -type l | wc -l 
#find files with type link within 1 level of directories below the command line arguments
}

directory() {
find . -maxdepth 1 -type d \( ! -name "." \) | wc -l 
#find files with type directory and exluding "." directory within 1 level of directories below the command line arguments
}

#here document#
cat << EOF
-----------------------------------------------------------------------------------------------
Created by: Ray Krishardi Layadi
Student ID: 26445549

SYNTAX:
detailed_directory_info.sh [-fxld] [directory_name...]

OPTIONS:
-f -- display only the count of ordinary files
-x -- display only the count of executable files
-l -- display only the count of links
-d -- display only the count of directories
-----------------------------------------------------------------------------------------------
EOF

echo "" #throws a new line after here document


while getopts :fxld opt #repeatedly check for the valid option and specify that getopts run in silent mode
do
	case $opt in #determine the option specified by the user
	f)
		ordinary=true
	;;
	x)
		executable=true
	;;
	l)
		link=true
	;;
	d)
		directory=true
	;;
	?) #getopts will return "?" if invalid argument is given
		echo "detailed_directory_info: illegal option -$OPTARG"
		echo "usage: detailed_directory_info.sh [-fxld] [directory_name...]"
		exit 1
	;;
	esac
done

shift `expr $OPTIND - 1` #remove the selected options


if [ $# -eq 0 ] #check the number of argument given by the user
then
	echo ".: ordinary: `ordinary` executable: `executable` link: `link` directory: `directory`" 
	#display all 4 types for current directory if no argument is given
else
	for argument #repeatedly check for each argument specified by the user
	do
		if [ -d $argument ] #check whether the given argument is a directory
		then
			stringFormat="$argument: " #assign the name of the given directory for each iteration
			
			if [ $ordinary = true ] #check if the -f option is invoked
			then
				cd $argument
				stringFormat+="ordinary: "
				stringFormat+="`ordinary` "
				cd $pwd
				optionCounter=`expr $optionCounter + 1`
			fi
			
			if [ $executable = true ] #check if the -x option is invoked
            		then
				cd $argument
				stringFormat+="executable: "
				stringFormat+="`executable` "            
				cd $pwd
                		optionCounter=`expr $optionCounter + 1`
			fi
			
			if [ $link = true ] #check if the -l option is invoked
            		then
				cd $argument
				stringFormat+="link: "
				stringFormat+="`link` "            
				cd $pwd
				optionCounter=`expr $optionCounter + 1`
			fi
			
			if [ $directory = true ] #check if the -d option is invoked
            		then
				cd $argument
				stringFormat+="directory: "
				stringFormat+="`directory` "            
				cd $pwd
				optionCounter=`expr $optionCounter + 1`
			fi
			
			if [ $optionCounter -eq 0 ] #display all 4 types for the given directory if no option is invoked
            		then
				cd $argument
				echo "$argument: ordinary: `ordinary` executable: `executable` link: `link` directory: `directory`"
				cd $pwd
			else #display the appropriate string if at least one option is invoked
				echo "$stringFormat"
            		fi
            
		else #if the given argument is NOT a directory
			echo "$argument: no such directory"
			numberOfInvalidDir=`expr $numberOfInvalidDir + 1`
		fi
	done
	
	if [ $numberOfInvalidDir -eq $# ] #display all 4 types for current directory if all given directories are invalid
	then
		echo ".: ordinary: `ordinary` executable: `executable` link: `link` directory: `directory`"
	fi

fi
