local gfx = {}

local component = require("component")
local gpu = component.gpu

function gfx.new()
	local draw = {}
		
		
		function draw.setColor(...)
			return gpu.setBackground(...)
		end
		
		function draw.getColor(...)
			return gpu.getBackground(...)
		end
		
		function draw.pixel(x,y)
			gpu.set(x, y, " ")
		end
		
		
		function draw.rectangle(x1,y1,x2,y2)
			if x1 > x2 then
				x1, x2 = x2, x1
			end
			
			if y1 > y2 then
				y1, y2 = y2, y1
			end
			
			for _x = x1, x2 do
				for _y = y1, y2 do
					draw.pixel(_x, _y)
				end
			end
		end
		
		
		
	return draw
end

return gfx

