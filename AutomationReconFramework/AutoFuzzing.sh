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
		
		get_fuzz_target
		
		which_wordlist
		
		do_fuzz
		
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
		echo "|${MAGENTA}               Starting Fuzzing... ${NC}${GREEN}	          |"
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

	
        
# Asks the user for the target they want to fuzz and the area where they want to fuzz      
        function get_fuzz_target()
        {
        
     		echo 'What would you like to Fuzz, Enter host and where you want to fuzz'
     		echo 'Example: 10.10.10.10/FUZZ or 10.10.10.10/index/FUZZ'
     		echo
        	read -p "${LIME}ARF>${NC}	" fuzz_target || ErrorHandler
        	echo
        	
            
        }
        
        
# What type of wordlist would the user like to use
	function which_wordlist()
	{
	
		echo "What kind of wordlist would you like to use?"
		echo
		echo "Megabeast (${LIME}MB${NC})"
		echo "Big (${LIME}B${NC})"
		echo "Medium (${LIME}M${NC})"
		echo "Common (${LIME}C${NC})"
		echo "Admin Panels (${LIME}AP${NC})"
		echo "Extensions Common (${LIME}EC${NC})"
		echo "Webservices Directories (${LIME}WD${NC})"
		echo
		echo
		
		read -p "${LIME}ARF>${NC}	" wordlist || ErrorHandler
		wordlist="${wordlist,,}"
		echo
		
		
		if [[ $wordlist == "mb" ]]; then
		   	chosenList="/usr/share/wfuzz/wordlist/general/megabeast.txt"
		elif [[ $wordlist == "b" ]]; then
		   	chosenList="/usr/share/wfuzz/wordlist/general/big.txt"
		elif [[ $wordlist == "m" ]]; then  
			chosenList="/usr/share/wfuzz/wordlist/general/medium.txt"
		elif [[ $wordlist == "c" ]]; then  
			chosenList="/usr/share/wfuzz/wordlist/general/common.txt"
		elif [[ $wordlist == "ap" ]]; then  
			chosenList="/usr/share/wfuzz/wordlist/general/admin-panels.txt"
		elif [[ $wordlist == "ec" ]]; then  
			chosenList="/usr/share/wfuzz/wordlist/general/extensions_common.txt"
		elif [[ $wordlist == "wd" ]]; then  
			chosenList="/usr/share/wfuzz/wordlist/webservices/ws-dirs.txt"
		fi
	
	
	}
	
	
# Runs the wfuzz based on the wordlist the user chose and where they wanted the fuzz
	function do_fuzz()
	{
		ErrorHandler=ErrorHandler
	
		case $isfileon in
			
			"true")
				wfuzz -Z -c -f $filepath$filename -z file,$chosenList --sc 200 $fuzz_target || ErrorHandler
			;;
			
			"false")
				wfuzz -Z -c -z file,$chosenList --sc 200 $fuzz_target || ErrorHandler
			;;
		esac
		

	
	}	
	
	





	
main $0
