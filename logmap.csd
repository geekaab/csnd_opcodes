<CsoundSynthesizer>
<CsOptions>
--opcode-lib=./logmap.so
</CsOptions>
<CsInstruments>

#include "udo_rythm.csd"

sr = 48000
ksmps = 1
nchnls = 2
0dbfs = 1

gi_sdicvol = ampdbfs(-21)

alwayson "sdic"
instr sdic
i_basefreq = 333
k_trig = trigbeat(155, 2)
i_lx0 = 1e-9
i_rx0 = i_lx0 + 1e-21
outs oscili(gi_sdicvol, i_basefreq * log(logmap(k_trig, i_lx0))),
     oscili(gi_sdicvol, i_basefreq * log(logmap(k_trig, i_rx0)))
endin

</CsInstruments>
<CsScore>
</CsScore>
</CsoundSynthesizer>
