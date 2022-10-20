# Included commands and usage
# scenecontrol(timing, bgcreate, filename)
1. timing - not used, should be left as 0
2. filename - full name of the image that you want to use, including its file extension (e.g., "base_conflict.jpg")

These commands use the filename used here as an identifier of which background image should be modified.

Works both with .jpg and .png files. The files have to be within the Scenecontrol folder of the chart.
# scenecontrol(timing, bgshow, end_timing, filename, alpha, easing)
1. timing - when the background should start easing into its new alpha value
2. end_timing - when the background should reach the specified alpha value
3. filename - identifying filename of an already existing background
4. alpha - end alpha value of the background
5. easing (optional) - linear by default

Use "base" as the filename to change the base background's alpha value
# scenecontrol(timing, bgsetlayer, filename, layer, layer_group)
1. timing - when the layer of the background should be changed
2. filename - identifying filename of an already existing background
3. layer - integer that determines the layer within which the background should be placed. Higher values are visible first
4. layer_group (optional) - determines which of the two layer groups the image should be placed in

In "Foreground" layers will be placed and be visible 'above' the track, I recommend only using it with .png files that don't obstruct the track.

In "Background" layers will be placed 'below' the track. Every background is in "Background" by default.
