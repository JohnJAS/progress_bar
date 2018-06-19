#!/bin/bash
#set -x
# -------------------------------------------------------------------------------------
# name:         progress_bar2.sh
# version:      v0.1
# createTime:   2018-05-25
# description:  Adding a process bar to to a script so that it can show the progress of 
#               the script running digitally. 
# author:       Johneko
# email:        sjjjustice@163.com
# github:       https://github.com/JohnJAS/progress_bar
# -------------------------------------------------------------------------------------

#count
i=0
#status_bar anime effect
status_bar=""
#status_bar speed
time=50000
#status_circle anime effect
index=0
arr=( "|" "/" "-" "\\" "OK")

#Main Program
main(){
    #Enter your code here.
    echo "Your code is running... "
    echo "This is in the subshell $BASH_SUBSHELL"
    ( sleep 1 ; ps -f --forest ; echo "This is in 2nd subshell $BASH_SUBSHELL" )
    sleep 1
} 

#Main program running(as a subshell)
main &
#Get PID of the subShell(Main Program)
mainPID=$!

echo "This is in the outside $BASH_SUBSHELL"

{ echo "233"; sleep 1; echo  "This is in the outside2 $BASH_SUBSHELL" ;}

ps -f --forest 

#If detect == 0 , the main program finished.
#list the progress | locate the PID column | find the PID of main progress | count result
detect=$(ps -ef | awk '{print $2}' | grep -w "$mainPID" | wc -l) 


while [ $i -le 100 ]
do
    let index++
    let index=index%4

    #If already detect value equals 0, no need to detect again.
    #The detect process need quite a lot of time, maybe it can be improved. 
    if [ "$detect" -gt 0 ]
    then
        #list the progress | locate the PID column | find the PID of main progress | count 
        detect=$(ps -ef | awk '{print $2}' | grep -w "$mainPID" | wc -l)
    fi

    if [ "$detect" -gt 0 ]
    then
        if  [ $i -eq 100 ]
        then 
            let i--
            status_bar=${status_bar:0-100}
        fi
        #Show Status Bar
        printf "[%-100s][%d%%][%s]\r" "$status_bar" "$i" "${arr[$index]}"
    else 
        time=0
        if [ $i -eq 100 ]
        then
            index=4
        fi
        printf "[%-100s][%d%%][%s]\r" "$status_bar" "$i" "${arr[$index]}"
    fi

    #The speed of status_bar.
    usleep $time

    let i++
    status_bar+="="

done

printf "\n"