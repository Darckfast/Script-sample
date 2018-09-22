#!/bin/bash

#   Slick Progress Bar
#   Created by: Ian Brown (ijbrown@hotmail.com)
#   Please share with me your modifications
# Functions
progressBarWidth=20
RED='\033[0;31m'
GREEN='\033[0;32m'
LBLUE='\033[0;94m'
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

geradorCPF(){
	cpf=$(echo $1 | tr -d -c 0123456789)
	# se não for digitado o parâmetro do cpf
	if [ -z $cpf ]; then
	# gera 3 sequência de 3 caracters, números randômicos.
	 for i in {1..3};
	  do
	   a+=$(($RANDOM%9));
	   b+=$(($RANDOM%9));
	   c+=$(($RANDOM%9));
	  done
	  
	  
	# estabelece o valor temporário do cpf, só pra poder gerar os digitos verificadores. 
	 cpf="$a$b$c"
	# array pra multiplicar com o 9(do 10 ao 2)primeiros caracteres do CPF, respectivamente.
	mulUm=(10 9 8 7 6 5 4 3 2)
	# um loop pra multiplicar caracteres e numeros.Utilizamos nove pois são 9 casas do CPF
	 for digito in {1..9}
	  do
	    # gera a soma dos números posteriormente multiplicados
	    let DigUm+=$(($(echo $cpf | cut -c$digito) * $(echo ${mulUm[$(($digito-1))]})))
	      
	  done
	  
	# divide por 11
	restUm=$(($DigUm%11))
	# gera o primeiro digito subtraindo 11 menos o resto da divisão
	primeiroDig=$((11-$restUm))
	# caso o resto da divisão seja menor que 2
	[ $restUm -lt 2 ] && primeiroDig=0 
	# atualizamos o valor do CPF já com um digito descoberto
	cpf="$a$b$c$primeiroDig"
	# agora um novo array pra multiplicar com o 10(do 11 ao 2) primeiros caracteres do CPF, respectivamente.
	mulDois=(11 10 9 8 7 6 5 4 3 2)
	 for digitonew in {1..10}
	  do
	    
	    let DigDois+=$(($(echo $cpf | cut -c$digitonew) * $(echo ${mulDois[$(($digitonew-1))]})))    
	  done
	# também divide por 11
	restDois=$(($DigDois%11)) 
	# gera o segundo digito subtraindo 11 menos o resto da divisão
	segundoDig=$((11-$restDois))
	# caso o resto da divisão seja menor que 2
	[ $restDois -lt 2 ] && segundoDig=0 
	# exibe o CPF gerado e formatado.
	echo -e "$a.$b.$c-$primeiroDig$segundoDig"
	 # FINALIZA O SCRIPT
	 exit 0;
	fi
	
}

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

bc -v
if [ $? -ne 0 ]; then
	sudo apt-get install bc
fi
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
echo -e " 	x				 x"
echo -e " 	x				 x"
echo -e " 	x				 x"
echo -e " 	x				 x"
echo -e " 	x				 x"
echo -e " 	x				 x"
echo -e " 	x				 x"
echo -e " 	x				 x"
echo -e " 	mqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqj"
WRITE

PUT 9 13; printf "1) Adicionar upstream"
PUT 10 13; printf "2) Fetch"
PUT 11 13; printf "3) Remover upstream"
PUT 12 13; printf "4) Merge"
PUT 13 13; printf "5) Gerar CPF(Auto Copy)"
PUT 14 13; printf "6) Status"
PUT 15 13; printf "7) Add"
PUT 16 13; printf "8) Commit"
PUT 17 13; printf "9) Push"
PUT 18 13; printf "0) Sair"

printf "\n\n\nOpção: "
read op 

while [ $op ] ; do 
	taskCount=10
	tasksDone=0
	case $op in
		1)
			printf "${REVERSE}URL/SSH:${NORMAL} "
			read url
			if [ ${url} != 0 ]; then
				git remote add upstream ${url}
				text=$(echo ".:+>${url}")
				HIDECURSOR
				stty -echo 		
				while [ $tasksDone -le $taskCount ]; do
		  			(( tasksDone += 1 ))
					progressBar $taskCount $taskDone $text
					sleep 0.001		
				done
			fi
			;;
		
		2)
			git fetch upstream
			text=$(echo "<+:.${url}")
			stty -echo
			while [ $tasksDone -le $taskCount ]; do
	  			(( tasksDone += 1 ))
				progressBar $taskCount $taskDone $text
				sleep 0.001		
			done
			;;
		3)
			git rm upstream
			text=$(echo "--:.${url}")
			stty -echo
			while [ $tasksDone -le $taskCount ]; do
	  			(( tasksDone += 1 ))
				progressBar $taskCount $taskDone $text
				sleep 0.001		
			done
			;;
		4)
			printf "${REVERSE}${BLINK}Merge from:${NORMAL} "
			read url
			printf "${BRED}${REVERSE}Você está prestes a executar o seguinte comando:\n${NORMAL}"
			printf "${RED}git merge ${url}\n${NORMAL}"
			printf "${BRED}${REVERSE}Tem certeza que desaja continuar ?\n"
			printf "Digite S para continuar ou qualquer outro comando para cancelar${NORMAL}\n"
			read op
			if [ ${op} = S ]; then	
				stty -echo		
				git merge ${url}
				text=$(echo "<=:.${url}")
				while [ $tasksDone -le $taskCount ]; do
		  			(( tasksDone += 1 ))
					progressBar $taskCount $taskDone $text
					sleep 0.001		
				done
			fi
			;;
		5)
			text=$(echo ".::. Gerando CPF...")
			stty -echo
			while [ $tasksDone -le $taskCount ]; do
	  			(( tasksDone += 1 ))
				progressBar $taskCount $taskDone $text
				sleep 0.001		
			done
			geradorCPF | xclip -sel clip 
			printf "\n${LBLUE}CPF gerado${NORMAL}" 
			;;
		6)
			text=$(echo ".::. Verificando...")
			stty -echo
			while [ $tasksDone -le $taskCount ]; do
				(( tasksDone += 1 ))
				progressBar $taskCount $taskDone $text
				sleep 0.001		
			done
			git status 
			;;

		7)
			text=$(echo ".::. Adicionando...")
			stty -echo
			git add .			
			while [ $tasksDone -le $taskCount ]; do
	  			(( tasksDone += 1 ))
				progressBar $taskCount $taskDone $text
				sleep 0.001		
			done
			;;
		8)
			printf "Digite a menssagem do commit:\n"
			read msg
			text=$(echo ".::. Comitando...")
			stty -echo
			while [ $tasksDone -le $taskCount ]; do
	  			(( tasksDone += 1 ))
				progressBar $taskCount $taskDone $text
				sleep 0.001		
			done
			git commit -m "${msg}"			
			;;
		9)
			text=$(echo ".::. Pushing...")
			git push
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
	
	printf "\n${REVERSE}${BLINK}Digite 0 para sair ou digite outra opção\n${NORMAL}"
	stty echo
	read  -p "Opção:" op 
done
stty echo
