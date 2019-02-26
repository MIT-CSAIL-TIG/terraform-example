#!/bin/sh

# default write to stdout
OUTFILE=/dev/stdout

# if 1st arg is not teh empty string
# write there.  This is run as root
# and does zero checking so horribly dangerous :)

if [ ! -z "$1" ]; then
	OUTFILE=$1
fi

echo "HELLO WORLD" >> $OUTFILE

exit 0
