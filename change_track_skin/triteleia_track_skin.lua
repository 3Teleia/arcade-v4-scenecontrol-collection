tracks = {}
track_alpha_channels = {}
track_layer_channels = {}
top_layer = Scene.track.sort.valueAt(0) + 1 -- Allow placement of newly skinned tracks above the default one
current_skin = StringChannel.create().addKey(0,"base") -- Saves names of when which track skins were used

function change_track_skin(timing, end_timing, skin, easing)
	if skin ~= nil and skin ~= '' and type(skin) == "string" then
		skin = string.lower(skin) -- Ensure case insensitivity
		
		if tracks[skin] ~= nil then -- If track with desired skin already exists,
			track_alpha_channels[skin].addKey(timing-1,track_alpha_channels[skin].valueAt(timing)) -- Ensure alpha value doesn't change until it's necessary here, probably staying at 0
									  .addKey(timing,0,easing)       									   -- Start track alpha at 0
									  .addKey(end_timing,255,easing) 							   -- Fade the track into existence again
									  
			track_layer_channels[current_skin.valueAt(timing)].addKey(end_timing,top_layer-2) -- Put last used skin track below the new track when the new track is FINISHED fading in
			
			track_layer_channels[skin].addKey(timing,top_layer+1)    -- Put new track on the very top
									  .addKey(end_timing, top_layer) -- Put new track 1 layer below the topmost layer so that other tracks can go above it later

			current_skin.addKey(end_timing,skin) -- Save the fact that this was the newest used track in the skin timeline
			
		else 									  -- If track with desired skin does not exist,
			tracks[skin] = Scene.track.copy(true) -- Create a copy of the main track
			tracks[skin].setTrackSprite(skin)     -- Change its skin to the specified skin
			
			track_alpha_channels[skin] = Channel.named(skin).keyframe().setDefaultEasing('l')	-- Create an exclusive alpha channel for the new track
															.addKey(0,0)						-- Make track start fully transparent
															.addKey(timing,0,easing)					-- Ensure track stays transparent until it's go time
															.addKey(end_timing,255,easing)  	-- Fade new track into existence								
			tracks[skin].colorA = track_alpha_channels[skin] -- Make the new track use the above channel for its alpha values
			
			if current_skin.valueAt(timing) ~= "base" then 										-- If this isn't the first skin change,
			track_layer_channels[current_skin.valueAt(timing)].addKey(end_timing,top_layer-2)	-- Put last used skin track below the new track when the new track is FINISHED fading in
			end
			
			track_layer_channels[skin] = Channel.named(skin).keyframe().setDefaultEasing('inconst')   -- Create a channel that determines the layer of the new track
																	   .addKey(0,top_layer-2)         -- Place it below the main track
																	   .addKey(timing, top_layer+1)   -- Put new track on the top when it starts fading in
																	   .addKey(end_timing, top_layer) -- Put new track 1 layer below the topmost layer
			tracks[skin].sort = track_layer_channels[skin] -- Make the new track use the above channel for its layering
			
			if current_skin.valueAt(timing) == "base" then -- If this is the first skin change after the chart has started,
				current_skin.addKey(timing-1,"base")       -- Mark the end of the usage of the main track
			end
			current_skin.addKey(end_timing,skin) -- Save the fact that this was the newest used track in the skin timeline
		end
	end
end

addScenecontrol("changetrackskin", {"end_timing","skin","easing"}, function(cmd)
	local timing = cmd.timing
	local end_timing = cmd.args[1]
	local skin = cmd.args[2] -- Case insensitive, name of the desired track skin within the Skin window
	local easing = cmd.args[3]
	
	change_track_skin(timing, end_timing, skin, easing)
end)
