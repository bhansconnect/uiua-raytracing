# ThreadCount ← -1NumProcs
ThreadCount ← 1

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

Center ← [[0 ¯1000 0] [0 1 0] [¯4 1 0] [4 1 0]]
Radius ← [1000 1 1 1]
Color ← [[0.5 0.5 0.5] [1 1 1] [0.4 0.2 0.1] [0.7 0.6 0.5]]
Material ← [Lambertian Lambertian Lambertian Lambertian]
ExtraData ← [0 1.5 0 0]

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

Rv ← ↯∶[⍥⚂]/×.
Rus ← ↯⊂3∶⊂⊟⊙(×○)×○+η,,⊃(×τ[⍥⚂])(○⍘(○+η).-1×2[⍥⚂])/×.↘1
Riud ← ↯⊂2∶⊟⊃(×○)(×○+η)⊃(×τ[⍥⚂])(√[⍥⚂])/×.↘1

NaN ← ÷0 0

# TODO: Re-evaluate and clean rewrite maybe
NegToNaN ← +√¯<0.001.
MashNaN ← ↯⊙(⍜▽;⊙∶∶▽,∶=0×0.∩♭)△.
Bgd ← +⍚[0 ∞]×[1 1 1]-∶1∶⍚[0 ∞]×[0.5 0.7 1].×0.5+1⊡1∺'÷∶∶√/+×..
Refl ← -⍚[∞ 1]××2/+×,,
Refr ← (
  # r uv n
  ⊙(↧1/+×¯,,)
  # r ct uv n
  ×⊙(+⍚[∞ 1]×⊙,)
  # perp n
  +⍚[∞ 1]×¯√⌵-∶1/+×.,∶
)

PixelCenters ← ⍉↯[¯1 3]⊠+∺×⇡ImageHeight PixelDeltaV ∺×⇡ImageWidth PixelDeltaU

HitTimes ← (|4
  # Center Origin Direction Radius
  ⊙⊙(∶/+×.)/+×,,-
  # bhalf oc rad dir
  ⊙(×,-×.∶/+×.)
  # bhalf ac a
  ⊙(-∶×.).
  # bhalf disc a
  /↧NegToNaN⊟⊃(÷∶+)(÷∶-)√∶¯
)

LambertianScatter ← (
  # TODO: add signiture when level fixed |5.2
  # Material Color ExtraData Normal Direction
  ⊙(
    ⊙⊙;⊙;
    ⊙(+⊙⍚[∞ ¯1]×⍚[∞ ¯1]×¬,∶/↧<ⁿ¯8 10.+Rus△..)
  )
  # TODO: Switch to both when level fixed
  ⊙⍚[∞ ¯1]×⍚[∞ ¯1]×,∶=Lambertian
)

StepRays ← (
  # TODO: add signiture when level fixed |2.3
  # Origin Direction
  Center ⊙∶∶Radius,,
  ⍚[¯1 ∞ ∞ ¯1]HitTimes
  # TODO: investigate skipping all NaN indices for the rest of the function.
  +×⧻Center¬=0×0,⊙/↧≡'⊢⍏⍉. # Note: makes min NaN index overflow
  ⊙(⊙∶.+⊙∶∺×,⊙∶)
  ⊙-∶⍉⬚NaN⊏,Center
  ⊙(⍚[∞ ¯1]÷)∶⬚NaN⊏,Radius

  ∶⬚NaN⊏,ExtraData
  ∶⍉⬚1⊏,Color
  ⬚NaN⊏∶Material
  # TODO: Should these use under keep to avoid extra work of applying to non-matching rays.
  ⍚[∞ ¯1]×≠Lambertian,,
  ⊙LambertianScatter
  +
  ⊙∶
)

BlackenLiveRays ← (
  # Rays Colors
  ×¬=0×0
)

Sample ← (
  PixelCenters
  +∺×PixelDeltaU-0.5Rv [⊢⇌]△.
  +∺×PixelDeltaV-0.5Rv [⊢⇌]△.
  +PixelZero
  ⍘⍉↯∶CameraCenter↻1△.
  ⊙-.+ ×>0DefocusAngle /+≡∺×[DefocusDiskU DefocusDiskV]Riud△.
  ⊙(⊙(↯∶1△.).)
  ⍥(
    # TODO: Should we under keep on NaN for StepRays?
    StepRays
    ⊙⊙×⊙∶∶
    ⊙',∶
    ⊙⊙⊙MashNaN
  )MaxDepth
  ;
  BlackenLiveRays
  ×⊙Bgd
  &pf "█"
)

SampleN ← (|1
  ↯/[3 ×ImageHeight ImageWidth] 0
  ⍥(+Sample)∶
)

ThreadSize ← ⌈÷ThreadCount Samples

0
≠Samples×ThreadCount ThreadSize
?(&p $"Increasing sample size from _ to _ to evenly utilize threads"Samples ×ThreadCount ThreadSize)∘
≤1ThreadCount
?(SampleN Samples)(|0
  ⍥(↰(SampleN ThreadSize))ThreadCount
  ⍥(+↲∶)-1ThreadCount ↲
)
⊙;
÷×ThreadCount ThreadSize

&p ""
√↯[ImageHeight ImageWidth 3]⍉

&ims
