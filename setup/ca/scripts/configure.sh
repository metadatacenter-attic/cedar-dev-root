#!/bin/bash

waitForConnection() {
    mkdir /sleep
    while [ -e /sleep ]
    do
	sleep 3
    done
}

