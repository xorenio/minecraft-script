#!/bin/bash

# What jar
# The jar usaged to start the server 
jar="*.jar"

# Ram usage
# Set the ram suage for the minecraft server here
ram="2G"

# Time to wait after save 
# Key:
#   s  :  seconds (default)
#   m  :  minutes
#   h  :  hours
#   d  :  days
# example saveTime="30m" (30 minutes)
saveTime="6"

# After save message
# To enable change sMSG to 1 or higher
sMSG="8"

# Before restart/stop messages
sMSG1="1"
sMSG2="2"
sMSG3="3"
sMSG4="4"
sMSG5="5"
sMSG6="6"
sMSG7="7"
sMSG8="8"

DIR=${PWD##*/}
FULLDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
echo ""
echo "Full path: $FULLDIR | Current folder name $DIR"

function usage {
echo ""
echo "Warning Incorrect usage of this bash file"
echo ""
echo "$0 <start|stop|restart|startcmd|send|connect>"
echo ""

}
function startcmd {
	java -Xms$ram -Xmx$ram -jar $jar
}

function start {
	cd $FULLDIR

	if ! screen -list | grep -q "$DIR"; then

	#If there is no screen with the name $server not running
	screen -dmS $DIR
	sleep 1

	screen -S $DIR -p 0 -X stuff 'cd '$FULLDIR$(echo -ne '\015')
	screen -S $DIR -p 0 -X stuff $FULLDIR'/start.sh startcmd'$(echo -ne '\015')

	echo "Server has been started"
	echo ""
	echo "Now connecting to the server console"
	screen -x $DIR
else

	#If there is a screen with the name $server already running
	echo "The screen for the server is already running. Connecting you now"
	sleep 1
	screen -x $DIR

fi
}

function restart {

if ! screen -list | grep -q "$DIR"; then

	#If there is no screen with the name $server not running
	echo "server is not running"

else

	#If there is a screen with the name $server already running
	echo ""
	sleep 1
	screen -S $DIR -p 0 -X stuff 'save-all'$(echo -ne '\015')
	if [ "$sMSG" -ge "1" ]; then
	echo "Now sending messages to the server"
	screen -S $DIR -p 0 -X stuff 'say '$sMSG1$(echo -ne '\015')
	sleep 1
	fi
	if [ "$sMSG" -ge "2" ]; then
	screen -S $DIR -p 0 -X stuff 'say '$sMSG2$(echo -ne '\015')
	sleep 1
	fi
	if [ "$sMSG" -ge "3" ]; then
	screen -S $DIR -p 0 -X stuff 'say '$sMSG3$(echo -ne '\015')
	sleep 1
	fi
	if [ "$sMSG" -ge "4" ]; then
	screen -S $DIR -p 0 -X stuff 'say '$sMSG4$(echo -ne '\015')
	sleep 1
	fi
	if [ "$sMSG" -ge "5" ]; then
	screen -S $DIR -p 0 -X stuff 'say '$sMSG5$(echo -ne '\015')
	sleep 1
	fi
	if [ "$sMSG" -ge "6" ]; then
	screen -S $DIR -p 0 -X stuff 'say '$sMSG6$(echo -ne '\015')
	sleep 1
	fi
	if [ "$sMSG" -ge "7" ]; then
	screen -S $DIR -p 0 -X stuff 'say '$sMSG7$(echo -ne '\015')
	sleep 1
	fi
	if [ "$sMSG" -ge "8" ]; then
	screen -S $DIR -p 0 -X stuff 'say '$sMSG8$(echo -ne '\015')
	sleep 1
	fi
	sleep $saveTime
	screen -S $DIR -p 0 -X stuff 'stop'$(echo -ne '\015')
	screen -S "$DIR" -X quit;
	
	screen -dmS $DIR
	sleep 1

	screen -S $DIR -p 0 -X stuff 'cd '$FULLDIR$(echo -ne '\015')
	screen -S $DIR -p 0 -X stuff $FULLDIR'/start.sh startcmd'$(echo -ne '\015')
	echo "The $DIR server is now starting back up"
fi

}

function stop {

if ! screen -list | grep -q "$DIR"; then

	#If there is no screen with the name $server not running
	echo "server is not running"
else
	#If there is a screen with the name $server already running
	echo "The screen for the server is already running. Connecting you now"
	sleep 1
	screen -S $DIR -p 0 -X stuff 'save-all'$(echo -ne '\015')
	sleep $saveTime
	screen -S $DIR -p 0 -X stuff 'stop'$(echo -ne '\015')
	sleep 8
	screen -S "$DIR" -X quit;
fi
}

function send {
	if [ $# == "3" ]; then
	screen -S $DIR -p 0 -X stuff $3$4$5$6$(echo -ne '\015')
else
	echo "Warning Incorrect usage of this bash file"
	echo $0 send command
fi
}

function connect {
	screen -r $DIR
}

function fixperms {
find . -type f -name '*.jar' -exec chmod 755 {} \;
find . -type f -name '*.jar' -exec chown twisted:users {} \;

find . -type f -name '*.txt' -exec chmod 755 {} \;
find . -type f -name '*.txt' -exec chown twisted:users {} \;

find . -type f -name '*.json' -exec chmod 755 {} \;
find . -type f -name '*.json' -exec chown twisted:users {} \;

find . -type f -name '*.log' -exec chmod 755 {} \;
find . -type f -name '*.log' -exec chown twisted:users {} \;

find . -type f -name '*.cfg' -exec chmod 755 {} \;
find . -type f -name '*.cfg' -exec chown twisted:users {} \;

find . -type f -name '*.lang' -exec chmod 755 {} \;
find . -type f -name '*.lang' -exec chown twisted:users {} \;

find . -type f -name '*.txt' -exec chmod 755 {} \;
find . -type f -name '*.txt' -exec chown twisted:users {} \;

find . -type f -name '*.conf' -exec chmod 755 {} \;
find . -type f -name '*.conf' -exec chown twisted:users {} \;

find . -type f -name '*.dat' -exec chmod 755 {} \;
find . -type f -name '*.dat' -exec chown twisted:users {} \;

find . -type f -name '*.mca' -exec chmod 755 {} \;
find . -type f -name '*.mca' -exec chown twisted:users {} \;
find . -type d -exec chmod 755 {} \;
}

function credit {
	echo ""
	echo -e " ${green}Welcome to a script made for thingamajigs${NC}"
	echo ""
	echo -e " made by ${red}xoren.io${NC}"
	echo ""
	echo " github - https://github.com/xorenio/mc-script"
	echo ""
	echo -e " If you would like to donate I only take ${red}NEX${NC}"
	echo ""
	echo -e " ${yellow}NAQO5T-G6X3Q7-4OR3HX-3C2NH5-IR5Y4L-2E75P3-SQCR${NC}"
	echo ""
	exit
}

function debug {
	screen -S $DIR -p 0 -X stuff 'cd '$FULLDIR$(echo -ne '\015')
}

if [ "$#" -eq "0" ]; then
	usage
fi
$1
exit 1
