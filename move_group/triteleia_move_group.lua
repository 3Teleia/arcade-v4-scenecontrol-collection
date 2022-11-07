local x_channels = {}
local y_channels = {}
local z_channels = {}

function move_group(timing, end_timing, tg, x, y, z, easing)
	local movable_tg = Scene.getNoteGroup(tg)
	
	if x_channels[tg] == nil then
			x_channels[tg] = Channel.keyframe().setDefaultEasing('l')
			.addKey(0,0)
			.addKey(timing, movable_tg.translationX.valueAt(timing), easing)
			.addKey(end_timing, x, easing)
			
			movable_tg.translationX = x_channels[tg]
	end
	
	if y_channels[tg] == nil then
			y_channels[tg] = Channel.keyframe().setDefaultEasing('l')
			.addKey(0,0)
			.addKey(timing, movable_tg.translationY.valueAt(timing), easing)
			.addKey(end_timing, y, easing)
			
			movable_tg.translationY = y_channels[tg]
	end
	
	if z_channels[tg] == nil then
			z_channels[tg] = Channel.keyframe().setDefaultEasing('l')
			.addKey(0,0)
			.addKey(timing, movable_tg.translationZ.valueAt(timing), easing)
			.addKey(end_timing, z, easing)
			
			movable_tg.translationZ = z_channels[tg]
	end
	
	if x_channels[tg].valueAt(timing) ~= x then
		x_channels[tg]
		.addKey(timing, x_channels[tg].valueAt(timing))
		.addKey(end_timing, x, easing)
	end
	
	if y_channels[tg].valueAt(timing) ~= y then
		y_channels[tg]
		.addKey(timing, y_channels[tg].valueAt(timing))
		.addKey(end_timing, y, easing)
	end
	
	if z_channels[tg].valueAt(timing) ~= z then
		z_channels[tg]
		.addKey(timing, z_channels[tg].valueAt(timing))
		.addKey(end_timing, z, easing)
	end
	
end

addScenecontrol("movenotegroup", {"end_timing","timing_group","x","y","z","easing"}, function(cmd)
	local timing = cmd.timing
	local end_timing = cmd.args[1]
	local tg = cmd.args[2]
	local x = cmd.args[3]
	local y = cmd.args[4]
	local z = cmd.args[5]
	local easing = cmd.args[6]
	
	move_group(timing, end_timing, tg, x, y, z, easing)
end)
