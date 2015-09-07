local ui = require("userinterface")
local term = require("term")
local gpu = require("component").gpu

local draw = ui.new()

local oldcolor = draw.getColor()

local fg, bg = gpu.getForeground(), gpu.getBackground()

term.clear()

draw.setColor(0xffffff)

local w, h = draw.getSize()

local _y = math.floor(h/2)

for _place = 0,10 do
draw.rectangle(0,_y-1,math.ceil((_place/10)*w),_y-1)
draw.rectangle(0,_y+1,math.ceil((_place/10)*w),_y+1)
os.sleep(1/30)
end

draw.setColor(oldcolor)
gpu.setForeground(0x8888ff)
draw.text(4,_y,"Password: ")

local pass = io.read()

draw.text(8, _y+2, "Password protection coming soon!")

gpu.setForeground(fg)
gpu.setBackground(bg)


os.sleep(2)

term.clear()
_G._OSVERSION = "RatOS 0.1"
print(_G._OSVERSION.." Command line")