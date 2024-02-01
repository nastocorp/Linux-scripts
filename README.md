Title: user_management.sh

This Bash script is designed for user management tasks based on a CSV file. It performs the following actions:

    It checks whether an argument (a CSV file) is provided when executing the script and displays an error message if not.

    The script reads each line from the CSV file, where each line contains information about a user, including first name, last name, password, and operation (add or remove).

    For each user entry in the CSV file, it generates a username by taking the first three letters from both the first name and last name.

    It creates an MD5-hashed password for each user's password provided in the CSV file.

    Depending on the specified operation (add or remove) for each user, the script performs the following actions:
        If the operation is "add":
            It checks if the user already exists in the system.
            If the user doesn't exist, it creates the user with a default Bash shell, a home directory, and sets the provided hashed password.
            It logs the user creation action to a log file.
        If the operation is "remove":
            It checks if the user exists in the system.
            If the user exists, it removes the user and, if the home directory exists, deletes it as well.
            It logs the user removal action to a log file.

Overall, this script automates the process of adding and removing users based on the information provided in a CSV file, using hashed passwords for security, and logs the actions for record-keeping.
