ar ← ÷9 16
iw ← 400
ih ← ⌊÷ar iw

vh ← 2
vw ← ×vh ÷ih iw

cc ← [0 0 0]

-÷2vw×÷∶vw∶⇡.iw
+÷2vh×÷∶vh∶¯⇡.ih
⊞(⊂∶¯1⊂∶)
pc ← 

r ← ⍚1'-cc pc

l ← √/+×.
unit ← ÷l.

sp ← [0 0 ¯1]
rad ← 0.5

bgd ← +×[1 1 1]-∶1∶×[0.5 0.7 1]. ×0.5+1⊡1unit
sh ← (
  ≥0.-×→(∶×.)→',∶→→.-×.rad/+×.∶/+×,∶-sp cc∶/+×..
  ![(¯1;;;) (÷∶+¯∶¯√)]
)
&ims ⍚1(!(bgd;)_(×0.5+1unit-sp×) >0.sh.) r
