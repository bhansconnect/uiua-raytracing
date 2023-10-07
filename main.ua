tc ← -1NumProcs

iw ← 50
md ← 50
sm ← 10

ar ← ÷9 16
vfov ← 90
cc ← [0 0 0]

lam ← 0
met ← 1
R ← ○+η÷4π
c ← [[¯R 0 ¯1] [R 0 ¯1]]
r ← [R R]
mc ← [[0 0 1] [1 0 0]]
d ← [[0 0 0] [0 0 0]]
mt ← [lam lam]

fl ← 1
theta ← ÷180×πvfov
h ← ÷⊃(○+η)○÷2theta
vh ← ××2 h fl
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
NegToNaN ← +√¯<0.001.
MashNaN ← ⍚[0 1]⊡⊙'⍉⊟¬=0×0.
Bgd ← +⍚[0 ∞]×[1 1 1]-∶1∶⍚[0 ∞]×[0.5 0.7 1].×0.5+1⊡1∺'÷∶∶√/+×..
Ref ← -⍚[∞ 1]××2/+×,,

Step ← (|4.4
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
  +×⧻c¬=0×0,⊙/↧⍚1'⊢⍏⍉. # Note: makes min NaN index overflow
  # minindex mint cdir orig fdir color
  ⊙(.+⊙∶∺×,)
  # minindex pos pos cdir fdir color
  ⊙-∶⍘⍉⍚[0 ∞]⊡,⊂c[nan nan nan]
  ⊙⊙∶⊙(∺'÷∶∶)∶⍚[0 ∞]⊡,⊂r nan
  # minindex normal cdir pos fdir color

  # update color and scatter by material type
  ∶⍘⍉⍚[0 ∞]⊡,⊂d [nan nan nan]
  ∶⍘⍉⍚[0 ∞]⊡,⊂mc[1 1 1]
  ⍚[0 ∞]⊡∶⊂mt nan
  # mt mc d normal pos cdir fdir color
  ∶⊙(⍘⍉⊂⊂⊟)
  # mc_d_normal_cdir mt pos fdir color

  # TODO: Is under keep better
  # Or should I run all material functions on all spheres
  ⍜▽(|1 ⍜⍉(|1
      /∘⇌
      ⊙⊙(+⊙(∺×∶)∺×∶¬,∶/↧<ⁿ¯8 10.+Ru△..)
      [⊙⊙⊙∘]
    ))=lam,
  ⍜▽(|1 ⍜⍉(|1
      /∘⇌
      # mc d norm cdir
      ⊙⊙(Ref,,)
      # mc d ref norm cdir
      ⊙∶∺×⊙(>0/+×,∶⊙∶+×Ru△.,∶)
      # mc d ndir cdir
      [⊙⊙⊙∘]
    ))=met,
  # mc_d_ndir_cdir mt pos fdir color
  ⊙⊙;⊙;/∘⇌⍉⊙;
  # mc ndir pos fdir color
  ⊙(⊙(⊙×∶)∶)∶
  # ndir pos fdir color
  ⊙(⊙MashNaN.)∶
  # pos ndir fdir color
)

R ← (
  # Look into re-enabling this and other keeps when perf improved
  /↧=0×0⍉⊢⍘⍉.
  ⍥(|2.2
    &pf "█"
    ⍜▽(|1 ⍜⍘⍉(|1
        /∘⇌
        ∩∩⍉
        Step
        ∩∩⍉
        [⊙⊙⊙∘]
      ))
    # break all nan in new rays
    /↧=0×0⍉⊢⍘⍉.
    ⎋=0/↥.
  )md
  # Make the color of still live rays black.
  ⍜⍘⍉(⍜'⊡3×)∶¬
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
?R(|1
  ;⍥(↘ts∶↰R↙↧ts⧻..)tc
  ⍥(⊂↲∶)-1tc↲
) ≤1tc
&p ""

;;/∘⇌⍘⍉
∩⍉
√÷∶/+∶⧻.↯[sm ih iw 3]⍉ ×Bgd

&ims
