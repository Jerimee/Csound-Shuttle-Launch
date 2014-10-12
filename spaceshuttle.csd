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







SFIRST = "limi"

SFINAL = "myout"

alwayson SFIRST

alwayson "myout", 0.95

connect	 1, "leftout", SFIRST, "leftin" 

connect	 1, "rightout", SFIRST, "rightin" 

connect	 SFIRST, "leftout", SFINAL, "leftin" 

connect	 SFIRST, "rightout", SFINAL, "rightin" 



instr limi

  aleftin inleta "leftin"

  arightin inleta "rightin"



kmax line 15, 20, 3500

printk 1, kmax

kmin= 3515 - kmax

  ;aoutL limit aleftin,kmin, kmax

  ;aoutR limit arightin, kmin,kmax

  

  aoutL  butterbp aleftin, kmax, 75

  aoutR  butterbp arightin, kmin, 95



  outleta "leftout", aoutL

  outleta "rightout", aoutR

endin



instr myout

	iamp = p4

	aleftin inleta "leftin"

	arightin inleta "rightin"

	

	kenv linseg 0.8, 0.1, 1, 18.9, 1, 1, 0

	

	aoutL = aleftin * (iamp*kenv)

	aoutR = arightin * (iamp*kenv)

	outs aoutL,aoutR

endin



instr 1

  awhite unirand 2.0



  ; Normalize to +/-1.0

  awhite = awhite - 1.0  



  apink  pinkish awhite, 1, 0, 0, 1



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

