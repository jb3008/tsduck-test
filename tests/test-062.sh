#!/bin/bash
# Test various analyses on an ISDB live stream.

source $(dirname $0)/../common/testrc.sh
test_cleanup "$SCRIPT.*"
source "$COMMONDIR"/standard-ts-test.sh $SCRIPT.ts --japan
