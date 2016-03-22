#!/bin/bash
INPUT=$1
OUTPUT1=$2
OUTPUT2=$3

INPUT_FNAME="${INPUT##*/}"
DATA_DIR="${INPUT%/*}"

OUT_DIR1=$DATA_DIR/Metagenome
if [ ! -d $OUT_DIR1 ];then
  mkdir $OUT_DIR1
fi

OUT_DIR2=$DATA_DIR/Meta16S
if [ ! -d $OUT_DIR2 ];then
  mkdir $OUT_DIR2
fi

IMG="perl:latest"
docker pull $IMG

docker run -v $DATA_DIR:/data -v /scripts:/scripts \
           -v $OUT_DIR1:/out1 -v $OUT_DIR2:/out2 \
           $IMG perl /scripts/CalculateEntropyDiv \
           /data/$INPUT_FNAME /out1 /out2

ls $OUT_DIR1
ls $OUT_DIR2
