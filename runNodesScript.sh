#!/bin/bash
scriptPath=/Users/rkhan/Automation/Selenium_grid_Standalone/
cd "$scriptPath"
chmod +x runNodesScript.sh
nodeJsonsPath=/Users/rkhan/Automation/Selenium_grid_Standalone/node_json
cd "$nodeJsonsPath"
counteriOS=0
counterAndroid=0
counterAll=0
portIOSCounter=0
portAndroidCounter=0
portAllCounter=0
for f in *.json
  do
  input=$f;
  android=false
  ios=false
  while IFS= read -r var
  do
    if [[ $var =~ "iOS" ]]
    then platformName="iOS"
    counteriOS=$((counteriOS+1))
    iosDevices[$counteriOS-1]=$f
    ios=true
    counterAll=$((counterAll+1))
    allDevices[$counterAll-1]=$f
  elif [[ $var =~ "Android" ]] && [[ $var =~ "platformName" ]]
    then platformName="Android"
    counterAndroid=$((counterAndroid+1))
    androidDevices[$counterAndroid-1]=$input
    android=true
    counterAll=$((counterAll+1))
    allDevices[$counterAll-1]=$input
  fi
    if [[ $var =~ "port" ]] && [[ $ios == 'true' ]]
    then portIOS[$portIOSCounter]="${var//[!0-9]/}"
    portIOSCounter=$((portIOSCounter+1))
    portAll[$portAllCounter]="${var//[!0-9]/}"
    portAllCounter=$((portAllCounter+1))
    break
  elif [[ $var =~ "port" ]] && [[ $android == 'true' ]]
    then portAndroid[$portAndroidCounter]="${var//[!0-9]/}"
    portAndroidCounter=$((portAndroidCounter+1))
    portAll[$portAllCounter]="${var//[!0-9]/}"
    portAllCounter=$((portAllCounter+1))
    break
    fi
  done<"$input"
done
echo There are $counterAll devices: $counteriOS iOS devices and $counterAndroid Android devices configured
while true
do
read -p 'Would you like to start all nodes[1], iOS[2] or Android[3]? ' answer
if [[ $answer -eq 1 ]]
  then files=("${allDevices[@]}")
  ports=("${portAll[@]}")
  break
elif [[ $answer -eq 2 ]]
  then while true
  do
    read -p 'How many iOS devices would you like to configure as nodes? ' iOSNumber
    if [[ $iOSNumber -gt counteriOS ]]
      then echo 'Invalid number of devices, try again'
    else files=("${iosDevices[@]:0:iOSNumber}")
      ports=("${portIOS[@]}")
      break
    fi
  done
  break
elif [[ $answer -eq 3 ]]
  then while true
  do
    read -p 'How many Android devices would you like to configure as nodes? ' AndroidNumber
    if [[ $AndroidNumber -gt counterAndroid ]]
      then 'Invalid number of devices, try again'
    else files=("${androidDevices[@]:0:AndroidNumber}")
      ports=("${portAndroid[@]}")
      break
    fi
  done
  break
else echo 'That answer is not valid, please enter 1, 2 or 3'
fi
done
y=0
for x in ${files[@]}
do
  currentPort=("${ports[y]}")
  echo 'Killing any active connection at port: '$currentPort
  sh -c lsof -P | grep ':'$currentPort | awk '{print $2}' | xargs kill -9
  echo Node started at: $currentPort
  y=$((y+1))
  osascript  <<EOF
tell app "Terminal"
  do script "cd \"$nodeJsonsPath\"; appium --session-override --nodeconfig \"$x\" --port \"$currentPort\""
  end tell
EOF
done
sleep 1
