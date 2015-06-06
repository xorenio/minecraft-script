#!/bin/bash

DIR=${PWD##*/}
FULLDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

echo ""
echo "Full path: $FULLDIR | Current folder name $DIR"

function usage {
echo ""
echo "Warning Incorrect usage of this bash file"
echo ""
echo "$0 <start|stop|restart|steamcmd>"
echo ""

}
function startcmd {
	java -Xms2G -Xmx2G -jar forge-1.7.*.jar
}

function start {
	cd $FULLDIR

	if ! screen -list | grep -q "$DIR"; then

	#If there is no screen with the name $server not running
	screen -dmS $DIR
	sleep 1

	screen -S $DIR -p 0 -X stuff 'cd $FULLDIR'$(echo -ne '\015')
	screen -S $DIR -p 0 -X stuff '$FULLDIR/start.sh startcmd'$(echo -ne '\015')

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
	echo "The screen for the server is already running. Connecting you now"
	sleep 1
	screen -S $DIR -p 0 -X stuff 'stop'$(echo -ne '\015')
	screen -S "$DIR" -X quit;
	
	screen -dmS $DIR
	sleep 1

	screen -S $DIR -p 0 -X stuff 'cd $FULLDIR'$(echo -ne '\015')
	screen -S $DIR -p 0 -X stuff '$FULLDIR/start.sh startcmd'$(echo -ne '\015')

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
	screen -S $DIR -p 0 -X stuff 'stop'$(echo -ne '\015')
	sleep 8
	screen -S "$DIR" -X quit;
fi
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

if [ "$#" = "0" ]; then
	usage
fi

if [ "$1" = "start" ]; then
	start
fi

if [ "$1" = "startcmd" ]; then
	startcmd
fi

if [ "$1" = "restart" ]; then
	restart
fi

if [ "$1" = "stop" ]; then
	stop
fi

if [ "$1" = "fixperms" ]; then
	fixperms
fi

exit
