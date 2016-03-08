#!/bin/bash
#filtersubs in=<infile>

usage(){
echo "
Written by Brian Bushnell
Last modified May 11, 2015

Description:  Filters a sam file to select only reads with substitution errors
for bases with quality scores in a certain interval.  Used for manually 
examining specific reads that may have incorrectly calibrated quality scores.

Usage: filtersubs.sh in=<file> out=<file> minq=<number> maxq=<number>

Parameters:
in=<file>       Input sam or bam file.
out=<file>      Output file.
minq=0          Keep only reads with substitutions of at least this quality.
maxq=99         Keep only reads with substitutions of at most this quality.
countindels=t   Also keep reads with indels in the quality range. 
keepperfect=f   Also keep error-free reads.

Please contact Brian Bushnell at bbushnell@lbl.gov if you encounter any problems.
"
}

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/"
CP="$DIR""current/"

z="-Xmx120m"
EA="-ea"
set=0

if [ -z "$1" ] || [[ $1 == -h ]] || [[ $1 == --help ]]; then
	usage
	exit
fi

filtersubs() {
	#module unload oracle-jdk
	#module load oracle-jdk/1.7_64bit
	#module load pigz
	#module load samtools
	local CMD="java $EA $z -cp $CP jgi.FilterReadsWithSubs $@"
#	echo $CMD >&2
	eval $CMD
}

filtersubs "$@"