#!/bin/bash
#
# This script will cut the length of sequences within a fastq file

if [ x"$1" == x ]; then

        echo "please specify a fastq file"

        exit 1

fi

if [ x"$2" == x ]; then

        echo "please specify an output file (fasta)"

        exit 1

fi


if [ "$3" == "gz" ]; then

        zcat $1 | awk '{num++}{if (num%4==1) {gsub("@",">"); print } {if (num%4==2) print }}' > $2

else

	awk '{num++}{if (num%4==1) {gsub("@",">"); print } {if (num%4==2) print }}' $1 > $2

fi
