#!/bin/bash

# Assignment 1: User Management via Script
# Submission Date: 2023-10-11
# The script is located in /user/local/bin
# The script has root privileges
# You may need to install the whois package to generate
# password hashes for users.


#===============================
#                              |
#          CSV FILE            |
#                              |
#==============================|

# An if statement that checks if an argument is provided.
# If not, it displays an error message.

# If the argument is not a CSV file, it displays an error message.

if [ $# -ne 1 ]; then
  echo "ERROR!: Please provide a CSV file as an argument." >&2; exit 1
elif ! [[ "$1" == *.csv ]]; then
  echo "ERROR!: '$1' is not a valid CSV file!" >&2; exit 1
fi

# While loop that reads each line from the CSV file.
# The delimiter ',' is used to separate fields without spaces.
# IFS is set to ',' to use a comma as the delimiter.
# Usernames are created by taking the first three letters from the first name and last name.
# Generate an MD5-hashed password for each user.

while IFS="," read -r firstname lastname password operation; do
username="${firstname:0:3}${lastname:0:3}"
hash_pw=$(mkpasswd -m MD5 "$password")


    #============================================
    #                                           |
    #            ADD USER                       |
    #                                           |
    #============================================  

    # Check if the user already exists in the system.
    # Create the user with the default Bash shell and home directory if it doesn't exist,
    # and set the password for the user.
    # Display the user creation in standard output.
    # Send an error message if the user couldn't be added.

if [ "$operation" == "add" ]; then
{
if ! id "$username" &>/dev/null; then
      echo "-----------------------------------"
      echo -e "\e[1mAdding user:\e[0m $username"
      echo "-----------------------------------"
      sudo useradd -s /bin/bash "$username" -m -p "$hash_pw"
      echo "User $username has been added to the system" >> /usr/local/bin/user_mngt.log
      echo "Generating password hash for: $username ---> $hash_pw"
else
      echo "ERROR!: Could not add $username" >& /dev/null
    fi
}   
    #======================================
    #                                     |
    #          REMOVE USER                |
    #                                     |
    #====================================== 

    # Check if the user exists, if the home directory exists, and remove the user.
    # Remove the user and write the removal action to standard output and the log file.
    # Remove the user and their home directory if both exist in the system.
    # Display an error message if the user does not exist.
    # The code execution is based on the .csv file.

elif [ "$operation" == "remove" ]; then 
{
if id "$username" &> /dev/null; then
      echo "-----------------------------------"
      echo -e "\e[1mRemoving user:\e[0m $username"
      echo "-----------------------------------"
      sudo deluser "$username" 2> /dev/null #
      sudo rm -r "/home/$username" 2> /dev/null #
      echo "User: $username has been removed along with the home directory" >&2 >> /usr/local/bin/user_mngt.log
else
      echo "User: $username does not exist!" >&2> /dev/null        
fi
}
fi
done < "inl1_data.csv"
