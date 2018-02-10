#!/bin/sh

TASKLIB=$PWD/src
INPUT_FILE_DIRECTORIES=$PWD/data
S3_ROOT=s3://moduleiotest
WORKING_DIR=$PWD/job_3113
RLIB=$PWD/rlib

# commandLine=<R3.0_Rscript> <libdir>run_ConstellationMap.R <libdir> --input.gct.file\=<input.gct.file> --input.cls.file\=<input.cls.file> --gene.sets.file\=<gene.sets.file> --top.n\=<top.n> --direction\=<direction> --image.format\=<image.format> --jaccard.threshold\=<jaccard.threshold> <target.class>


COMMAND_LINE="Rscript $TASKLIB/run_ConstellationMap.R  $TASKLIB/ --input.gct.file=$INPUT_FILE_DIRECTORIES/GSE27473_series_matrix_collapsed_to_symbols.PROJ.gct --input.cls.file=$INPUT_FILE_DIRECTORIES/WT_vs_Knockdown.cls --gene.sets.file=$INPUT_FILE_DIRECTORIES/c2.all.v5.1.symbols.gmt  --top.n=100  --direction=positive  --image.format=PNG  --jaccard.threshold=0.1 "

#COMMAND_LINE=" ls /usr/local/lib/R/site-library/rlib/3.0/site-library"


#DOCKER_CONTAINER=genepattern/docker-r-3-0
DOCKER_CONTAINER=liefeld/conmap
JOB_DEFINITION_NAME="R30_Generic"
JOB_ID=gp_job_r30_ConMap_$1
JOB_QUEUE=TedTest

EXTRA_LOCAL=" -v $RLIB:$RLIB"


echo "extra mount is " $EXTRA_LOCAL
