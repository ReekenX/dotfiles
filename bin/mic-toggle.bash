#!/bin/bash

amixer set Capture toggle && amixer get Capture | \
    grep '\[off\]' && \
    notify-send -i microphone-sensitivity-muted "Microphone" "Microphone is switched OFF." || notify-send -i microphone-sensitivity-high "Microphone" "Microphone is switched ON, you can talk now."
