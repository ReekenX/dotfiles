#!/bin/bash
# Toggle mic on-off with single command
# Notify user with GUI message about it

amixer set Capture toggle && amixer get Capture | \
    grep '\[off\]' && \
    notify-send -i microphone-sensitivity-muted "Microphone" "Microphone is switched OFF." || notify-send -i microphone-sensitivity-high "Microphone" "Microphone is switched ON, you can talk now."
