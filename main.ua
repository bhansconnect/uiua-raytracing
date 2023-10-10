tc ← -1NumProcs
# tc ← 1
ss ← ÷tc 50000

iw ← 200
md ← 20
sm ← 21

ar ← ÷9 16
VFov ← 20
da ← 0.6
fd ← 10
cc ← [13 2 3]
la ← [0 0 0]
Vup ← [0 1 0]

Lam ← 0
Met ← 1
Die ← 2

Rv ← ↯∶[⍥⚂]/×.

+×[0.9 0 0.9]Rv△.⍉↯[¯1 3]⊠(⊂⊂∶0.2).-11⇡22
⍚[∞ 1]▽>0.9√/+×.-[4 0.2 0].
⍘⍉⊂⊟↯△,0↯△,0.5↯△,0
∶Rv↙1△.
⍜▽(|1
  ⍜⍉(|1
    /∘⇌
    ⊙(×∩Rv.△)
    ⊙⊙(↯∶Lam△)
    [⊙⊙∘]
  )
)<0.8,
⍜▽(|1
  ⍜⍉(|1
    /∘⇌
    ⊙(+0.5×0.5Rv△)
    ↯∶×0.5Rv ↘1.△
    ⊙⊙(↯∶Met△)
    [⊙⊙∘]
  )
)↧⊃(≥0.8)(<0.95),
⍜▽(|1
  ⍜⍉(|1
    /∘⇌
    ⊙(↯∶1△)
    ↯∶1.5△
    ⊙⊙(↯∶Die△)
    [⊙⊙∘]
  )
)≥0.95∶
∩∩⍉/∘⇌⍉
d ←
mc ←
≡⊢
mt ←
c ←
r ← ↯⧻ c 0.2

d ← ⊂ d [[0 0 0] [1.5 1.5 1.5] [0 0 0] [0 0 0]]
mc ← ⊂ mc [[0.5 0.5 0.5] [1 1 1] [0.4 0.2 0.1] [0.7 0.6 0.5]]
mt ← ⊂ mt [Lam Die Lam Met]
c ← ⊂ c [[0 ¯1000 0] [0 1 0] [¯4 1 0] [4 1 0]]
r ← ⊂ r [1000 1 1 1]

Cross ← -⊙(×⊙'↻¯1↻1)×⊙'↻1↻¯1,,

Theta ← ÷180×πVFov
h ← ÷⊃(○+η)○÷2Theta
dr ← ×fd÷⊃(○+η)○÷2÷180×πda
vh ← ××2 h fd
ih ← ↥1⌊÷ar iw
vw ← ×vh ÷ih iw

w ← ÷√/+×..-la cc
u ← ÷√/+×.. Cross Vup w
v ← Cross w u

vu ← ×u vw
vv ← ×¯v vh
du ← ×u dr
dv ← ×v dr

Pdu ← ÷iw vu
Pdv ← ÷ih vv

Ulc ← -÷2vu -÷2vv -×fd w cc
pz ← +×0.5+Pdv Pdu Ulc

Rus ← ↯⊂3∶⊂⊟⊙(×○)×○+η,,⊃(×τ[⍥⚂])(○⍘(○+η).-1×2[⍥⚂])/×.↘1
Riud ← ↯⊂2∶⊟⊃(×○)(×○+η)⊃(×τ[⍥⚂])(√[⍥⚂])/×.↘1

NaN ← ÷0 0
NegToNaN ← +√¯<0.001.
MashNaN ← ⍚[0 1]⊡⊙'⍉⊟≠0×0.
Bgd ← +⍚[0 ∞]×[1 1 1]-∶1∶⍚[0 ∞]×[0.5 0.7 1].×0.5+1⊡1∺÷√/+×..
Refl ← -⍚[∞ 1]××2/+×,,
Refr ← (
  # r uv n
  ⊙(↧1/+×¯,,)
  # r ct uv n
  ×⊙(+⍚[∞ 1]×⊙,)
  # perp n
  +⍚[∞ 1]×¯√⌵-∶1/+×.,∶
)

Step ← (|4.4
  # Hit each sphere at time or nan
  # orig cdir fdir color
  ∺'/+×⊙.,⊙∶⍚[¯1 ∞]-c.
  # bhalf oc cdir orig fdir color
  ⊙(∺×∶⊙(./+×..)-×.r≡/+×.)
  # bhalf ac a cdir orig fdir color
  √-∶×.,∶
  # sqrtd bhalf a cdir orig fdir color
  /↧⊟∩NegToNaN⊃(⍚[∞ 1]÷∶+)(⍚[∞ 1]÷∶-)⊙¯
  # minroots cdir orig fdir color
  +×⧻c≠0×0,⊙/↧≡'⊢⍏⍉. # Note: makes min NaN index overflow
  # minindex mint cdir orig fdir color
  ⊙(.+⊙∶∺×⊙.)
  # minindex pos pos cdir fdir color
  ⊙-∶⍘⍉⍚[0 ∞]⊡,⊂c[NaN NaN NaN]
  ⊙⊙∶⊙∺÷∶⍚[0 ∞]⊡,⊂r NaN
  # minindex normal cdir pos fdir color

  # update color and scatter by material type
  ∶⍘⍉⍚[0 ∞]⊡,⊂d [NaN NaN NaN]
  ∶⍘⍉⍚[0 ∞]⊡,⊂mc[1 1 1]
  ⍚[0 ∞]⊡∶⊂mt NaN
  # mt mc d normal cdir pos fdir color
  ∶⊙(⍘⍉⊂⊂⊟)
  # mc_d_normal_cdir mt pos fdir color

  # TODO: Is under keep better
  # Or should I run all material functions on all spheres
  ⍜▽(|1
    ⍜⍉(|1
      /∘⇌
      ⊙⊙(+⊙∺×∺×¬,∶/↧<ⁿ¯8 10.+Rus△..)
      [⊙⊙⊙∘]
    )
  )=Lam,
  ⍜▽(|1
    ⍜⍉(|1
      /∘⇌
      # mc d norm cdir
      ⊙⊙(Refl,,)
      # mc d ref norm cdir
      ⊙∶∺×∶⊙(>0/+×,∶⊙∶+×Rus△.,∶)
      # mc d ndir cdir
      [⊙⊙⊙∘]
    )
  )=Met,
  ⍜▽(|1
    ⍜⍉(|1
      /∘⇌
      # mc d outnorm cdir
      ⊙⊙(⊙∺×.-1×2≤0/+×,,)
      # mc d ff norm cdir
      ⊙(⊙⍚[∞ 1]ⁿ,¯∶)
      # mc d rr norm cdir
      ⊙⊙⊙(⍚[∞ 1]÷√/+×..,)
      # mc d rr ud norm cdir
      ⊙⊙⊃⊃(Refl∶;)(↥⊃(>1∺×∶⊙(√-∶1×.))(⍚[∞ 1]>Rv↘1△.+⊙(∺×∶⊙(ⁿ5-∶1))∶-,1×.÷⊃+-∶1)⊙(↧1/+×¯))Refr
      ⊙⊙(+⊙'×¬×,)
      # mc d ndir cdir
      [⊙⊙⊙∘]
    )
  )=Die,
  # mc_d_ndir_cdir mt pos fdir color
  ⊙⊙;⊙;/∘⇌⍉⊙;
  # mc ndir pos fdir color
  ⊙(⊙(⊙×∶)∶)∶
  # ndir pos fdir color
  ⊙(⊙MashNaN.)∶
  # pos ndir fdir color
)

StepShard ← (|1
  ⍜⍘⍉(|1
    /∘⇌
    ∩∩⍉
    Step
    ∩∩⍉
    [⊙⊙⊙∘]
  )
)

R ← (
  # Look into re-enabling this and other keeps when perf improved
  /↧=0×0⍉⊢⍘⍉.
  ⍥(|2.2
    &pf "█"
    ⍜▽(|1
      # TODO: look into a better way to shard/ other memory reduction ideas.
      ⊂∶↘1△,⊂∶⌈÷,∶⌈÷ss.⧻.
      ∶⊙⬚NaN↯⧻,
      ≡StepShard
      ↙∶/⊂
    )
    # break all nan in new rays
    /↧=0×0⍉⊢⍘⍉.
    ⎋=0/↥.
  )md
  # Make the color of still live rays black.
  # ⍜⍘⍉(⍜'⊡3×)∶¬
  ;
)

# run sampling
⍉↯[¯1 3]↯⊂sm△.⊠+∺×∶⇡ih Pdv ∺×∶⇡iw Pdu
+∺×∶Pdu-0.5Rv [⊢⇌]△.
+∺×∶Pdv-0.5Rv [⊢⇌]△.
+pz
⍘⍉↯∶cc↻1△.
⊙-.+ ×>0da /+≡∺×∶[du dv]Riud△.
⊙.⊙(∶↯∶1△.)

∩∩⍉
⍉[⊙⊙⊙∘]
⌈÷tc ⧻.
ts ←
?R(|1
  ;⍥(↘ts∶spawnR↙↧ts⧻..)tc
  ⍥(⊂wait∶)-1tc wait
) ≤1tc
&p ""

;;/∘⇌⍘⍉
∩⍉
√÷∶/+∶⧻.↯[sm ih iw 3]⍉ ×Bgd

&ims
