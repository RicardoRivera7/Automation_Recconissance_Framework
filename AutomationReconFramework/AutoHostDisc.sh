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
		
		discovery_type
		
		host_discovery_scan
		
		
		exec bash AutoReconF.sh

		exit 0

	}
	
	
# Makes the program look a little nicer and lets user know its running
	function Aesthetic()
	{
		echo "$0:${MAGENTA}"
		echo " ------------------------------------------------"
		echo "|                                                 |"
		echo "|                                                 |"
		echo "|                                                 |"
		echo "|${YELLOW}             Starting Host Discovery... ${NC}${MAGENTA}         |"
		echo "|                                        	  |"
		echo "|                                                 |"
		echo "|${YELLOW}                Please Wait :)               ${NC}${MAGENTA}    |"
		echo "|                                                 |"
		echo " ------------------------------------------------ ${NC}"
	}
	
	
# Handles any unknown errors and aborts the script in case
	function ErrorHandler()
	{
		echo "$0:${RED} An Unknown Error has occured :( aborting Script... ${NC}"
		exit -1
	}
	
	
# Lets the user choose the type of host discovery that they would like to use
	function discovery_type()
	{

		echo "What method of discovery would you like to use:"
		echo "Basic - Ping (${LIME}B${NC})"
		echo "ARP - Local Networks (${LIME}ARP${NC})"
		echo "ICMP - Check if Host is Alive (${LIME}ICMP${NC})"
		
		read -p "${LIME}ARF>${NC}		" discovery_chosen || ErrorHandler
		discovery_chosen="${discovery_chosen,,}"
		echo
		
		if [[ $discovery_chosen == "b" || $discovery_chosen == "basic" ]]; then
		   Typeis="Basic"
		elif [[ $discovery_chosen == "arp" ]]; then
		   Typeis="ARP"
		elif [[ $discovery_chosen == "icmp" ]]; then
		   Typeis="ICMP"
		fi
		
	}
	

        
# Asks the user for the target IP and the range they want for host discovery        
        function get_ip()
        {
        
        	echo "What is the IP of your target?  Enter IP:"
     		read -p "${LIME}ARF>${NC}		" enter_ip || ErrorHandler
        	echo
        	echo
        	echo "What is the range you want to discover? Example: /24 ; /32"
        	echo
        	read -p "${LIME}ARF>${NC}		" range_ip || ErrorHandler
        	echo
        	
            
        }

# Takes the previous scan and level types entered and perfroms host discovery based on what the user asked
	function host_discovery_scan()
	{
		ErrorHandler=ErrorHandler
		
		
		case $isfileon in
	
			"true")
				case $Typeis in
		
				"Basic") 
						nmap -v -oN $filepath$filename -sn $enter_ip$range_ip || ErrorHandler
					
				;;
		
		
				"ARP")
					
						nmap -v -oN $filepath$filename -PR $enter_ip$range_ip || ErrorHandler
					
				;;
				
				"ICMP")
		
						nmap -v -oN $filepath$filename -PE $enter_ip$range_ip || ErrorHandler
					
				;;
			
				esac
			;;
		
			"false")	
		
				case $Typeis in
		
				"Basic") 
						nmap -v -sn $enter_ip$range_ip || ErrorHandler
					
				;;
		
		
				"ARP")
					
						nmap -v -PR $enter_ip$range_ip || ErrorHandler
					
				;;
				
				"ICMP")
		
						nmap -v -PE $enter_ip$range_ip || ErrorHandler
					
				;;
			
				esac
			
		 	;;
	  	esac	
	}
	
	
main $0
