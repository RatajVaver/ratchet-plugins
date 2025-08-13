-- some basic tests to play around with JSON
local data = JSON.load('data/test.json')
print(data)

if(not data)then
    data = JSON.parse('{"name": "test"}')
end

data.hello = "world"

-- saving will fail, but if we create "data" directory in our working path, it will succeed
-- alternatively we could also use absolute path
local success = JSON.save('data/test.json', data)
print(success)

-- we can even save complex data like character sheets, we just need to convert it into a table first!
function saveCharacterSheet(player)
    local sheet = RPR.GetSheet(player)
	local sheetData = {
		name = sheet.name,
		perks = sheet.perksAssigned,
		skills = {},
		stats = {},
	}

	for k,v in ipairs(sheet.skills)do
		sheetData.skills[v] = {
			sheet.skillsAllocated[k],
			sheet.skillsTotal[k]
		}
	end

	for k,v in ipairs(sheet.stats)do
		sheetData.stats[v] = {
			sheet.statsCurrent[k],
			sheet.statsMax[k]
		}
	end

    local saved = JSON.save("data/sheet.json", sheetData)
    if(saved)then
        TotChat.Notify(player, "Sheet saved!")
    else
        TotChat.Notify(player, "Failed to save sheet!")
    end
end
on("customSheetSave", saveCharacterSheet)