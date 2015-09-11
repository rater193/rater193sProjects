local githubBase = "https://raw.githubusercontent.com/rater193/rater193sProjects/master/Computercraft/gameapi/"
 
local function getData(dir)
  return http.get(githubBase..dir).readAll()
end


function download(dir)
	
end

print("DOWNLOADER:")