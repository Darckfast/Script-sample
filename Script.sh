#!/bin/bash

#   Slick Progress Bar
#   Created by: Ian Brown (ijbrown@hotmail.com)
#   Please share with me your modifications
# Functions
progressBarWidth=20
RED='\033[0;31m'
GREEN='\033[0;32m'
BOLD='\e[1m'
DIM='\e[2m'
UNDERLINE='\e[4m'
BLINK='\e[5m'
REVERSE='\e[7m'
HIDDEN='\e[8m'
BRED='\033[0;101m'
BGREEN='\e[42m'
NORMAL='\e[0m'

sp="/-\|"

# Function to draw progress bar
progressBar () {
  sleep 7 &
  # Calculate number of fill/empty slots in the bar
  progress=$(echo "$progressBarWidth/$taskCount*$tasksDone" | bc -l)  
  fill=$(printf "%.0f\n" $progress)
  if [ $fill -gt $progressBarWidth ]; then
    fill=$progressBarWidth
  fi
  empty=$(($fill-$progressBarWidth))

  # Percentage Calculation
  percent=$(echo "100/$taskCount*$tasksDone" | bc -l)
  percent=$(printf "%0.2f\n" $percent)
  if [ $(echo "$percent>100" | bc) -gt 0 ]; then
    percent="100.00"
  fi

  # Output to screen
  printf "\r\b${sp:i++%${#sp}:1} ${GREEN}["
  printf "${BGREEN}%${fill}s" '' | tr ' ' =
  printf "${NORMAL}%${empty}s" '' | tr ' ' x
  printf "${GREEN}] ${NORMAL}$percent%% - $text "
  sleep .01
}

## Collect task count
taskCount=10
tasksDone=0

PUT(){ echo -en "\033[${1};${2}H";}  
DRAW(){ echo -en "\033(0";}         
WRITE(){ echo -en "\033(B";}  
HIDECURSOR(){ echo -en "\033[?25l";} 
NORM(){ echo -en "\033[?12l\033[?25h";}
function showBar {
        percDone=$(echo 'scale=2;'$1/$2*100 | bc)
        halfDone=$(echo $percDone/2 | bc) #I prefer a half sized bar graph
        barLen=$(echo ${percDone%'.00'})
        halfDone=`expr $halfDone + 6`
        tput bold
        PUT 7 28; printf "%4.4s  " $barLen%     #Print the percentage
        PUT 5 $halfDone;  echo -e "\033[7m \033[0m" #Draw the bar
        tput sgr0
        }
# Start Script
clear
HIDECURSOR
echo -e ""                                           
echo -e ""                                          
DRAW    #magic starts here - must use caps in draw mode                                              
echo -e "          		CARREGANDO"
echo -e "    lqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqk"  
echo -e "    x                                                   x" 
echo -e "    mqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqj"
WRITE             
#
# Insert your script here
for (( i=0; i<=50; i++ ))  
do
    showBar $i 50  #Call bar drawing function "showBar"
    sleep .01
done
# End of your script
# Clean up at end of script
PUT 10 12                                           
echo -e ""                                        
NORM
clear
sleep .2

stty echo
printf "${GREEN}" 

base64 -d <<<"H4sICBTDnlsAA2xvZ28udHh0AJWPQQ7AIAgE77yYJ/RYEmmTJn7Ol7SaiFqgWsOBLMjOpmNLuvhE
U/1cnYytGdQuJN67iqv6y5nJXeBrVORyBI9OjmJ+1krokMhbaH/LJWgoAxCZdutJSxZUZnY2yhCT
zBpsJJzlEiZrEKv4IEurGzHqBMAfD25kQjg+4QIAAA==
" | gunzip

printf "${NORMAL}"

DRAW
echo -e " 	lqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqk"
echo -e " 	x				 x"
echo -e " 	x				 x"
echo -e " 	mqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqj"
WRITE

PUT 9 13; printf "1) Adicionar upstream"
PUT 10 13; printf "2) Fetch"

printf "\n\n\nOpção: "
read op 

while [ $op ] ; do 
	taskCount=10
	tasksDone=0
	case $op in
		1)
			printf "${REVERSE}${BLINK}URL/SSH:${NORMAL} "
			read url
			git remote add upstream ${url}
			text=$(echo ".:->${url}")
			HIDECURSOR
			stty -echo 		
			while [ $tasksDone -le $taskCount ]; do
	  			(( tasksDone += 1 ))
				progressBar $taskCount $taskDone $text
				sleep 0.001		
			done
			;;
		
		2)
			git fetch upstream
			text=$(echo "<-:.${url}")
			stty -echo
			while [ $tasksDone -le $taskCount ]; do
	  			(( tasksDone += 1 ))
				progressBar $taskCount $taskDone $text
				sleep 0.001		
			done
			;;
		
		0) break; ;;	
		
		*)
		printf "${op} <--- ${RED}${REVERSE}${BLINK}Não é uma opção válida\n${NORMAL}"
		;;
	esac

	printf "\n${REVERSE}${BLINK}Digite '0' para sair ou digite outra opção\n${NORMAL}"
	stty echo
	read  -p "Opção:" op 
done
stty echo
