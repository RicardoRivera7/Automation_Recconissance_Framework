#!/bin/bash
# @Author: RicardoRivera
# @Date:   2025-10-31 21:56:45
# @Last Modified by:   RicardoRivera
# @Last Modified time: 2025-10-31 21:56:45
#
#	Nmap Scanner for Inital Reconnaissance
#	======================================
#	A script that allows the user to choose between a deep scan, a Medium scan or a quick scan. Allows the user to also toggle for UDP scanning.



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
		
		get_ip
		
		scan_type
		
		level_of_scanning
		
		nmap_scans
		
		
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
		echo "|${MAGENTA}               Starting Scan... ${NC}${GREEN}	          |"
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
	
	
# Lets the user choose the Type of Scan: UDP or TCP
	function scan_type()
	{

		echo "Please choose your type of scan:"
		echo "TCP (${LIME}T${NC})"
		echo "UDP (${LIME}U${NC})"
		echo
		
		read -p "${LIME}ARF>${NC}		" scan_type || ErrorHandler
		scan_type="${scan_type,,}"
		echo
		
		if [[ $scan_type == "t" || $scan_type == "tcp" ]]; then
		   Typeis="TCP"
		elif [[ $scan_type == "u" || $scan_type == "udp" ]]; then
		   Typeis="UDP"
		fi
		
	}
	
# Lets the user choose between how deep of a scan they want to do: Quick, Medium, or Deep	
	function level_of_scanning()
	{
		
		echo "What Kind of a scan would you like?"
		echo "Deep (${LIME}D${NC})"
		echo "Medium (${LIME}M${NC})"
		echo "Quick (${LIME}Q${NC})"
		echo 
		
		read -p "${LIME}ARF>${NC}	" level_type || ErrorHandler
		level_type="${level_type,,}"
		echo
		
		
		if [[ $level_type == "d" || $level_type == "deep" ]]; then
		   	levelis="Deep"
		elif [[ $level_type == "m" || $level_type == "medium" ]]; then  
			levelis="Medium"
		elif [[ $level_type == "q" || $level_type == "quick" ]]; then  
			levelis="Quick"
		fi
	
	}

        
# Asks the user for the target IP        
        function get_ip()
        {
        
     		echo "What is the IP of your target?  Enter IP:"
     		read -p "${LIME}ARF>${NC}		" enter_ip || ErrorHandler
        	echo
        	
            
        }

# Takes the previous scan and level types entered and perfroms scans based on what the user asked
	function nmap_scans()
	{
		ErrorHandler=ErrorHandler
		
		
		case $isfileon in
	
			"true")
				case $Typeis in
		
				"TCP") 
					if [ $levelis == "Deep" ]; then
						nmap -v -A -p- -oN $filepath$filename $enter_ip || ErrorHandler
					elif [ $levelis == "Medium" ]; then
						nmap -v -A --top-ports 10000 -oN $filepath$filename $enter_ip || ErrorHandler
					elif [ $levelis == "Quick" ]; then
						nmap -v -A --top-ports 1000 -oN $filepath$filename $enter_ip || ErrorHandler
					fi
				;;
		
		
				"UDP")
					if [ $levelis == "Deep" ]; then
						nmap -v -A -sU -p- -oN $filepath$filename $enter_ip || ErrorHandler
					elif [ $levelis == "Medium" ]; then
						nmap -v -A -sU --top-ports 2500 -oN $filepath$filename $enter_ip || ErrorHandler
					elif [ $levelis == "Quick" ]; then
						nmap -v -A -sU --top-ports 500 -oN $filepath$filename $enter_ip || ErrorHandler
					fi
				;;
			
				esac
			;;
		
			"false")	
		
				case $Typeis in
		
				"TCP") 
					if [ $levelis == "Deep" ]; then
						nmap -v -A -p- $enter_ip || ErrorHandler
					elif [ $levelis == "Medium" ]; then
						nmap -v -A --top-ports 10000 $enter_ip || ErrorHandler
					elif [ $levelis == "Quick" ]; then
						nmap -v -A --top-ports 1000 $enter_ip || ErrorHandler	
					fi
			
				;;
		
		
				"UDP")
					if [ $levelis == "Deep" ]; then
						nmap -v -A -sU -p- $enter_ip || ErrorHandler
					elif [ $levelis == "Medium" ]; then
						nmap -v -A -sU --top-ports 2500 $enter_ip || ErrorHandler
					elif [ $levelis == "Quick" ]; then
						nmap -v -A -sU --top-ports 500 $enter_ip || ErrorHandler		
					fi
				;;
			
				esac
		 	;;
	  	esac	
	}
	
	
main $0
