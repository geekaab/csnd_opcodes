<CsoundSynthesizer>
<CsOptions>
--opcode-lib=./henon.so
</CsOptions>
<CsInstruments>

sr = 48000
ksmps = 1
nchnls = 2
0dbfs = 1

alwayson "melody"
alwayson "bassline"

instr melody
ix0 = .333
iy0 = .333
ka = 1.4
kb = .3
ktrig = metro(5)
kctlx, kctly henon ktrig, ka, kb, ix0, iy0
;printks2 "x = %f\t ", 5 + 10*kctlx
;printks2 "y = %f\n", 5 + 10*kctly
aoscx = oscili(ampdbfs(-18), 33*(5+10*abs(kctlx)))
aoscy = oscili(ampdbfs(-18), 33*(50+100*abs(kctly)))
outs ampdbfs(-9)*aoscx, ampdbfs(-24)*aoscy
endin

instr bassline
ix0 = .666
iy0 = .666
ka = 1.4
kb = .3
ktrig = metro(5)
kctlx, kctly henon ktrig, ka, kb, ix0, iy0
;printks2 "x = %f\t ", 5 + 10*kctlx
;printks2 "y = %f\n", 5 + 10*kctly
aoscx = oscili(ampdbfs(-18), 11*(5+10*abs(kctlx)))
aoscy = oscili(ampdbfs(-18), 11*(5+10*abs(kctly)))
outs ampdbfs(-3)*aoscy, ampdbfs(-3)*aoscx
endin



</CsInstruments>
<CsScore>
</CsScore>
</CsoundSynthesizer>
