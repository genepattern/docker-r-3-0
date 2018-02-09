FROM genepattern/docker-r-3-0

COPY src/r.package.info /build/source/r.package.info
RUN  rm /usr/local/bin/runS3Batch_prerun_custom.sh && \
     rm /usr/local/bin/runS3Batch_postrun_custom.sh && \
     Rscript /build/source/installPackages.R /build/source/r.package.info

