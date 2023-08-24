---Generates an enum from a list of valid values
---@param list string[] List of valid values
---@param docstring string Docstring to add to the enum
---@return string
local function generate_enum(list, docstring)
    for _, v in ipairs(list) do
        docstring = docstring .. string.format("---| %q\n", v)
    end
    return docstring
end

local header = [[
---@meta
-- Generated automatically with `generate_enums.lua`
]]

local spawnables = [[
---Default asset names. Only these names can be used with `tm.physics.SpawnObject()`
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218267747/Spawnables)
---@alias Spawnable
]]

local audio_names = [[
---Audio names that can be played
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/219185167/Audio#List-of-Audio-Event-names)
---@alias AudioName
]]

tm.os.Log(
    string.format(
        "\n%s\n%s\n%s",
        header,
        generate_enum(tm.physics.SpawnableNames(), spawnables),
        generate_enum(tm.audio.GetAudioNames(), audio_names)
    )
)
