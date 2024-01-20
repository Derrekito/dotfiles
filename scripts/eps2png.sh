#!/bin/bash

# Input is the image you are converting
INPUT=$1
# Ouput is the output filename including extension
OUTPUT=$2

#gs -dSAFER -dBATCH -dNOPAUSE -dEPSCrop -r600 -sDEVICE=pngalpha -sOutputFile=$OUTPUT $INPUT
gs -dSAFER -dEPSCrop -r600 -sDEVICE=pngalpha -o $OUPUT $INTPUT
