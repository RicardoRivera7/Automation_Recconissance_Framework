#!/bin/bash
# @Author: RicardoRivera
# @Date:   2025-10-31 21:56:45
# @Last Modified by:   RicardoRivera
# @Last Modified time: 2025-10-31 21:56:45
#
#	Automation Reconnaissance Framework
#	====================================
#	This is a framework used for easy reconnasisance of systems, including port scanning, host discovery, fuzzing, and more!



#Internal Variables (don't change)
RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
YELLOW="$(tput setaf 3)"
MAGENTA="$(tput setaf 5)"
LIME="$(tput setaf 40)"
BLUE="$(tput setaf 33)"
NC="$(tput sgr0)"

#Reads in the env file for any additional options that were toggled at the start
source ./additionaloptions.env


# compiles all functions together 
	function main()
	{
		
		Aesthetic
		
		intro_banner
		
		show_options
		
		
		exec bash AutoReconF.sh

		exit 0

	}
	
	
# Makes the program look a little nicer and lets user know its running
	function Aesthetic()
	{
		
		echo -e "\033[1;34m$(figlet -w 80 'Auto Reconissance Framework')\033[0m"
	}
	
	
# Handles any unknown errors and aborts the script in case
	function ErrorHandler()
	{
		echo "$0:${RED} An Unknown Error has occured :( aborting Script... ${NC}"
		exit -1
	}


# If user wants to quit the script	
	function quit()
	{
		if [[ $which_recon == "exit" || $which_recon == "Exit" || $which_recon == "EXIT" ]]; then
			echo "$0:${RED} Exiting Script... ${NC}"
			exit -1
		fi
	}
	

	
# Opens the type of recon script based on earlier choice (Example: if nmap chosen opens the port scanning script)	
	function use_option()
	{
	
		
		
		if [[ $which_recon == "nmap" || $which_recon == "portscanning" ]]; then
		   	exec bash PortScanning.sh
		elif [[ $which_recon == "wfuzz" || $which_recon == "fuzzing" ]]; then
			exec bash AutoFuzzing.sh
		elif [[ $which_recon == "dm" || $which_recon == "deep magic" || $which_recon == "deep magic information gathering" ]]; then
			exec bash AutoDeepMagic.sh
		elif [[ $which_recon == "hd" || $which_recon == "host discovery" ]]; then
			exec bash AutoHostDisc.sh
		elif [[ $which_recon == "ao" || $which_recon == "additional options" ]]; then
			additional_options_menu
		fi
	
	}
	
# Intro banner for the user
	function intro_banner()
	{
		
        	echo 
        	echo
        	echo -e "\033[1;36m====================================================================\033[0m"
		echo -e "\033[1;36m Please choose an option! To choose enter what's in the parentheses \033[0m"
		echo -e "\033[1;36m====================================================================\033[0m"
	}
        
# Shows the user what options they have for recon       
        function show_options()
        {
        
        	echo
        	echo "Portscanning (${LIME}nmap${NC})"
        	echo "Fuzzing (${LIME}wfuzz${NC})"
        	echo "Deep Magic Information Gathering (${LIME}DM${NC})"
        	echo "Host Discovery (${LIME}HD${NC})"
        	echo
        	echo
        	echo "Additional Options (${LIME}AO${NC})"
        	echo
        	
        	read -p "${LIME}ARF>${NC}	" which_recon || ErrorHandler
        	which_recon="${which_recon,,}"
        	echo
        	
        	quit
        	use_option
        	
            
        }
        
# Shows user any additional options that can be configured or toggled such as outputting results to files
	function additional_options_menu
	{
	
		echo "Choose what you want to configure"
		echo
		echo
		echo "           ${BLUE}Option${NC}		|     ${BLUE}Current Status${NC}"
		echo "========================================================="
		echo " Output results to Files (${LIME}F${NC})    |	   ${RED}$isfileon${NC} "
		echo " Filename for output (${LIME}FN${NC}) 	|	   ${RED}$filename${NC} "
		echo " Path of results File (${LIME}FP${NC}) 	|	   ${RED}$filepath${NC} "
		
		
		echo
		echo
		echo "${BLUE}To leave enter: ${LIME}exit${NC}"
		echo "${RED}If you wish to reset all values to default then enter: ${LIME}Reset${NC}"
		echo
		echo
		
		read -p "${LIME}ARF>${NC}	" which_option || ErrorHandler
		
		which_option="${which_option,,}"
		if [[ $which_option == "exit" ]]; then
			intro_banner
			show_options
		elif [[ $which_option == "reset" ]]; then
			cp ./additionaloptions.env.default ./additionaloptions.env
			source ./additionaloptions.env
		fi
		
		adjust_options
	
	
	
	}
	
# Sets the options to what the user wnats and sets the current status	
	function adjust_options
	{
	
		
		
		case $which_option in
		
		"f" ) 
		
			echo "Would you like to toggle 'Output Results to File' on: ${LIME}yes${NC} or  ${RED}no${NC}"
			echo
			read -p "${LIME}ARF>${NC}	" filetoggle || ErrorHandler
			if [[ $filetoggle == "Yes" || $filetoggle == "yes" ]]; then
				#echo "export isfileon=\"true\"" > ./additionaloptions.env
				sed -i 's/^export isfileon=.*/export isfileon="true"/' ./additionaloptions.env
				source ./additionaloptions.env
			elif [[ $filetoggle == "No" || $filetoggle == "NO" || $filetoggle == "no" ]]; then
				#echo "export isfileon=\"false\"" > ./additionaloptions.env
				sed -i 's/^export isfileon=.*/export isfileon="false"/' ./additionaloptions.env
				source ./additionaloptions.env
			fi
			
		;;
		
		"fn")
			
			echo "What would you like to name your file? No need to add .txt to the end"
			echo
			read -p "${LIME}ARF>${NC}	" getfilename || ErrorHandler
			sed -i "s/^export filename=.*/export filename=\"$getfilename.txt\"/" ./additionaloptions.env
			#echo "export filename=\"$getfilename.txt\"" > ./additionaloptions.env
			source ./additionaloptions.env
		;;
		
		"fp")
		
			echo "What path would you like your file to save to?"
			echo
			read -p "${LIME}ARF>${NC}	" getfilepath || ErrorHandler
			sed -i "s|^export filepath=.*|export filepath=\"$getfilepath\"|" ./additionaloptions.env
			source ./additionaloptions.env
		;;
			
	  esac	
	
	additional_options_menu
	
	
	}
	

	


	
main $0
