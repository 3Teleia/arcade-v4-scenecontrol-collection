# Highly recommended to use with my other UI control SC
# If the text size doesn't look correct, please manually adjust the TEXT_SCALE_BASE value at the top of the main .lua file
# Included commands and usage
# scenecontrol(timing, anomalydifficultyon, end_timing, filename, difficulty_text, easing)
1. timing - when the anomaly difficulty should start appearing
2. end_timing - when the anomaly difficulty should stop appearing
3. filename - the full name of the difficulty background image (e.g. t_difficulty_cut.png)

The code is made to work with the t_difficulty_cut asset (any 160 x 55px image should fit perfectly).

4. difficulty_text - the text that should be displayed over the difficulty background
5. easing (optional) - easing to use when fading in the new difficulty


# scenecontrol(timing, anomalydifficultyoff, end_timing, filename, easing)
1. timing - when the anomaly difficulty should start disappearing
2. end_timing - anomaly difficulty should stop disappearing
3. filename - the full name of the difficulty background image (e.g. t_difficulty_cut.png)
4. easing (optional) - easing to use when fading out the new difficulty
