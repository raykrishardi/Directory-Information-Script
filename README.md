# Bash Directory Information Scripts

# About the project:
This project is my first assignment for the FIT2065 (Operating Systems and The Unix Environment) unit which contains 3 scripts that display information about a particular directory or directories depending on the options given by the user. The project contains the following scripts:

## 1. basic_directory_info.sh (inc. help/usage file)
### Description:
- The script accounts for any contents of nested subdirectories
- The script requires a single argument (must be a directory) and reports the following information while excluding any hidden files/directories:
  1. Total number of directories that are in the given directory
  2. Total number of files in all the directories starting from the given argument directory name
  3. Total number of files/directories in the given directory that are readable 
  4. Total number of files/directories in the given directory that are writable
  5. Total number of files/directories in the given directory that are executable
   
### Syntax:
    basic_directory_info.sh [directory_name]

### Examples:
    $ basic_directory_info.sh
    usage: basic_directory_info.sh [directory_name]

    $ basic_directory_info.sh dir1 dir2
    usage: basic_directory_info.sh [directory_name]

    $ basic_directory_info.sh dir1
    dir1: no such directory

    $ basic_directory_info.sh dir2
    number of directories: 1
    number of files: 1
    number of readable files/directories: 1
    number of writable files/directories: 1
    number of executable items: 1
    
## 2. detailed_directory_info.sh (inc. help/usage file)
### Description:
- The script includes any hidden files/directories (except ".") and descends 1 level of directories below the command line arguments
- The script reports the following information which relates to the options (-fxld) given by the user:
  1. Total number of ordinary (non-executable) files (-f)
  2. Total number of executable files (-x)
  3. Total number of links (-l)
  4. Total number of directories (-d)
   
### Syntax:
    detailed_directory_info.sh [-fxld] [directory_name...]

### Options:
    -f -- display only the count of ordinary files
    -x -- display only the count of executable files
    -l -- display only the count of links
    -d -- display only the count of directories

### Examples:
    $ detailed_directory_info.sh
    .: ordinary:10 executable:9 link:3 directory:5

    $ detailed_directory_info.sh dir1 dir2
    dir1: ordinary:2 executable:8 link:7 directory:32
    dir2: ordinary:8 executable:17 link:5 directory:16

    $ detailed_directory_info.sh dir1 dir2
    dir1: ordinary:2 executable:8 link:7 directory:32
    dir2: no such directory

    $ detailed_directory_info.sh dir1 dir2
    dir1: no such directory
    dir2: no such directory
    .: ordinary:10 executable:9 link:3 directory:5

    $ detailed_directory_info.sh -k
    detailed_directory_info: illegal option -k
    usage: detailed_directory_info.sh [-fxld] [directory_name...]

    $ detailed_directory_info.sh -xd dir1
    dir1: executable:8 directory:42
 
 ## 3. more_detailed_directory_info.sh (inc. help/usage file)
### Description:
- The script includes any hidden files/directories (except ".") and descend 1 level of directories below the command line arguments
- The script reports the following information which relates to the options (-fxldrs) given by the user:
  1. Total number of ordinary (non-executable) files (-f)
  2. Total number of executable files (-x)
  3. Total number of links (-l)
  4. Total number of directories (-d)
  5. Total number of the four types of file for all the subdirectories depending on the file types specified (-r)
  6. Total file space occupied including all the files and subdirectories (-s) in a human readable format (byte (B), kilobyte (K), megabyte (M), gigabyte (G), and terabyte (T))
   
### Syntax:
    more_detailed_directory_info.sh [-fxldrs] [directory_name...]

### Options:
    -f -- display only the count of ordinary files
    -x -- display only the count of executable files
    -l -- display only the count of links
    -d -- display only the count of directories
    -r -- display the counts of the four types of file for all the subdirectories depending on the file types specified
    -s -- display the total file space occupied including all the files and subdirectories in a human readable format (byte (B), kilobyte (K), megabyte (M), gigabyte (G), and terabyte (T))

### Examples:
    $ more_detailed_directory_info.sh
    .: ordinary:10 executable:9 link:3 directory:5

    $ more_detailed_directory_info.sh dir1 dir2
    dir1: ordinary:2 executable:8 link:7 directory:32
    dir2: ordinary:8 executable:17 link:5 directory:16

    $ more_detailed_directory_info.sh dir1 dir2
    dir1: ordinary:2 executable:8 link:7 directory:32
    dir2: no such directory

    $ more_detailed_directory_info.sh dir1 dir2
    dir1: no such directory
    dir2: no such directory
    .: ordinary:10 executable:9 link:3 directory:5

    $ more_detailed_directory_info.sh -k
    more_detailed_directory_info: illegal option -k
    usage: more_detailed_directory_info.sh [-fxldrs] [directory_name...]

    $ more_detailed_directory_info.sh -xd dir1
    dir1: executable:8 directory:42

    $ more_detailed_directory_info.sh -R
    more_detailed_directory_info: illegal option -R
    usage: more_detailed_directory_info.sh [-fxldrs] [directory_name ...]

    $ more_detailed_directory_info.sh -r dir1
    dir1: ordinary:8 executable:6 link:2 directory:2
    dir1_a: ordinary:4 executable:3 link:1 directory:0
    dir1_b: ordinary:10 executable:6 link:0 directory:1
    dir1b_a: ordinary:2 executable:0 link:0 directory:0

    $ more_detailed_directory_info.sh -s dir1 dir2
    dir1: ordinary:2 executable:8 link:7 directory:32 size:25M
    dir2: ordinary:8 executable:17 link:5 directory:16 size:648K

    $ more_detailed_directory_info.sh -xds dir1
    dir1: executable:8 directory:32 size:25M
