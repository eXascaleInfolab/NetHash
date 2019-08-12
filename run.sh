#!/bin/bash
#
# \description  Execution on multiple networks
#
# \author Artem V L <artem@exascale.info>  https://exascale.info
# 
# Network parameter -degreeentropy:
# blogcatalog 4.78
# homo 3.78
# wiki 3.06
# dblp 2.47
# youtube 1.88
DIMS=128
#NETS="blogcatalog dblp homo wiki youtube"
NETS="blogcatalog dblp homo wiki"
ENTR=2.47  # Default entropy
RESTRACER=./exectime  # time
LOGDIR=embeds/logs
mkdir -p $LOGDIR

USAGE="$0 -h | [-d <dimensions>=${DIMS}] [-w <workers>=${WORKERS}]
  -d,--dims  - required number of dimensions in the embedding model
  -h,--help  - help, show this usage description

  Examples:
  \$ $0 -d 128
"

while [ $1 ]; do
	case $1 in
	-h|--help)
		# Use defaults for the remained parameters
		echo -e $USAGE # -e to interpret '\n\
		exit 0
		;;
	-d|--dims)
		if [ "${2::1}" == "-" ]; then
			echo "ERROR, invalid argument value of $1: $2"
			exit 1
		fi
		DIMS=$2
		echo "Set $1: $2"
		shift 2
		;;
	*)
		printf "Error: Invalid option specified: $1 $2 ...\n\n$USAGE"
		exit 1
		;;
	esac
done


for NET in $NETS; do
	case $NET in
	blogcatalog)
		ENTR=4.78
		;;
	homo)
		ENTR=3.78
		;;
	wiki)
		ENTR=3.06
		;;
	dblp)
		ENTR=2.47
		;;
	youtube)
		ENTR=1.88
		;;
	*)
		ENTR=2.47  # Default entropy
		;;
	esac

	echo "${NET}_${ENTR}_$DIMS"
	$RESTRACER ./nethash -network nets/${NET}.adjlist -feature nets/${NET}.adjlist -hashdim ${DIMS} -depth 2 -degreeentropy $ENTR -embedding embeds/${NET}_d2_e${ENTR}_${DIMS}.emb 2> embeds/logs/${NET}_d2_e${ENTR}_${DIMS}.err 1> embeds/logs/${NET}_d2_e${ENTR}_${DIMS}.log &
done
