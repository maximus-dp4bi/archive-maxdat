#!/bin/bash

# determine shell to use
if [[ $SHELL = "/bin/bash" ]]
then
	echo "got bash"
	. ~/.bash_profile
elif [[ $SHELL = "/usr/bin/ksh" ]]
then
	echo "got korn"
	. ~/.profile
else
	echo "unknown shell:  exiting"
	exit 1
fi
