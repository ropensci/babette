# `pics`

Pictures for `babette`.

## Convert the fuzzy white background of swan picture to one single color

```
convert swan.png -fuzz 15% -fill white -opaque white swan_mono_background.png
convert swan_mono_background.png -background white -alpha remove swan_mono_background_2.png
```
