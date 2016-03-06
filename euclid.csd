<CsoundSynthesizer>
<CsOptions>
--opcode-lib=./euclid.so
</CsOptions>
<CsInstruments>

sr = 48000
ksmps = 1
nchnls = 2
0dbfs = 1

alwayson "testinstr1"
alwayson "kickinstr"

instr testinstr1
kn = 7
kN = 19
kR = 0
ktrig = euclid(metro(7), kn, kN, kR)
schedkwhen ktrig, 0, 0, "kickinstr", 0, .5
endin

instr kickinstr
aoscenv = adsr(.01, 0, 1, .6)
anoisenv = adsr(.01, .0000001, .6, 0)
aosc = oscili(ampdbfs(-3)*aoscenv, 33) + noise(ampdbfs(-60)*anoisenv, -.6)
outs aosc, aosc
endin

</CsInstruments>
<CsScore>
</CsScore>
</CsoundSynthesizer>
