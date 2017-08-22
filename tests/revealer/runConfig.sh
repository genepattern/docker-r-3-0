#!/bin/sh

TASKLIB=$PWD/src
INPUT_FILE_DIRECTORIES=$PWD/data
S3_ROOT=s3://moduleiotest
WORKING_DIR=$PWD/job_1112
RLIB=$PWD/rlib

COMMAND_LINE="Rscript  $TASKLIB/REVEALER_library.v5C.R  --ds1=$INPUT_FILE_DIRECTORIES/CTNBB1_transcriptional_reporter.gct  --target.name=BETA-CATENIN-REPORTER  --target.match=positive  --ds2=$INPUT_FILE_DIRECTORIES/CCLE_MUT_CNA_AMP_DEL_0.70_2fold.MC.gct  --seed.names=CTNNB1.MC_MUT  --max.n.iter=1  --n.markers=10  --locs.table.file=$INPUT_FILE_DIRECTORIES/hgnc_complete_set.Feb_20_2014.v2.txt  --count.thres.low=3  --count.thres.high=50  --pdf.output.file=BCAT_vs_MUT_CNA.pdf"

DOCKER_CONTAINER=genepattern/docker-r-3-0

JOB_DEFINITION_NAME="R30_Generic"
JOB_ID=gp_job_r30_Revealer_$1
JOB_QUEUE=TedTest


