x_channels = {}
y_channels = {}
z_channels = {}

function move_group(timing, end_timing, timing_group, x, y, z, easing)
	if x ~= 0 then
		if x_channels[timing_group] ~= nil then
			x_channels[timing_group].addKey(timing, x_channels[timing_group].valueAt(timing-1)).addKey(end_timing, x, easing)
		else 
			x_channels[timing_group] = Channel.keyframe().setDefaultEasing('l').addKey(0,0).addKey(timing, 0, easing).addKey(end_timing, x, easing)
			Scene.getNoteGroup(timing_group).translationX = x_channels[timing_group]
		end
	end
	
	if y ~= 0 then
		if y_channels[timing_group] ~= nil then
			y_channels[timing_group].addKey(timing, y_channels[timing_group].valueAt(timing-1)).addKey(end_timing, y, easing)
		else 
			y_channels[timing_group] = Channel.keyframe().setDefaultEasing('l').addKey(0,0).addKey(timing, 0, easing).addKey(end_timing, y, easing)
			Scene.getNoteGroup(timing_group).translationY = y_channels[timing_group]
		end
	end
	
	if z ~= 0 then
		if z_channels[timing_group] ~= nil then
			z_channels[timing_group].addKey(timing, z_channels[timing_group].valueAt(timing-1)).addKey(end_timing, z, easing)
		else 
			z_channels[timing_group] = Channel.keyframe().setDefaultEasing('l').addKey(0,0).addKey(timing, 0, easing).addKey(end_timing, z, easing)
			Scene.getNoteGroup(timing_group).translationZ = z_channels[timing_group]
		end
	end
	
end

addScenecontrol("movenotegroup", {"end_timing","timing_group","x","y","z","easing"}, function(cmd)
	local timing = cmd.timing
	local end_timing = cmd.args[1]
	local timing_group = cmd.args[2]
	local x = cmd.args[3]
	local y = cmd.args[4]
	local z = cmd.args[5]
	local easing = cmd.args[6]
	
	move_group(timing, end_timing, timing_group, x, y, z, easing)
end)