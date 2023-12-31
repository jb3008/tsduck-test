#!/usr/bin/env bash
# Generic muxing test.

cd $(dirname $0)
source ../../common/testrc.sh
INFILE=test-092.ts

# This script is invoked recursively.
case "$1" in
    --play)
        # Play one service from one input file.
        infile=$2
        service=$3
        $(tspath tsp) --max-flushed-packets 16 \
            -I file $(fpath "$INDIR/$infile") \
            -P zap $service --eit \
            -P pcrbitrate \
            -P regulate --packet-burst 16 \
            -P analyze -o $SCRIPT.$service.analysis.txt
        ;;
    "")
        # Main command
        $(tspath tsmux) -v --bitrate 12,000,000 --max-input-packets 16 --terminate --ts-id 10 --original-network-id 11 \
            -I fork "./$SCRIPT.sh --args '--play $INFILE 0x0101'" \
            -I fork "./$SCRIPT.sh --args '--play $INFILE 0x0104'" \
            -I fork "./$SCRIPT.sh --args '--play $INFILE 0x0106'" \
            -O file $SCRIPT.ts \
            >"./$SCRIPT.mux.log" 2>&1
        $(tspath tsp) -v \
            -I file $SCRIPT.ts \
            -P analyze -o $SCRIPT.out.analysis.txt \
            -P stats -o $SCRIPT.out.stats.txt \
            -O drop \
            >"./$SCRIPT.out.log" 2>&1
        ;;
    *)
        error "unknown parameter $1"
        ;;
esac
