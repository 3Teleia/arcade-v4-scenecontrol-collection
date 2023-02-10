# [Highly recommended to use with my other UI control SC](../ui_enable_disable), otherwise the ADDED DIFFICULTY WILL BE COVERED BY THE INFO PANEL due to how ~~Arcade works~~ this SC works, but you'll want to hide the UI if you want it to be like in the game
# If the text size doesn't look correct, please manually adjust the TEXT_SCALE_BASE value at the top of the main .lua file
# Included commands and usage
## scenecontrol(_timing_, anomalydifficultyon, _end_timing, filename, difficulty_text, easing_)
1. _timing_ - when the anomaly difficulty should start appearing
2. _end_timing_ - when the anomaly difficulty should stop appearing
3. _filename_ - the full name of the difficulty background image (e.g. t_difficulty_cut.png)
4. _difficulty_text_ - the text that should be displayed over the difficulty background
5. _easing (optional)_ - easing to use when fading in the new difficulty


The code is made to work with the t_difficulty_cut asset (any 160 x 55px image should fit perfectly).
## scenecontrol(_timing_, anomalydifficultyoff, _end_timing, filename, easing_)
1. _timing_ - when the anomaly difficulty should start disappearing
2. _end_timing_ - anomaly difficulty should stop disappearing
3. _filename_ - the full name of the difficulty background image (e.g. t_difficulty_cut.png)
4. _easing (optional)_ - easing to use when fading out the new difficulty
