# Included commands and usage
# Mixing different disable and enable modes will work
# scenecontrol(timing, disableui, end_timing, mode, easing)
1. timing - when the UI should start disappearing
2. end_timing - when the UI should stop disappearing
3. mode - how the UI should disappear. Supported modes are:

      "up" - makes the whole UI disappear upwards 
  
      "sides" - makes the UI disappear to the sides
  
      "fadeout" (default) - makes the UI become transparent
  
4. easing (optional) - easing to use when disappearing, linear by default
# scenecontrol(timing, enableui, end_timing, mode, easing)
1. timing - when the UI should start appearing
2. end_timing - when the UI should stop appearing
3. mode - how the UI should appear. Supported modes are:

      "down" - makes the whole UI move in from above into its default position
  
      "sides" - makes the UI appear from the sides into its default position
  
      "fadein" (default) - makes the UI become fully opaque
  
4. easing (optional) - easing to use when appearing, linear by default
