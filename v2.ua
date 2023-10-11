ThreadCount ← -1NumProcs
# ThreadCount ← 1

ImageWidth ← 200
MaxDepth ← 50
Samples ← 10

AspectRatio ← ÷9 16
VerticalFov ← 20
DefocusAngle ← 0.6
FocusDist ← 10
CameraCenter ← [13 2 3]
LookAt ← [0 0 0]
Up ← [0 1 0]

Lambertian ← 0
Metal ← 1
Dielectric ← 2

Rv ← ↯∶[⍥⚂]/×.
+×[0.9 0 0.9]Rv△.⍉↯[¯1 3]⊠(⊂⊂∶0.2).-11⇡22
⍚[∞ 1]▽>0.9√/+×.-[4 0.2 0].
⍘⍉⊂⊟↯△,0↯△,0.5↯△,0
∶Rv↙1△.
⍜▽(|1 
  ⍜⍉(|1
    /∘⇌
    ⊙(×∩Rv.△)
    ⊙⊙(↯∶Lambertian△)
    [⊙⊙∘]
  )
)<0.8,
⍜▽(|1 
  ⍜⍉(|1
    /∘⇌
    ⊙(+0.5×0.5Rv△)
    ↯∶×0.5Rv ↘1.△
    ⊙⊙(↯∶Metal△)
    [⊙⊙∘]
  )
)↧⊃(≥0.8)(<0.95),
⍜▽(|1 
  ⍜⍉(|1
    /∘⇌
    ⊙(↯∶1△)
    ↯∶1.5△
    ⊙⊙(↯∶Dielectric△)
    [⊙⊙∘]
  )
)≥0.95∶
∩∩⍉/∘⇌⍉
ExtraData ←
Color ←
≡⊢
Material ←
Center ←
Radius ← ↯⧻ Center 0.2

ExtraData ← ⊂ ⊢⍉ExtraData [0 1.5 0 0]
Color ← ⊂ Color [[0.5 0.5 0.5] [1 1 1] [0.4 0.2 0.1] [0.7 0.6 0.5]]
Material ← ⊂ Material [Lambertian Dielectric Lambertian Metal]
Center ← ⊂ Center [[0 ¯1000 0] [0 1 0] [¯4 1 0] [4 1 0]]
Radius ← ⊂ Radius [1000 1 1 1]

Cross ← -⊙(×⊙'↻¯1↻1)×⊙'↻1↻¯1,,

Theta ← ÷180×πVerticalFov
DefocusRadius ← ×FocusDist÷⊃(○+η)○÷2÷180×πDefocusAngle
ViewportHeight ← ××2 FocusDist ÷⊃(○+η)○÷2Theta
ImageHeight ← ↥1⌊÷AspectRatio ImageWidth
ViewportWidth ← ×ViewportHeight ÷ImageHeight ImageWidth

w ← ÷√/+×..-LookAt CameraCenter
u ← ÷√/+×.. Cross Up w
v ← Cross w u

ViewportU ← ×u ViewportWidth
ViewportV ← ×¯v ViewportHeight
DefocusDiskU ← ×u DefocusRadius
DefocusDiskV ← ×v DefocusRadius

PixelDeltaU ← ÷ImageWidth ViewportU
PixelDeltaV ← ÷ImageHeight ViewportV

UpperLeftCorner ← -÷2ViewportU -÷2ViewportV -×FocusDist w CameraCenter
PixelZero ← +×0.5+PixelDeltaV PixelDeltaU UpperLeftCorner

Rus ← ↯⊂3∶⊂⊟⊙(×○)×○+η,,⊃(×τ[⍥⚂])(○⍘(○+η).-1×2[⍥⚂])/×.↘1
Riud ← ↯⊂2∶⊟⊃(×○)(×○+η)⊃(×τ[⍥⚂])(√[⍥⚂])/×.↘1

NaN ← ÷0 0

# TODO: Re-evaluate and clean rewrite maybe
NegToNaN ← +√¯<0.001.
Bgd ← +⍚[0 ∞]×[1 1 1]-∶1∶⍚[0 ∞]×[0.5 0.7 1].×0.5+1⊡1∺÷√/+×..
Refl ← -⍚[∞ 1]××2/+×,,
Refr ← (
  # r uv n
  ⊙(↧1/+×¯,,)
  # r ct uv n
  ∺×⊙(+∺×⊙,)
  # perp n
  +∺×¯√⌵-∶1/+×.,∶
)

PixelCenters ← ↯[¯1 3]⊠+∺×PixelDeltaV ⇡ImageHeight ∺×PixelDeltaU ⇡ImageWidth

HitTimes ← (|4
  # Center Origin Direction Radius
  ⊙⊙(∶/+×.)/+×,,-
  # bhalf oc rad dir
  ⊙(×,-×.∶/+×.)
  # bhalf ac a
  ⊙(-∶×.).
  # bhalf disc a
  ⊃(÷∶+)(÷∶-)√∶¯
  ↧∩NegToNaN
)

LambertianScatter ← (|5.2
  # Material Color ExtraData Normal Direction
  ⊙(
    ⊙⊙;⊙;
    ⊙(+⊙∺×∺×¬,∶/↧<ⁿ¯8 10.+Rus△..)
  )
  ∩∺×,∶=Lambertian
)

MetalScatter ← (|5.2
  # Material Color ExtraData Normal Direction
  ⊙(
    ⊙⊙(Refl,∶)
    # mc d ref norm
    ⊙(>0/+×,∶+∺×∶Rus⊂3△.)
    ∺×∶
  )
  ∩∺×,∶=Metal
)

DielectricScatter ← (|5.2
  ⊙(
    # mc d outnorm cdir
    ⊙⊙(⊙∺×.-1×2≤0/+×,,)
    # mc d ff norm cdir
    ⊙(ⁿ¯∶)
    # mc rr norm cdir
    ⊙⊙(⍚[∞ 1]÷√/+×..∶)
    # mc rr ud norm
    # ⊙(↯⊂3△.)
    ⊙⊃⊃(Refl∶;)(↥⊃(>1×∶⊙(√-∶1×.))(>Rv↘1△.+⊙(×∶⊙(ⁿ5-∶1))∶-,1×.÷⊃+-∶1)⊙(↧1/+×¯))Refr
    # Cleanup NaNs in Refr.
    # TODO: Look at rewriting this function or nicer ways to do this.
    ⊙⊙⊙(↯⊙(⍜▽(↯∶0△)∩♭)△.≠0×0.)
    ⊙(+⊙'∺×¬∺×,)
    # mc ndir
  )
  ∩∺×,∶=Dielectric
)

StepRays ← (|3.4
  # Origin Direction I
  Center ⊙∶∶Radius,,
  ⍚[¯1 ∞ ∞ ¯1]HitTimes
  =0×0,⊙/↧≡'⊢⍏⍉.
  # Remove NaN rays from rest of computation
  ⊙⊙⊙⊙▽⊙⊙⊙(∺▽,∶)⊙⊙(∺▽,∶)⊙(▽,∶)▽,∶
  ⊙(⊙∶.+⊙∶∺×⊙.⊙∶)
  ⊙-∶⍉⊏,Center
  ⊙∺÷∶⊏,Radius

  ∶⊏,ExtraData
  ∶⍉⊏,Color
  ⊏∶Material

  # TODO: Should these use under keep to avoid extra work of applying to non-matching rays.
  ⊃⊃LambertianScatter MetalScatter DielectricScatter
  ∩+⊙∶
  ∩+⊙∶
  ⊙∶
)

SampleRaysOnce ← (
  +∺×∶PixelDeltaU-0.5Rv [⊢⇌]△.
  +∺×∶PixelDeltaV-0.5Rv [⊢⇌]△.
  +PixelZero
  ⍘⍉↯∶CameraCenter↻1△.
  ⊙-.+ ×>0DefocusAngle /+≡∺×∶[DefocusDiskU DefocusDiskV]Riud△.
  ⊙(⊙(⇡⊡1△.↯∶1△.).)
  ⊙⊙(⊙∩⍉⍉)
  ⍥(
    StepRays
    # col ori dir I oldcol olddir
    # Merge
    # This is a mess, but it just does some under select based merging after shuffling the stack.
    # It is also the core slowness of the entire code.
    ⊙⊙⊙(,∶)
    ⊙⊙∶⊙∶∶
    ⊙⊙⊙(⍜⊏(×⊙⍉)⊙∶∶⊙,)
    ⊙⊙⊙⊙⊙∶⊙⊙⊙⊙∶⊙⊙⊙∶⊙⊙∶⊙.
    ⊙⊙⊙⊙(⍜⊏(⍉;))
    ⎋=0/×△.
  )MaxDepth
  ;;
  ⍜⊏(↯∶0△)
  ∩⍉
  ×⊙Bgd
  &pf "█"
)

SampleRays ← (|1
  ↯∶0△.
  ⍥(+SampleRaysOnce ,)Samples
  ⊙;
)

≤1ThreadCount
?(|0 ⍜⍉SampleRays PixelCenters)(|0
  -1\+∊⇡⧻PixelCenters⁅×⇡ThreadCount⌈÷ThreadCount ⧻PixelCenters
  ⊕(spawnSampleRays ⍉)∶PixelCenters
  ∧(⊂ ⊙'⍉wait) ↯[0 3][]
)
÷Samples

&p ""
√↯[ImageHeight ImageWidth 3]

&ims
