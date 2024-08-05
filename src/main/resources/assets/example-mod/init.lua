print("Init From Lua")

local EventBus = require "assets.puzzle-loader-lua.lua.bindings.PuzzleEventBus"
local BlockUtil = require "assets.puzzle-loader-lua.lua.bindings.BlockUtil"

local MOD_ID = "example-mod"

EventBus:registerEvent(function (event)
    print("Lua: Registering Blocks")
    event:registerBlock((function ()
            local resourceLocation = BlockUtil:makeLocation(MOD_ID, "blocks/diamond_block.json");
            return BlockUtil:newBlockFromLocation("diamond_block", resourceLocation);
    end)())
end, "com.github.puzzle.game.events.OnRegisterBlockEvent")

EventBus:registerEvent(function (event)
    print("Lua: Registering Language Files")
    event:registerLanguage(BlockUtil:makeLocation(MOD_ID, "languages/en-US.json"))
end, "com.github.puzzle.game.events.OnRegisterLanguageEvent")