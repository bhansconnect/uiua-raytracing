tc ← 7

ar ← ÷9 16
iw ← 50
vh ← 2

md ← 50
sm ← 10
tm ← 0.001

fl ← 1
cc ← [0 0 0]

lam ← 0
met ← 1

c ← [[0 0 ¯1] [0 ¯100.5 ¯1] [¯1 0 ¯1] [1 0 ¯1]]
r ← [0.5 100 0.5 0.5]
mc ← [[0.7 0.3 0.3] [0.8 0.8 0] [0.8 0.8 0.8] [0.8 0.6 0.2]]
mt ← [lam lam met met]

ih ← ↥1⌊÷ar iw
vw ← ×vh ÷ih iw

vu ← [vw 0 0]
vv ← [0 ¯vh 0]

pdu ← ÷iw vu
pdv ← ÷ih vv
pduv ← +pdu pdv

ulc ← -÷2vu -÷2vv -[0 0 fl] cc
pz ← +×0.5pduv ulc

Rv ← ↯∶[⍥⚂]/×.
Ru ← ↯⊂3∶⊂⊟⊙(×○)×○+η,,⊃(×τ[⍥⚂])(○⍘(○+η).-1×2[⍥⚂])/×.↘1

nan ← ÷0 0
NegToNaN ← +√¯<tm.
MashNaN ← ⍚[0 1]⊡⊙'⍉⊟¬=0×0.
Bgd ← +⍚[0 ∞]×[1 1 1]-∶1∶⍚[0 ∞]×[0.5 0.7 1].×0.5+1⊡1∺'÷∶∶√/+×..

Step ← (
  # Hit each sphere at time or nan
  # orig cdir fdir color
  ∺'/+×,,⊙∶∺-c.
  # bhalf oc cdir orig fdir color
  ⊙(∺×⊙(./+×..)-×.r≡/+×.)
  # bhalf ac a cdir orig fdir color
  √-∶×.,∶
  # sqrtd bhalf a cdir orig fdir color
  ∺'÷∶↧∩NegToNaN⊃+-⊙¯
  # minroots cdir orig fdir color
  +×⧻c¬=0×0,⊙/↧⍚1'⊢⌂⍉. # Note: makes min NaN index overflow
  # minindex mint cdir orig fdir color
  ⊙(.+⊙∶∺×,)
  # minindex pos pos cdir fdir color
  ⊙-∶⍘⍉⍚[0 ∞]⊡,⊂c[nan nan nan]
  ⊙(∺'÷∶∶)∶⍚[0 ∞]⊡,⊂r nan
  # minindex normal pos cdir fdir color

  # update color and scatter by material type
  ∶⍘⍉⍚[0 ∞]⊡,⊂mc[1 1 1]
  ⍚[0 ∞]⊡∶⊂mt nan
  # mt mc normal pos cdir fdir color
  # For now, just ignoriing material type and doing lambertian
  ⊙⊙⊙;;
  # mc normal pos fdir color
  ⊙(+⊙(∺×∶)∺×∶¬,∶/↧<ⁿ¯8 10.+Ru△..)
  # mc ndir pos fdir color
  ⊙(⊙(⊙×∶)∶)∶
  # ndir pos fdir color
  ⊙(⊙MashNaN.)∶
  # pos ndir fdir color
)

R ← (
  # Look into re-enabling this and other keeps when perf improved
  # /↧=0×0⍉⊢⍘⍉.
  ⍥(
    &pf "█"
    # ⍜▽(
    ⍜⍘⍉(|1
      /∘⇌
      ∩∩⍉
      Step
      ∩∩⍉
      [⊙⊙⊙∘]
    )
    # )
    # break all nan in new rays
    /↧=0×0⍉⊢⍘⍉.
    # .
    ⎋=0/↥
  )md
  # ;
)

# run sampling
↯[¯1 3][⍥.-1sm]⊠(⊂∶0⊂∶)⇡ih⇡iw
+pz×pduv⍘⍉
+×pduv-0.5Rv △.
⊙-.⍘⍉↯∶cc↻1△.
⊙.⊙(∶↯∶1△.)

∩∩⍉
⍉[⊙⊙⊙∘]
⌈÷tc ⧻.
ts ← 
;⍥(↘ts∶↰R↙↧ts⧻..)tc
⍥(⊂↲∶)-1tc↲
&p ""

;;/∘⇌⍘⍉
∩⍉
√÷∶/+∶⧻.↯[sm ih iw 3]⍉ ×Bgd

&ims
