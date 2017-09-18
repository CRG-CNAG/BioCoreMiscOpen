#!/bin/bash
#
# This script counts the number of sequences in a fastq file

if [ x"$1" == x ]; then

        echo "please specify a fastq file (also gzipped)"

        exit 1

fi

# setting the number of threads for tophat2
THREADS=$5

if [ `echo $1 | grep "gz"` ]; then
	cat="zcat "
else 
	cat="cat "
fi



$cat $1 | wc -l | awk '{print $0/4}'
