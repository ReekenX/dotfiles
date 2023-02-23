#!/bin/bash

while read line; do
  echo -n `date +%Y-%m-%d\ %H:%M:%S`;
  echo " – $1 – $line";
done
