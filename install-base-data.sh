#!/bin/bash

NIORD_HOME=~/.niord-gh
BATCH_SET="niord-gh-basedata"

echo "Copy $BATCH_SET batch set to NIORD_HOME/batch-jobs/batch-sets/"

mkdir -p $NIORD_HOME/batch-jobs/batch-sets/
zip -j $NIORD_HOME/batch-jobs/batch-sets/niord-basedata.zip $BATCH_SET/*.json

exit 0
