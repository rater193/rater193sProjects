local gfx = {}

local component = require("component")
local term = require("term")

local gpu = component.gpu



-- Function decToHex (renamed, updated): http://lua-users.org/lists/lua-l/2004-09/msg00054.html
local function decToHex(IN)
	local B,K,OUT,I,D=16,"0123456789ABCDEF","",0
	while IN>0 do
    	I=I+1
    	IN,D=math.floor(IN/B),math.fmod(IN,B)+1
    	OUT=string.sub(K,D,D)..OUT
	end
	return OUT
end

-- Function rgbToHex: http://gameon365.net/index.php

function gfx.new()
	local draw = {}
		function draw.colorHexToRGB(hex)
			hex = hex:gsub("#","")
			return tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6))
		end

		function draw.colorRGBToHex(r, g, b)
			local output = decToHex(r) .. decToHex(g) .. decToHex(b);
			return output
		end
		
		function draw.getSize()
			return gpu.getResolution()
		end
		
		function draw.getWidth()
			local w, h = draw.getSize()
			return w
		end
		
		function draw.getHeight()
			local w, h = draw.getSize()
			return h
		end
		
		function draw.getHeight()
			
		end
		
		function draw.setColor(...)
			gpu.setBackground(...)
			gpu.setForeground(...)
		end
		
		function draw.setColorRGB(r, g, b)
			return tonumber("0x"..draw.colorRGBToHex(r, g, b))
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
		
		function draw.text(x, y, text)
			term.setCursor(x, y)
			term.write(text)
		end
		
		
		
	return draw
end

return gfx

