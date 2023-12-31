#!/usr/bin/env bash
# Scrambling test

source $(dirname $0)/../common/testrc.sh
test_cleanup "$SCRIPT.*"

INFILE="$INDIR/$SCRIPT.ts"

# DVB-CSA scrambling / descrambling by service.
test_tsp \
    -I file $(fpath "$INFILE") \
    -P scrambler 0x0101 -c 0123456789ABCDEF \
    -P analyze -o $(fpath "$OUTDIR/$SCRIPT.csa.analyze.txt") \
    -P psi -a -o $(fpath "$OUTDIR/$SCRIPT.csa.psi.txt") \
    -P file $(fpath "$OUTDIR/$SCRIPT.csa.ts") \
    -P descrambler 0x0101 -c 0123456789ABCDEF \
    -P analyze -o $(fpath "$OUTDIR/$SCRIPT.decsa.analyze.txt") \
    -P psi -a -o $(fpath "$OUTDIR/$SCRIPT.decsa.psi.txt") \
    -O file $(fpath "$OUTDIR/$SCRIPT.decsa.ts") \
    >"$OUTDIR/$SCRIPT.tsp.csa.log" 2>&1

test_bin $SCRIPT.csa.ts
test_bin $SCRIPT.decsa.ts
test_text $SCRIPT.csa.analyze.txt
test_text $SCRIPT.decsa.analyze.txt
test_text $SCRIPT.csa.psi.txt
test_text $SCRIPT.decsa.psi.txt
test_text $SCRIPT.tsp.csa.log

# DVB-CSA scrambling / descrambling by PID.
test_tsp \
    -I file $(fpath "$INFILE") \
    -P scrambler -c 0123456789ABCDEF --pid 0x0078 --pid 0x0084 \
    -P analyze -o $(fpath "$OUTDIR/$SCRIPT.csa.bypid.analyze.txt") \
    -P psi -a -o $(fpath "$OUTDIR/$SCRIPT.csa.bypid.psi.txt") \
    -P file $(fpath "$OUTDIR/$SCRIPT.csa.bypid.ts") \
    -P descrambler -c 0123456789ABCDEF --pid 0x0078 --pid 0x0084 \
    -P analyze -o $(fpath "$OUTDIR/$SCRIPT.decsa.bypid.analyze.txt") \
    -P psi -a -o $(fpath "$OUTDIR/$SCRIPT.decsa.bypid.psi.txt") \
    -O file $(fpath "$OUTDIR/$SCRIPT.decsa.bypid.ts") \
    >"$OUTDIR/$SCRIPT.tsp.csa.bypid.log" 2>&1

test_bin $SCRIPT.csa.bypid.ts
test_bin $SCRIPT.decsa.bypid.ts
test_text $SCRIPT.csa.bypid.analyze.txt
test_text $SCRIPT.decsa.bypid.analyze.txt
test_text $SCRIPT.csa.bypid.psi.txt
test_text $SCRIPT.decsa.bypid.psi.txt
test_text $SCRIPT.tsp.csa.bypid.log

# ATIS-IDSA scrambling / descrambling.
test_tsp \
    -I file $(fpath "$INFILE") \
    -P scrambler 0x0101 -c 0123456789ABCDEFFEDCBA9876543210 --atis-idsa \
    -P analyze -o $(fpath "$OUTDIR/$SCRIPT.atis.analyze.txt") \
    -P psi -a -o $(fpath "$OUTDIR/$SCRIPT.atis.psi.txt") \
    -P file $(fpath "$OUTDIR/$SCRIPT.atis.ts") \
    -P descrambler 0x0101 -c 0123456789ABCDEFFEDCBA9876543210 --atis-idsa \
    -P analyze -o $(fpath "$OUTDIR/$SCRIPT.deatis.analyze.txt") \
    -P psi -a -o $(fpath "$OUTDIR/$SCRIPT.deatis.psi.txt") \
    -O file $(fpath "$OUTDIR/$SCRIPT.deatis.ts") \
    >"$OUTDIR/$SCRIPT.tsp.atis.log" 2>&1

test_bin $SCRIPT.atis.ts
test_bin $SCRIPT.deatis.ts
test_text $SCRIPT.atis.analyze.txt
test_text $SCRIPT.deatis.analyze.txt
test_text $SCRIPT.atis.psi.txt
test_text $SCRIPT.deatis.psi.txt
test_text $SCRIPT.tsp.atis.log

# DVB-CISSA scrambling / descrambling.
test_tsp \
    -I file $(fpath "$INFILE") \
    -P scrambler 0x0101 -c 0123456789ABCDEFFEDCBA9876543210 --dvb-cissa \
    -P analyze -o $(fpath "$OUTDIR/$SCRIPT.cissa.analyze.txt") \
    -P psi -a -o $(fpath "$OUTDIR/$SCRIPT.cissa.psi.txt") \
    -P file $(fpath "$OUTDIR/$SCRIPT.cissa.ts") \
    -P descrambler 0x0101 -c 0123456789ABCDEFFEDCBA9876543210 --dvb-cissa \
    -P analyze -o $(fpath "$OUTDIR/$SCRIPT.decissa.analyze.txt") \
    -P psi -a -o $(fpath "$OUTDIR/$SCRIPT.decissa.psi.txt") \
    -O file $(fpath "$OUTDIR/$SCRIPT.decissa.ts") \
    >"$OUTDIR/$SCRIPT.tsp.cissa.log" 2>&1

test_bin $SCRIPT.cissa.ts
test_bin $SCRIPT.decissa.ts
test_text $SCRIPT.cissa.analyze.txt
test_text $SCRIPT.decissa.analyze.txt
test_text $SCRIPT.cissa.psi.txt
test_text $SCRIPT.decissa.psi.txt
test_text $SCRIPT.tsp.cissa.log
