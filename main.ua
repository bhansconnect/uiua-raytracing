ar ← ÷9 16
iw ← 100
ih ← ⌊÷ar iw

sam ← 10

cc ← [0 0 0]
sp ← [[0 0 ¯1] [0 ¯100.5 ¯1]]
rad ← [0.5 100]

vh ← 2
vw ← ×vh ÷ih iw

-÷2vw×÷∶vw∶⇡.iw
+÷2vh×÷∶vh∶¯⇡.ih
⍘⍉⊞(⊂∶¯1⊂∶)
pc ← 

rv ← ↯∶[⍥⚂]/×.
r ← ⍉[⍥(∶+×[÷iw vw ÷ih vh 0]-0.5rv△..)-1sam-cc pc]

ccr ← ↯△r0

norm ← (
  ∶/+×..
  →→∶∺(/+×),,∺-sp ccr
  +∶×.,¯∺×→,-×.rad≡/+×.∶
  /↧⍘⍉∺'÷∶+¯∶∵⊟¯.√

  # is there a better way to set negative values to NaN?
  ×+1√¯<0.
  ×1+×0∶⍚[0 1]⊗→'⍉∶.→∶./↧.

  # This is not fast, but it works.
  →(∺×,)
  →∶∶⍘⍉∵(?(⊡∶sp)'↯3),,=0×0.
  ∵(?(⊡∶rad)·)
  # Here is where albedo would be extracted.
  ⍚[∞ ¯1]÷→-
  # Here is where the next ray needs to be modified by random unit.
  # Not sure how to collect if albedo is also here but not used yet.
  # want to collect in 2 arrays I guess.
  # Might need to pass empty ones in and just append to them.
)

norm r

⍉×0.5+1
⍉+⍚[0 ∞]×[1 1 1]-∶1∶⍚[0 ∞]×[0.5 0.7 1].×0.5+1⊡1⍚[∞ ¯1]÷√/+×..∶
⍚[0 0 0](;?∶·)=0×0.∶
⍉÷→/+⧻.⍉⍉
&ims
