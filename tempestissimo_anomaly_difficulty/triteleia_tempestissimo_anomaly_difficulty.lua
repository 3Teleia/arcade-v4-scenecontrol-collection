-- Tweak this if the text doesn't seem right. It should look good with a 16:9 1920x1080 window.
local TEXT_SCALE_BASE = 0.0491

local difficulty_backgrounds = {}
local difficulty_text_channel = StringChannel.create().addKey(0,"")
local text_alpha = Channel.keyframe().addKey(0,0)
local bg_alpha = {}
local difficulty_text = Scene.createText(Scene.difficultyText.font.valueAt(0),50000,Scene.difficultyText.lineSpacing.valueAt(0))

local text_canvas = Scene.createCanvas(false)
local bg_canvas = Scene.createCanvas(false)
text_canvas.layer = StringChannel.constant("Topmost")
text_canvas.sort = Channel.constant(1000)
bg_canvas.layer = StringChannel.constant("Topmost")
bg_canvas.sort = Channel.constant(999)

difficulty_text.setParent(text_canvas)
difficulty_text.text = difficulty_text_channel
difficulty_text.colorA = text_alpha

-- Creating a channel to allow the anomaly text to scale roughly like the normal difficulty text
local text_scale = Channel.keyframe().addKey(0,TEXT_SCALE_BASE) 
difficulty_text.scaleX = text_scale
difficulty_text.scaleY = Channel.constant(TEXT_SCALE_BASE)

difficulty_text.translationX = Channel.constant(5.87)
difficulty_text.translationY = Channel.constant(2.43)

addScenecontrol("anomalydifficultyon", {"end_timing","filename","difficulty_text","easing"}, function(cmd)
	local timing = cmd.timing
	local end_timing = cmd.args[1]
	local filename = cmd.args[2]
	local diff_text = cmd.args[3]
	local easing = cmd.args[4]
	
	if filename ~= nil and type(filename) == "string" and filename ~= "" then
		if difficulty_backgrounds[filename] == nil then
			difficulty_backgrounds[filename] = Scene.createImage(filename)
			difficulty_backgrounds[filename].rectW = Channel.constant(160)
			difficulty_backgrounds[filename].rectH = Channel.constant(55)
			
			bg_alpha[filename] = Channel.keyframe().addKey(0,0).addKey(timing,0,easing).addKey(end_timing,255,easing)
			difficulty_backgrounds[filename].colorA = bg_alpha[filename]
			difficulty_backgrounds[filename].setParent(bg_canvas)
			
			difficulty_backgrounds[filename].translationX = Channel.constant(5.656)
			difficulty_backgrounds[filename].translationY = Channel.constant(2.43)
		end
		
		if string.len(diff_text) >= 13 then
			text_scale.addKey(timing-1, text_scale.valueAt(timing-2)).addKey(timing, TEXT_SCALE_BASE*(20/(15+string.len(diff_text))))
		end
		
		difficulty_text_channel.addKey(timing-1, "").addKey(timing, diff_text).addKey(end_timing, diff_text)
		bg_alpha[filename].addKey(timing, 0, easing).addKey(end_timing, 255, easing)
		text_alpha.addKey(timing, 0, easing).addKey(end_timing, 255, easing)
	end
end)

addScenecontrol("anomalydifficultyoff", {"end_timing","filename","easing"}, function(cmd)
	local timing = cmd.timing
	local end_timing = cmd.args[1]
	local filename = cmd.args[2]
	local easing = cmd.args[3]
	
	if filename ~= nil and type(filename) == "string" and filename ~= "" then
		if difficulty_backgrounds[filename] == nil then
			log("No difficulty bg with the filename " .. filename)
		else
			difficulty_text_channel.addKey(end_timing-2, difficulty_text_channel.valueAt(timing)).addKey(end_timing, "")
			bg_alpha[filename].addKey(timing, 255, easing).addKey(end_timing, 0, easing)
			text_alpha.addKey(timing, 255, easing).addKey(end_timing, 0, easing)
		end
	end
end)
