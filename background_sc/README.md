# Included commands and usage
## scenecontrol(_timing_, bgcreate, _filename_)
1. _timing_ - not used, should be left as 0 (can be used to change the initial ordering of the created images by setting different timings)
2. _filename_ - full name of the image that you want to use, including its file extension (e.g., "base_conflict.jpg")

**These commands use the filename used here as an identifier of which background image should be modified.**

Works both with .jpg and .png files. **The files have to be within the Scenecontrol folder of the chart.**
## scenecontrol(_timing_, bgshow, _end_timing_, _filename_, _alpha_, _easing_)
1. _timing_ - when the background should start easing into its new alpha value
2. _end_timing_ - when the background should reach the specified alpha value
3. _filename_ - identifying filename of an already existing background
4. _alpha_ - end alpha value of the background
5. _easing (optional)_ - linear by default

Use "base" as the filename to change the base background's alpha value
## scenecontrol(_timing_, bgsetlayer, _filename_, _layer_, _layer_group_)
1. _timing_ - when the layer of the background should be changed
2. _filename_ - identifying filename of an already existing background
3. _layer_ - integer that determines the layer within which the background should be placed. Higher values are visible first
4. _layer_group_ (optional) - determines which of the two layer groups the image should be placed in

In "Foreground" layers will be placed and be visible 'above' the track, I recommend only using it with .png files that don't obstruct the track.

In "Background" layers will be placed 'below' the track. Every background is in "Background" by default.
