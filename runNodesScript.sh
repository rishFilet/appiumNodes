#!/bin/bash
scriptPath=/Users/rkhan/Automation/Selenium_grid_Standalone/
cd "$scriptPath"
chmod +x runNodesScript.sh
nodeJsonsPath=/Users/rkhan/Automation/Selenium_grid_Standalone/node_json
cd "$nodeJsonsPath"
for f in *.json
  do
  input=$f;
  while IFS= read -r var
  do
    if [[ $var =~ "port" ]]
    then port="${var//[!0-9]/}"
    break
    fi
  done<"$input"
  osascript  <<EOF
tell app "Terminal"
  do script "cd \"$nodeJsonsPath\"; appium --session-override --nodeconfig \"$f\" --port \"$port\""
  end tell
EOF
sleep 1
done
