#!/bin/bash
# Check the integrity of help texts.

source $(dirname $0)/../common/testrc.sh
test_cleanup "$SCRIPT.*"

# Some tools and plugins have output texts which depend on the operating system.
# Some others are not implemented at all (eg. dektec plugins on macOS).

TOOLS=(
    tsanalyze tsbitrate tscharset tscmp tsdate tsdektec.linux tsdektec.windows tsdump
    tsecmg tsemmg tsfclean tsfixcc tsftrunc tsgenecm tshides.linux tshides.windows
    tslsdvb.linux tslsdvb.mac tslsdvb.windows tsp tspacketize tspcap tspcontrol
    tspsi tsresync tsscan.linux tsscan.mac tsscan.windows tssmartcard tsstuff
    tsswitch tstabcomp tstabdump tstables tsterinfo tsxml
)

INPUT_PLUGINS=(
    craft dektec.linux dektec.windows dvb.linux dvb.mac dvb.windows file fork
    hls http ip memory null pcap rist.windows srt
)

OUTPUT_PLUGINS=(
    dektec.linux dektec.windows drop file fork hides.linux hides.windows hls
    ip memory play.linux play.mac play.windows rist.windows srt
)

PACKET_PLUGINS=(
    aes analyze bat bitrate_monitor boostpid cat clear continuity count
    craft cutoff datainject descrambler duplicate eit eitinject file filter
    fork history inject limit merge mpe mpeinject mux nit nitscan pat pattern
    pcradjust pcrbitrate pcrcopy pcredit pcrextract pcrverify pes pidshift pmt
    psi psimerge reduce regulate remap rmorphan rmsplice scrambler sdt sections
    sifilter skip slice spliceinject splicemonitor stats stuffanalyze
    svremove svrename svresync t2mi tables teletext time timeref timeshift
    trigger tsrename until zap
)

for name in ${TOOLS[@]}; do
    if [[ $name != *.* || $name == *.$OS ]]; then
        $(tspath ${name/.*/}) --help >"$OUTDIR/$SCRIPT.$name.help" 2>&1
        test_text $SCRIPT.$name.help
    fi
done

for name in ${INPUT_PLUGINS[@]}; do
    if [[ $name != *.* || $name == *.$OS ]]; then
        $(tspath tsp) -I ${name/.*/} --help >"$OUTDIR/$SCRIPT.tsp.input.$name.help" 2>&1
        test_text $SCRIPT.tsp.input.$name.help
    fi
done

for name in ${OUTPUT_PLUGINS[@]}; do
    if [[ $name != *.* || $name == *.$OS ]]; then
        $(tspath tsp) -O ${name/.*/} --help >"$OUTDIR/$SCRIPT.tsp.output.$name.help" 2>&1
        test_text $SCRIPT.tsp.output.$name.help
    fi
done

for name in ${PACKET_PLUGINS[@]}; do
    if [[ $name != *.* || $name == *.$OS ]]; then
        $(tspath tsp) -P ${name/.*/} --help >"$OUTDIR/$SCRIPT.tsp.packet.$name.help" 2>&1
        test_text $SCRIPT.tsp.packet.$name.help
    fi
done
