#!/bin/bash
# @Author: RicardoRivera
# @Date:   2025-11-01 12:13:14
# @Last Modified by:   RicardoRivera
# @Last Modified time: 2025-11-01 12:13:14
#
#	Automation for Fuzzing
#	======================
#	This is a script to auto fuzz from a pre selected list and let's you adjust where you want it fuzzed



#Internal Variables (don't change)
RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
YELLOW="$(tput setaf 3)"
MAGENTA="$(tput setaf 5)"
LIME="$(tput setaf 40)"
NC="$(tput sgr0)"

#Reads in the env file for any options at the start
source ./additionaloptions.env


# compiles all functions together 
	function main()
	{
		
		Aesthetic
		
		get_target
		
		what_level
		
		do_deepmagic
		
		exec bash AutoReconF.sh

		exit 0

	}
	
	
# Makes the program look a little nicer and lets user know its running
	function Aesthetic()
	{
		
		echo "$0:${GREEN}"
		echo " ------------------------------------------------"
		echo "|                                                 |"
		echo "|                                                 |"
		echo "|                                                 |"
		echo "|${MAGENTA}               Starting Deep Magic Tool... ${NC}${GREEN}      |"
		echo "|                                        	  |"
		echo "|                                                 |"
		echo "|${MAGENTA}                Please Wait :)               ${NC}${GREEN}    |"
		echo "|                                                 |"
		echo " ------------------------------------------------ ${NC}"
	}
	
	
# Handles any unknown errors and aborts the script in case
	function ErrorHandler()
	{
		echo "$0:${RED} An Unknown Error has occured :( aborting Script... ${NC}"
		exit -1
	}

	
        
# Asks the user for the target they want to gather infor on  
        function get_target()
        {
        
     		echo "Who Would you like to look up? Enter the IP"
     		echo
        	read -p "${LIME}ARF>${NC}	" deep_target || ErrorHandler
        	echo
        	
            
        }
        
        
# Lets the user pick what kind of level of info that they want from the Deep Magic
	function what_level()
	{
	
		
		echo
		echo "Basic (${LIME}B${NC})"
		echo "Medium (${LIME}M${NC})"
		echo "Deep (${LIME}D${NC})"
		echo
		echo
		
		read -p "${LIME}ARF>${NC}	" leveltype || ErrorHandler
		echo
		
		leveltype="${leveltype,,}"
		if [[ $leveltype == "b" || $leveltype == "basic" ]]; then
		   	chosentype="Basic"
		elif [[ $leveltype == "m" || $leveltype == "medium" ]]; then
		   	chosentype="Medium"
		elif [[ $leveltype == "d"  || $leveltype == "deep" ]]; then  
			chosentype="Deep"
		fi
	
	
	}
	
	
# Runs the Deep magic tool based on the previous option selected
	function do_deepmagic()
	{
		
		ErrorHandler=ErrorHandler
	
		case $isfileon in
	
			"true")
		
				case $chosentype in
		
					"Basic") 
		
						dmitry -i -w -o $filepath$filename $deep_target || ErrorHandler
			
			
					;;
		
		
					"Medium")
		
						dmitry -i -w -s -e -o $filepath$filename $deep_target || ErrorHandler
			
					;;
		
		
					"Deep")
		
						dmitry -i -w -n -s -e -o $filepath$filename $deep_target || ErrorHandler
					;;
	 			 esac
	 		;;
	 		
	 		"false")
	 		
	 			case $chosentype in
		
					"Basic") 
		
						dmitry -i -w $deep_target || ErrorHandler
			
			
					;;
		
		
					"Medium")
		
						dmitry -i -w -s -e $deep_target || ErrorHandler
			
					;;
		
		
					"Deep")
		
						dmitry -i -w -n -s -e $deep_target || ErrorHandler
					;;
	 			 esac
	 		;;
	 	esac
	}
	
	
		
		

		
	
	





	
main $0
