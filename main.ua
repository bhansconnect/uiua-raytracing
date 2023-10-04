ar ← ÷9 16
iw ← 100
ih ← ⌊÷ar iw

md ← 50
sam ← 100

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
a ← ↯△ r1

ccr ← ⍘⍉↯↻1△r ⍉[cc]

# TODO: find  better way to do this
mashNaN ← ↯→(⍜▽;→∶∶▽,∶→∶¬=0×0.∷♭)△.

unit ← ⍚[∞ ¯1]÷√/+×..

norm ← (
  &pf "X"
  # Save forgetten thing to use later
  # This should really be saved in a different way
  →→→∶→→∶→∶.
  ∶→∶∶/+×..∶∺-sp
  →→∶∺(/+×),,
  +∶×.,¯∺×→,-×.rad≡/+×.∶
  /↧⍘⍉∺'÷∶+¯∶∵⊟¯.√

  # is there a better way to set negative values to NaN?
  ×+1√¯<0.
  ×1+×0∶⍚[0 1]⊗→'⍉∶.→∶./↧.

  # This is not fast, but it works.
  →(.∺×∶)
  →∶∶⍘⍉∵(?(⊡∶sp)'↯3),,=0×0.
  ∵(?(⊡∶rad)·)
  # Here is where albedo could be extracted.
  ⍚[∞ ¯1]÷→-
  # unit random perturbing...This is technically wrong.
  +unit rv△.
  # dir rt oldr olda ccr to (rt+ccr) dir mergedR mergedA
  +→∶→→∶→→→∶∶
  →(→'∶mashNaN.)
  →(→∶∶×↧1+0.5¬=0×0,∶)
)

;;⍥norm md ccr r r a

&p ""

⍉+⍚[0 ∞]×[1 1 1]-∶1∶⍚[0 ∞]×[0.5 0.7 1].×0.5+1⊡1unit
√ ⍉÷→/+⧻.⍉⍉
√×⍉÷→/+⧻.⍘⍉∶
&ims
