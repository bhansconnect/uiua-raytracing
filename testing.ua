ar ← ÷9 16
iw ← 100
vh ← 2

sm ← 3
tm ← 0.001

fl ← 1
cc ← [0 0 0]

s ← [[0 0 ¯1] [0 ¯100.5 ¯1]]
r ← [0.5 100]
m ← [[0.7 0.3 0.3] [0.8 0.8 0]]

ih ← ↥1⌊÷ar iw
vw ← ×vh ÷ih iw

vu ← [vw 0 0]
vv ← [0 ¯vh 0]

pdu ← ÷iw vu
pdv ← ÷ih vv
pduv ← +pdu pdv

ulc ← -÷2vu -÷2vv -[0 0 fl] cc
pz ← +×0.5pduv ulc

rv ← ↯∶[⍥⚂]/×.

bgd ← +⍚[0 ∞]×[1 1 1]-∶1∶⍚[0 ∞]×[0.5 0.7 1].×0.5+1⊡1∺'÷∶∶√/+×..

[⍥.-1sm]⊠(⊂∶0⊂∶)⇡ih⇡iw
+pz×pduv⍘⍉
+×pduv-0.5rv △.
⊙-.⍘⍉↯∶cc↻1△.
⊙.⊙(∶↯∶1△.)

# run sampling
# Hit each sphere at time or nan

# orig cdir fdir color
∺'/+×,,⊙∶∺-s.
# bhalf oc cdir orig fdir color
⊙(∺×⊙(./+×..)-×.r≡/+×.)
# bhalf ac a cdir orig  fdir color
√-∶×.,∶
# sqrtd bhalf a cdir orig  fdir color
NegToNaN ← (⍜♭(⍜♭(⍜▽(×÷0 0)∶)∶)∘<tm.)
∺'÷∶↧∩NegToNaN⊃+-⊙¯
# minroot cdir orig  fdir color
# Clear out negative hits
# update by material type

# ;;
# √÷∶/+∶⧻.⍉ ×bgd
⍉/↧
&ims
;;;;
