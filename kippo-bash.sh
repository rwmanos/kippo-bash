#!/bin/bash

###
# set the last kippo log file:
# _file="/home/username/kippo/log/kippo.log"
### 
_file="/home/username/kippo/log/kippo.log"

# Check if file exists and has some data.
if [ ! -s $_file ]
then
    echo "$_file does not exist or it is empty."
    exit
fi

echo -ne '[#-------------------] (5%)  - copying log files ...\r'
A=`cat $_file* | grep "login attempt"`
TOTALattempts=`echo "$A" | wc -l`

echo -ne '[####----------------] (20%) - sorting usernames ... \r'
usernames=`echo "$A" | cut -d"[" -f3-  | cut -f1 -d"/" | sort | uniq --count | sort -nr`
TOTALusernames=`echo "$usernames" | wc -l`
TOPusernames=`echo "$usernames" | head -n 10`

echo -ne '[########------------] (40%) - sorting passwords ... \r'
passwords=`echo "$A" | cut -d"/" -f2  | cut -f1 -d"]" | sort | uniq --count | sort -nr`
TOTALpasswords=`echo "$passwords" | wc -l`
TOPpasswords=`echo "$passwords" | head -n 10`

echo -ne '[############--------] (60%) - sorting combinations ...\r'
combinations=`echo "$A" | cut -d"[" -f3  | cut -f1 -d"]" | sort | uniq --count | sort -nr`
TOTALcombinations=`echo "$combinations" | wc -l`
TOPcombinations=`echo "$combinations" | head -n 10`

echo -ne '[################----] (80%) - soting IPs ...          \r'
IPs=`echo "$A" | cut -d"," -f3  | cut -f1 -d"]" | sort | uniq --count | sort -nr`
TOTALIPs=`echo "$IPs" | wc -l`
TOPIPs=`echo "$IPs" | head -n 10`

echo -ne '[###################-] (95%) - counting succeeded ...     \r'
TOTALsucceeded=`echo "$A" | awk '{print $NF}' | grep succeeded | wc -l`
TOTALfailed=`echo "$A"    | awk '{print $NF}' | grep failed    | wc -l`

echo -ne '[####################] (100%) - analysis completed.       \r'
echo -ne '\n'
echo

################### 
echo "Total"
echo " - attempts :  $TOTALattempts"
echo "    + succeeded : $TOTALsucceeded"
echo "    + failed :  $TOTALfailed"
echo
echo "Total unique "
echo " - usernames :  $TOTALusernames " 
echo " - passwords :  $TOTALpasswords" 
echo " - combinations :  $TOTALcombinations" 
echo " - IPs:  $TOTALIPs" 

prompt="Pick an option:"
echo
echo "Menu"
PS3="$prompt "

options=( "Show complete stats" "Generate graphs" "Store lists" "Quit")
select opt in "${options[@]}"
do
    echo $opt
    case $opt in
        "Show complete stats")
            echo
            echo "Top 10 usernames:"
            echo "$TOPusernames"
            echo
            echo "Top 10 passwords:"
            echo "$TOPpasswords"
            echo
            echo "Top 10 combinations:"
            echo "$TOPcombinations"
            echo
            echo "Top 10 IPs:"
            echo "$TOPIPs"
            echo
            ;;
        "Generate graphs")
            # want to cut usernames
            # cut -c 1-17 includes anonymous, so give one more!
            echo "$TOPusernames" | cut -c 1-19  > TOPusernames.1
            echo "$TOPpasswords" | cut -c 1-19  > TOPpasswords.1
            echo "$TOPcombinations" | cut -c 1-22  > TOPcombinations.1
            echo "$TOPIPs" | cut -c 1-22  > TOPIPs.1
            #echo "$a" | head -n 1 |  grep -oE [[:digit:]] | wc -l # count digits of first number
            export VARIABLE="usernames"
            ./plot.sh 
            export VARIABLE="passwords"
            ./plot.sh 
            export VARIABLE="combinations"
            ./plot.sh 
            export VARIABLE="IPs"
            ./plot.sh 
            rm TOPusernames.1
            rm TOPpasswords.1
            rm TOPcombinations.1
            rm TOPIPs.1
            echo "Done. There are 4 graphs in the folder $PWD"
            echo
            ;;   
        "Store lists")
            #mkdir -p $PWD/output
            echo "$usernames" > $PWD/usernames.txt
            echo "$passwords" > $PWD/passwords.txt 
            echo "$combinations" > $PWD/compinations.txt 
            echo "$IPs" > $PWD/IPs.txt 
            echo "Done, files created in folder $PWD/ :" 
            echo "usernames.txt, passwords.txt, combinations.txt, IPs.txt"
            echo
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done
