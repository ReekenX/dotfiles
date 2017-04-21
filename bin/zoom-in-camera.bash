#!/bin/bash

guvcview -p ~/.camera.gpfl 2>&1 > /dev/null &
sleep 1
kill %1
