#!/bin/bash

#start date: 2016-04-01
#last modified date: 2016-04-15

#script description#
#The script includes any hidden files/directories (except ".") and descend 1 level of directories below the command line arguments
#The script reports the following information which relates to the options (-fxldrs) given by the user:
#1. Total number of ordinary (non-executable) files (-f)
#2. Total number of executable files (-x)
#3. Total number of links (-l)
#4. Total number of directories (-d)
#5. Total number of the four types of file for all the subdirectories depending on the file types specified (-r)
#6. Total file space occupied including all the files and subdirectories (-s)

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
size=false
recursive=false

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

size() {
du -sh . | cut -f1 
#display the total file size of a given directory including all its files and subdirectories in a human readable format (byte (B), kilobyte (K), megabyte (M), gigabyte (G), and terabyte (T))
#only the first field of character of the output will be displayed
}

#here document#
cat << EOF
-----------------------------------------------------------------------------------------------
Created by: Ray Krishardi Layadi
Student ID: 26445549

SYNTAX:
more_detailed_directory_info.sh [-fxldrs] [directory_name...]

OPTIONS:
-f -- display only the count of ordinary files
-x -- display only the count of executable files
-l -- display only the count of links
-d -- display only the count of directories
-r -- display the counts of the four types of file for all the subdirectories depending on the file types specified
-s -- display the total file space occupied including all the files and subdirectories
-----------------------------------------------------------------------------------------------
EOF

echo "" #throws a new line after here document

while getopts :fxldrs opt #repeatedly check for the valid option and specify that getopts run in silent mode
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
	r)	
		recursive=true
	;;
	s)
		size=true
	;;
	?) #getopts will return "?" if invalid argument is given
		echo "more_detailed_directory_info: illegal option -$OPTARG"
		echo "usage: more_detailed_directory_info.sh [-fxldrs] [directory_name...]"
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
			if [ $recursive = true ] #check if the -r option is invoked
			then	
				#counts the four types of file for the given directory and its subdirectories
				ordinary=true
				executable=true
				link=true
				directory=true
				
				listOfDirectories=`find $argument -type d` #assign the given directory and its subdirectories to the variable 

				for directories in $listOfDirectories #repeatedly process the given directory and its subdirectories
				do
					stringFormat="$directories: " 
					#assign the name of the given directory and its subdirectories for each iteration
					
					if [ $ordinary = true ]
                    			then
						cd $directories
						stringFormat+="ordinary: "
						stringFormat+="`ordinary` "
						cd $pwd
						optionCounter=`expr $optionCounter + 1`
                    			fi
                    			if [ $executable = true ]
                    			then
						cd $directories
						stringFormat+="executable: "
						stringFormat+="`executable` "
						cd $pwd
						optionCounter=`expr $optionCounter + 1`
                    			fi
                    			if [ $link = true ]
                    			then
						cd $directories
						stringFormat+="link: "
						stringFormat+="`link` "
						cd $pwd
						optionCounter=`expr $optionCounter + 1`
                    			fi
                    			if [ $directory = true ]
                    			then
						cd $directories
						stringFormat+="directory: "
						stringFormat+="`directory` "
						cd $pwd
						optionCounter=`expr $optionCounter + 1`
                    			fi
                    			if [ $size = true ] #check if the -s option is invoked
                    			then
						cd $directories
						stringFormat+="size: "
						stringFormat+="`size` "
						cd $pwd
						optionCounter=`expr $optionCounter + 1`
                    			fi
                    			echo "$stringFormat" #display the appropriate string
				done
			else
				#if the option -r is NOT invoked#
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
				if [ $size = true -a ! $ordinary = true -a ! $executable = true -a ! $link = true -a ! $directory = true ] 
				#display all 4 types including the total file size for the given directory if ONLY the -s option is invoked
				then
					cd $argument
					stringFormat+="ordinary: `ordinary` executable: `executable` link: `link` directory: `directory` size: `size`"
					cd $pwd
					optionCounter=`expr $optionCounter + 1`
				elif [ $size = true ] #if other options are also invoked (-fs), display the appropriate string
				then
					cd $argument
					stringFormat+="size: "
					stringFormat+="`size` "
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
