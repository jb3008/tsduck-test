#!/usr/bin/env bash
# Test zap plugin

source $(dirname $0)/../common/testrc.sh
test_cleanup "$SCRIPT.*"

INFILE="$INDIR/test-001.ts"

test_tsp \
    -I file $(fpath "$INFILE") \
    -P zap canal+cinema \
    -P pcrbitrate --min-pcr 32 \
    -P analyze -o $(fpath "$OUTDIR/$SCRIPT.analyze.txt") \
    -O file $(fpath "$OUTDIR/$SCRIPT.ts") \
    >"$OUTDIR/$SCRIPT.tsp.log" 2>&1

test_bin $SCRIPT.ts
test_text $SCRIPT.tsp.log
test_text $SCRIPT.analyze.txt
