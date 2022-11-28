bg_alpha_channels = {}
bg_layer_channels = {}
bg_layer_group_channels = {}
bg_canvases = {}
bg_top_layer = 0

-- Replace the alpha channel of the base BG
base = Scene.background
bg_alpha_channels["base"] = Channel.named("base").keyframe().addKey(0,255)

-- Replace alpha, layer and sort channels of the video BG (unlike the base BG it's technically a sprite
-- so it has its own layer and sort values that can be controlled easily
videobg = Scene.videoBackground
bg_alpha_channels["video"] = Channel.named("video").keyframe().addKey(0,255)
bg_layer_channels["video"] = Channel.named("video").keyframe().setDefaultEasing('inconst').addKey(0,videobg.sort.valueAt(0))
bg_layer_group_channels["video"] = StringChannel.create().addKey(0,videobg.layer.valueAt(0))
videobg.colorA = bg_alpha_channels["video"]
videobg.sort = bg_layer_channels["video"]
videobg.layer = bg_layer_group_channels["video"]

function create_bg (filename)
	-- Check if the filename is a normal string
	-- otherwise it crashes if you use the SC menu in Arcade and add a new line with the + button
	if filename ~= nil and filename ~= '' and type(filename) == "string" then
	
		-- Initialize a new channel for the new BG's alpha values and default it to 0
		bg_alpha_channels[filename] = Channel.named(filename).keyframe().setDefaultEasing('l').addKey(0,0)
		
		-- Increment the value used to keep track of the topmost BG layer
		bg_top_layer = bg_top_layer + 1
		
		-- Create a new image from the given filename
		local new_bg = Scene.createImage(filename)
		-- Set the image's width and height respectively
		new_bg.rectW = Channel.constant(1280)
		new_bg.rectH = Channel.constant(960)
		
		-- Basically magic numbers, I don't know why the normal sizes don't properly fit the Arcade window
		new_bg.scaleX = Channel.constant(1.0084)
		new_bg.scaleY = Channel.constant(1.0084)
		
		-- Creates a canvas for the new BG image
		local new_canvas = Scene.createCanvas(false)
		
		-- Places the new BG on the top of the BG "stack", uses a channel so that the layer and layer group can be easily changed later on
		bg_layer_channels[filename] = Channel.named(filename).keyframe().setDefaultEasing('inconst').addKey(0,bg_top_layer)
		bg_layer_group_channels[filename] = StringChannel.create().addKey(0,"Background")
		
		new_canvas.layer = bg_layer_group_channels[filename]
		new_canvas.sort = bg_layer_channels[filename]
		
		-- Make the new canvas use the alpha values given by the previously defined channel
		new_canvas.alpha = bg_alpha_channels[filename]
		
		-- Save the canvas for later usage in bgshow and bgsetlayer
		bg_canvases[filename] = new_canvas
		
		-- Parent the new BG to the canvas so that changing the alpha or layering of the canvas would affect the BG
		new_bg.setParent(bg_canvases[filename])
	end
end

function bg_change_opacity(timing, end_timing, filename, alpha, easing)
	if filename ~= nil and filename ~= '' and type(filename) == "string" then
		-- Get the alpha value of the specified BG at the start timing
		local start_alpha = 0
		if filename == "base" then
			start_alpha = base.colorA.valueAt(timing)
		elseif filename == "video" then
			start_alpha = videobg.colorA.valueAt(timing)
		else
			start_alpha = bg_canvases[filename].alpha.valueAt(timing)
		end
		
		if timing == 0 and end_timing == 0 then
			-- Handle bgshow usage at 0ms by removing the default 0ms 0 alpha key and replacing it
			bg_alpha_channels[filename].removeKeyAtTiming(0)
			bg_alpha_channels[filename].addKey(0,alpha,easing)
		else
			-- Add two keys to the alpha channel associated with the BG
			-- The first key uses the start alpha value and is used to make sure the alpha value of the bg doesn't change
			-- between multiple usages of bgshow on the same BG
			-- The second key is the one that actually changes the BG's alpha to the specified value
			bg_alpha_channels[filename]
			.addKey(timing, start_alpha, easing)
			.addKey(end_timing, alpha, easing)
		end
	end
end

function bg_set_layer(timing, filename, layer, layer_group)
	if filename ~= nil and filename ~= '' and type(filename) == "string" then
		-- Set the layer of the canvas of the specified BG to the provided layer
		bg_layer_channels[filename].addKey(timing, layer)
		
		if type(layer_group) == "string" and (string.lower(layer_group) == "foreground" or string.lower(layer_group) == "background") then
			if timing == 0 then
				-- Handle 0ms bgsetlayer commands by removing the default 0ms background key
				bg_layer_group_channels[filename].removeKeyAtTiming(0)
			end
			
			if string.lower(layer_group) == "foreground" then
				bg_layer_group_channels[filename].addKey(timing, "Foreground")
			else
				bg_layer_group_channels[filename].addKey(timing, "Background")
			end
		end
	end
end

addScenecontrol("bgcreate", {"filename"}, function(cmd)
	local timing = cmd.timing
	local filename = cmd.args[1]
	
	-- You MUST include the file extension
	create_bg(filename)
end)

addScenecontrol("bgshow", {"end_timing","filename","alpha","easing"}, function(cmd)
	local timing = cmd.timing
	local end_timing = cmd.args[1]
	local filename = cmd.args[2]
	local alpha = cmd.args[3]
	local easing = cmd.args[4]
	
	-- Use "base" as filename to change default background
	bg_change_opacity(timing, end_timing, filename, alpha, easing)
end)

addScenecontrol("bgsetlayer", {"filename","layer","layer_group"}, function(cmd)
	local timing = cmd.timing
	local filename = cmd.args[1]
	local layer = cmd.args[2]
	local layer_group = cmd.args[3] -- Foreground or Background
	
	-- Won't work with the base BG
	bg_set_layer(timing, filename, layer, layer_group)
end)
