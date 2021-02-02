#!/bin/bash

CONFIG="$1"
COMMAND="$2"


File=README.md



if [ -f "$File" ] 
then
	tput bold; tput setaf 2; echo "$File exitsts."
    exit 1
else 
	tput setaf 1; echo "No file with the name $File can be found here is a list of files."
                   
    tput bold; tput setaf 2; ls
    exit 1
fi

#these does work just need to uncomment them

#read -p "Please enter the File you are looking for : " File 
#if [ -f "$File" ] 
#then
#	tput bold; tput setaf 2; echo "$File exitsts."
#   exit 1
#else 
#	tput setaf 1; echo "No file with the name $File can be found here is a list of files."
                   
#    tput bold; tput setaf 2; ls
#   exit 1    
#fi

#GoAgain=1
#while [ $GoAgain -ne 2 ]
#do 
#    read -p "Please enter the File you are looking for : " File 
#    if [ -f "$File" ] 
#        then
#    	tput bold; tput setaf 2; echo "$File exitsts."
#          exit 1
#    else 
#        tput setaf 1; echo "No file with the name $File can be found here is a list of files."
#        tput bold; tput setaf 2; ls
    
#    read -p "Do you want to try again? (y/n) " again 
#       if [[ "$again" =~ ^([yY])$ ]]
#            then
#                GoAgain=1
#            else 
#                exit 1
#        fi

    fi
done


if [ $# -ne 2 ]
then
    echo "ERROR: $0 requires two paramters {virtual-host} {restart|reload}"
    exit 1
fi

# reload is allowed
if [ "$COMMAND" == "reload" ] || [ "$COMMAND" == "restart" ]
then
    # Move the current execution state to the proper directory
    cd /etc/apache2/sites-available

    # Disable a vhost configuration
    sudo a2dissite "$CONFIG"
    sudo service apache2 "$COMMAND"

    # Enable a vhost configuration
    sudo a2ensite "$CONFIG"
    sudo service apache2 "$COMMAND"
else
    echo "ERROR: $COMMAND is an invalid service command {restart|reload}"
    exit 1
fi

