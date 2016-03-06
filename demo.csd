<CsoundSynthesizer>
<CsOptions>
--opcode-lib=./henon.so --opcode-lib=./euclid.so
</CsOptions>
<CsInstruments>

sr = 48000
ksmps = 1
nchnls = 2
0dbfs = 1

alwayson "melody"
alwayson "bassline"
alwayson "drumtrig"

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
outs ampdbfs(-15)*aoscx, ampdbfs(-30)*aoscy
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
aoscx = oscili(ampdbfs(-15), 11*(5+10*abs(kctlx)))
aoscy = oscili(ampdbfs(-15), 11*(5+10*abs(kctly)))
outs ampdbfs(-6)*aoscy, ampdbfs(-6)*aoscx
endin

instr drumtrig
ktempo = metro(5)
kkick = euclid(ktempo, 7, 11, 0)
ksnare = euclid(ktempo, 5, 19, 2)
khh = euclid(ktempo, 11, 29, 2)
schedkwhen kkick, 0, 0, "kickdrum",  0, .1
schedkwhen ksnare, 0, 0, "snaredrum",  0, .3
schedkwhen khh, 0, 0, "hihat",  0, .3
endin

gisqr ftgen 1, 0, 4096, 10, 1, 0, 1/3, 0, 1/5, 0, 1/7, 0, 1/9, 0
gisaw ftgen 2, 0, 4096, 10, 1, 1/2, 1/3, 1/4, 1/5, 1/6, 1/7, 1/8, 1/9, 1/10

instr kickdrum
akick = oscili(adsr(.01, .1, 0, 0), 33, gisqr)
outs ampdbfs(-9)*akick, ampdbfs(-9)*akick
endin

instr snaredrum
asnare = oscili(adsr(.01, .3, 0, 0), 66, gisaw)
outs ampdbfs(-18)*asnare, ampdbfs(-18)*asnare
endin

instr hihat
ahh = noise(adsr(.01, .05, 0, 0), 0)
outs ampdbfs(-36)*ahh, ampdbfs(-36)*ahh
endin


</CsInstruments>
<CsScore>
</CsScore>
</CsoundSynthesizer>
