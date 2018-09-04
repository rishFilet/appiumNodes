# appiumNodes
These are scripts for creating appium nodes on a selenium grid hub, requiring the user only to make the config json files. There is also a script for killing all the nodes of specific ones

In the event of multiple devices, there is a script which will run through each json file and search for the port number, then run the specified command in new terminal tabs so that there is a node created each with a unique port number.

To run the script do the following:

* Open runNodesScript.sh in a text editor
* Change the scriptPath variable to wherever you have placed the script file from step 1. This will simply make the file executable and later on you can drag the file to the terminal and run it.
* Change the nodeJsonsPath variable to wherever the JSON files are located locally on your machine (or cloud path if you have ftp setup) with the configuration details of each node as done in step 3 in the previous section.
* On the first run go to your terminal and navigate to the location of the script and type sudo sh ./runNodesScript.sh which should then open a terminal window for each new node
* Check with selenium grid hub to make sure they are registered
* To kill all the nodes at once or a specific one use the script killNodes.sh
* The kill nodes script is run the same way as the runNodesScript.
