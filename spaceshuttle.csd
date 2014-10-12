<CsoundSynthesizer>
<CsOptions>
-odac  ;;;realtime audio out
;-o shuttlelaunch.wav -W
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 128
nchnls = 2
0dbfs = 1.0

giwave  ftgen  	1,\ 	;table one
				 	0,\ 	;ignored
				 	257,\	;tablesize 2^8 plus 1 ;65537,\;tablesize 2^16 
				 	10,\	;GEN10 — weighted sums of simple sinusoids. 
				 	1,\		; the first arg
				 	0.5,\
				 	0.33,\
				 	0.25,\
				 	0.1

SFIRST = "limi"
SFINAL = "myout"
alwayson SFIRST
alwayson "myout", 12
connect	 1, "leftout", SFIRST, "leftin" 
connect	 1, "rightout", SFIRST, "rightin" 
connect	 SFIRST, "leftout", SFINAL, "leftin" 
connect	 SFIRST, "rightout", SFINAL, "rightin" 

instr limi
  aleftin inleta "leftin"
  arightin inleta "rightin"

kwin linseg 	10,		0.125,\
				30.,	0.125,\
				10,		0.125,\
				300,	0.125,\
				10,		0.125,\
				30.,	0.125,\
				10,		0.125,\
				300,	0.125,\
				10,		0.125,\
				30.,	0.125,\
				10,		0.125,\
				300,	0.125,\
				10,		0.125,\
				30.,	0.125,\
				10,		0.125,\
				300,	0.125,\;1
				10,		0.125,\
				30.,	0.125,\
				10,		0.125,\
				300,	0.125,\
				10,		0.125,\
				30.,	0.125,\
				10,		0.125,\
				300,	0.125,\
				10,		0.125,\
				30.,	0.125,\
				10,		0.125,\
				300,	0.125,\
				10,		0.125,\
				30.,	0.125,\
				10,		0.125,\
				300,	0.125,\;2
				600,		0.5,\
				1200,	0.5,\;3
				1400,		0.25,\
				600,	0.25,\
				600,		0.25,\
				600,	0.25,\ ;4
				10,		0.25,\
				100,	0.25,\
				10,		0.25,\
				100,	0.25,\ ;5
				1000,	4,\ 
				8000,		4,\ ;13
				12200,	1,\		;14
				14400,	2,\		;15
				100000,		2,\ 	;16
				1000,		2
kbandL = (kwin*0.0005)	
kbandR = (kwin*0.001)			
kmax line 300, 20, 3500
kmin= 440 - kmax
  ;aoutL limit aleftin,kmin, kmax
  ;aoutR limit arightin, kmin,kmax
  
  aoutL  butterbp aleftin, kmax, kbandL
  aoutR  butterbp arightin, kmax,kbandR

  outleta "leftout", aoutL
  outleta "rightout", aoutR
endin

instr myout
	iamp = p4
	aleftin inleta "leftin"
	arightin inleta "rightin"
	
	kenv linseg 0.8, 0.1, 1, 17.9, 1, 2, 0
	
	aoutL = aleftin * (iamp*kenv)
	aoutR = arightin * (iamp*kenv)
	outs aoutL,aoutR
endin

instr 1
  awhite unirand 2.0

  ; Normalize to +/-1.0
  awhite = awhite - 1.0  

  apink  pinkish awhite, 1, 0, 29, 0

aoutL = apink
aoutR = apink

  outleta "leftout", aoutL
  outleta "rightout", aoutR
endin


</CsInstruments>
<CsScore>
; Play Instrument #1 for one second.
i 1 0 20
e

</CsScore>
</CsoundSynthesizer>
<bsbPanel>
 <label>Widgets</label>
 <objectName/>
 <x>100</x>
 <y>100</y>
 <width>320</width>
 <height>240</height>
 <visible>true</visible>
 <uuid/>
 <bgcolor mode="nobackground">
  <r>255</r>
  <g>255</g>
  <b>255</b>
 </bgcolor>
</bsbPanel>
<bsbPresets>
</bsbPresets>
