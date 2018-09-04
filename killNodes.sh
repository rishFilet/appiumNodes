#!/bin/bash
chmod +x killNodes.sh
read -p 'Would you like to kill a unique node[1] or all[2]?: ' answer
while true
do
redo='no'
if [ $answer -eq 1 ]
  then ps -A | grep appium
  read -p 'Enter the port number from the list above: ' portNum
  sh -c lsof -P | grep ':'$portNum | awk '{print $2}' | xargs kill -9
  break
elif [ $answer -eq 2 ]
  then /usr/bin/killall -KILL node
  break
elif [ $answer -ne 1 ] && [ $answer -ne 2 ]
  then echo "Invalid answer, please type 1 or 2"
  read -p 'Would you like to kill a unique node[1] or all[2]?: ' answer
fi
done
