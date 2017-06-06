#!/bin/sh

#
# parameters to this come from the JobRunner implementation
# for the AWS install
#
# current arg is just job #
#

TEST_ROOT=/Users/liefeld/GenePattern/gp_dev/genepattern-server/resources/wrapper_scripts/docker/aws_batch/containers/R30/tests/revealer
TASKLIB=$TEST_ROOT/src
INPUT_FILE_DIRECTORIES=$TEST_ROOT/data
S3_ROOT=s3://moduleiotest
WORKING_DIR=$TEST_ROOT/job_1111
RLIB=$TEST_ROOT/rlib


JOB_DEFINITION_NAME="R30_Generic"
JOB_ID=gp_job_REVEALER_R30_$1
JOB_QUEUE=TedTest


#
# Copy the input files to S3 using the same path
#
aws s3 sync $INPUT_FILE_DIRECTORIES $S3_ROOT$INPUT_FILE_DIRECTORIES --profile genepattern
aws s3 sync $TASKLIB $S3_ROOT$TASKLIB --profile genepattern

#       --container-overrides memory=2000 \

COMMAND_LINE="Rscript  $TASKLIB/REVEALER_library.v5C.R  --ds1=$INPUT_FILE_DIRECTORIES/CTNBB1_transcriptional_reporter.gct  --target.name=BETA-CATENIN-REPORTER  --target.match=positive  --ds2=$INPUT_FILE_DIRECTORIES/CCLE_MUT_CNA_AMP_DEL_0.70_2fold.MC.gct  --seed.names=CTNNB1.MC_MUT  --max.n.iter=2  --n.markers=30  --locs.table.file=$INPUT_FILE_DIRECTORIES/hgnc_complete_set.Feb_20_2014.v2.txt  --count.thres.low=3  --count.thres.high=50  --pdf.output.file=BCAT_vs_MUT_CNA.pdf"


aws batch submit-job \
      --job-name $JOB_ID \
      --job-queue $JOB_QUEUE \
      --container-overrides 'memory=3600' \
      --job-definition $JOB_DEFINITION_NAME \
      --parameters taskLib=$TASKLIB,inputFileDirectory=$INPUT_FILE_DIRECTORIES,s3_root=$S3_ROOT,working_dir=$WORKING_DIR,exe1="$COMMAND_LINE"  \
      --profile genepattern

# may want to pipe the submit output through this to extract the job ID for checking status
# | python -c "import sys, json; print json.load(sys.stdin)['jobId']"




# wait for job completion TBD
#
#check status 
# aws batch describe-jobs --jobs 07f93b66-f6c0-47e5-8481-4a04722b7c91 --profile genepattern
#

#
# Copy the output of the job back to our local working dir from S3
#
#aws s3 sync $S3_ROOT$WORKING_DIR $WORKING_DIR --profile genepattern

