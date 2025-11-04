# Automation_Recconissance_Framework

<h1>Description</h1>

This is a framework built to make intial recconissance of a maschine or system quick and easy. Features the following tool: wfuzz for fuzzing, nmap for port scanning and host discovery, Deep Magic for information gathering about the system and related entities. <br/>
Each option features options and allows for user input of target IPs and where to FUZZ. An additional options section is available, it displays current status of options, updates them and allows you to reset to default state. <br/>
Additional options allows the user to toggle file output results, the file path to save them at, setting the preferred file name.

<br/> 
<br/>

<h1>How to Use</h1>
The main script is <strong>AutoReconF.sh</strong> <br/>
Just CD into the file once downloaded and run the following command: <strong>bash AutoReconF.sh</strong> <br/> 
<br/>



<h1>Demo</h1>
<img src="https://i.imgur.com/0SEcYlc.gif" height="80%" width="80%" alt="AutoReconF"/>
<br/>
<br/>


<h1>Initial Screen</h1>
<img src="https://i.imgur.com/Uv6chux.png" height="80%" width="80%" alt="AutoReconF"/>
<br/>
<br/>

Here we have 5 options to choose from including, portscanning, fuzzing, host disocvery and deep magic info gathering <br/>
The last option: Additional options allwos for the configuration of a few settings if the user wants them <br/>
You can select options by typing what's in the parantheses or you can type the method: for example instead of namp you can use portscanning to select it <br/>
<br/>
<br/>

<h1>Additional Options</h1>
<img src="https://i.imgur.com/gxa9eHk.png" height="80%" width="80%" alt="AutoReconF"/>
<br/>
<br/>

Here you can toggle on the option to have any of the recon methods to save a output file of your results <br/>
With this come the additional options to set the name of the file that outputs the results <br/>
You can also set the path that you wish for the file to be saved too <br/>
There is also an option to reset all of your changes back to the default <br/>
<img src="https://i.imgur.com/yAKJbcO.png" height="80%" width="80%" alt="AutoReconF"/>
<br/>
<br/>


<h1>PortScanning with Nmap</h1>
<img src="https://i.imgur.com/Id9Mg27.png" height="80%" width="80%" alt="AutoReconF"/>
<br/>
<br/>

Here you can set your target IP and the type of scan wanted as well between UDP and TCP <br/>
You can choose how big of a scan you want between 3 options of quick, medium, or deep <br/>


<h1>Fuzzing with wfuzz</h1>
<img src="https://i.imgur.com/anqgzDC.png" height="80%" width="80%" alt="AutoReconF"/>
<br/>
<br/>


Here you can fuzz for any spots you want, just give the target IP nad apply the word FUZZ where you want the magic to happen <br/>
You also get a lot of options to choose between the available wordlists that you want to try <br/>

<br/>
<br/>


<h1>Information Gathering with Deep Magic</h1>
<img src="https://i.imgur.com/RWDpizL.png" height="80%" width="80%" alt="AutoReconF"/>
<br/>
<br/>

The deep magic tool allows you get get extra info about your target for footprinting such as email adresses, subdomains, and whois for IP and domians <br/>
The 3 options allow you to get varying info, with deep including everything I mentioned plus a netcraft lookup which can take a some time <br/>

<br/>
<br/>


<h1>Host Discovery with Nmap</h1>
<img src="https://i.imgur.com/wpvzvbW.png" height="80%" width="80%" alt="AutoReconF"/>
<br/>
<br/>

This allows a user to enter a IP with a range such as 10.10.10.10/32 to disocver any hosts <br/>
You are then able to pick whihc typw of method you would like to use <br/>


<h1>More Info</h1>
<img src="https://i.imgur.com/ngsKEdj.png" height="80%" width="80%" alt="AutoReconF"/>
<br/>
<br/>
This uses an env file and a default env file so that the script can write to them based on what the user enters for additional options <br/>
Each script scans this env file and reads it to ensure that the users options are correctly being used <br/>
The default file is what is used for the reset setting which then updated the regular env file <br/>



