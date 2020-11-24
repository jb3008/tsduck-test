#!/bin/bash
# Using non-standard time references.

source $(dirname $0)/../common/testrc.sh
test_cleanup "$SCRIPT.*"

NAMES=("" "UTC" "JST" "UTC+9" "UTC-3" "UTC+11:30")

for ((i=0; $i<${#NAMES[@]}; i++)); do

    [[ -z "${NAMES[$i]}" ]] && opt="" || opt="--time-reference ${NAMES[$i]}"

    $(tspath tstables) $(fpath "$INDIR/test-002.ts") \
        --pid 20 --tid 112 --max-tables 1 $opt \
        >"$OUTDIR/$SCRIPT.$i.txt" \
        2>"$OUTDIR/$SCRIPT.$i.log"

    test_text $SCRIPT.$i.txt
    test_text $SCRIPT.$i.log

done
