#!/bin/bash
############################################################
# Help                                                     #
############################################################
Help()
{
   # Display Help
   echo "Usage: $0 [-h|u|s|k]"
   echo "options:"
   echo "h	Print this Help"
   echo "u	User Name"
   echo "s	Pub Key (string)"
   echo "k	Pub Key (filename)"
   echo
}

############################################################
############################################################
# Main program                                             #
############################################################
############################################################
set -e

# UserName=''
# Key=''

# Get the options
while getopts h:u:s:k: option; do
   case ${option} in
      h) # display Help
         Help
         exit;;
      u) # Enter a name
         UserName=${OPTARG};;
      s) # Pub Key (string)
			Key=${OPTARG};;
		k) # ub Key (filename)
			echo "${OPTARG}"
			Key=`cat ${OPTARG}`;;
		\?) # Invalid option
       	echo "Error: Invalid option"
         Help
       	exit;;
   esac
done


if [ -z "${UserName}" ] || [ -z "${Key}" ]
then
	echo "$0 - Error! Username or Key not set"
	Help
	exit
else
	echo "Vars set and now starting $0 shell script..."
fi

echo "Installing pub key for ${UserName}...";
# echo "$Key"

sudo mkdir -p /home/${UserName}/.ssh
sudo touch /home/${UserName}/.ssh/authorized_keys

sudo chmod 700 /home/${UserName}/.ssh
sudo chmod 600 /home/${UserName}/.ssh/authorized_keys

sudo chown -R ${UserName}:${UserName} /home/${UserName}/.ssh
echo ${Key} | sudo tee -a /home/${UserName}/.ssh/authorized_keys > /dev/null

echo "Complete!";