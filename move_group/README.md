## Like with camera commands, commands for movement along different axes can be written separately, e.g. to start and finish at different times or to use different easings
# Included commands and usage
## scenecontrol(timing, movenotegroup, end_timing, timing_group, x, y, z, easing)
1. timing - when the notes should start moving
2. end_timing - when the notes should stop moving
3. timing_group - the number of the timing group/note group to move, 0 is the base note group
4. x, y, z - to which coordinate on each respective axis the group should be moved, any can be left as 0

x = left and right, y = up and down, z = forwards and backwards

5. easing (optional) - easing to use when moving the note group, applies to all axes


## scenecontrol(timing, movenotegroupdelta, end_timing, timing_group, dx, dy, dz, easing)
1. timing - when the notes should start moving
2. end_timing - when the notes should stop moving
3. timing_group - the number of the timing group/note group to move, 0 is the base note group
4. dx, dy, dz - by how much the note group should be moved along each respective axis, any can be left as 0
5. easing (optional) - easing to use when moving the note group, applies to all axes
