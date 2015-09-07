
settings = {}
settings.term = require("term")
settings.component = require("component")
settings.gpu = settings.component.gpu

for i, v in pairs(settings.component.gpu) do print(i, v) end