print("Init From Lua")

local BlockUtil = require "assets.puzzle-loader-lua.lua.bindings.BlockUtil"
local CommandUtil = require "assets.puzzle-loader-lua.lua.bindings.CommandUtil"
local CosmicReach = require "assets.puzzle-loader-lua.lua.bindings.CosmicReach"

local dispatcher = CommandUtil:getCommandDispatcher()
local literal = CommandUtil:makeLiteral("setBlock")

local argX = CommandUtil:makeIntArgument("x")
local argY = CommandUtil:makeIntArgument("y")
local argZ = CommandUtil:makeIntArgument("z")
local blockId = CommandUtil:makeGreedyStringArgument("id")

blockId:executes(CommandUtil:closureToCommand(
function (context)
            local x = CommandUtil:getIntArgument(context, "x")
            local y = CommandUtil:getIntArgument(context, "y")
            local z = CommandUtil:getIntArgument(context, "z")
            local id = CommandUtil:getStringArgument(context, "id")

            local world = CosmicReach:getWorld()

            BlockUtil:setBlockState(
                    world:getDefaultZone(),
                    BlockUtil:getBlockState(id),
                    x,
                    y,
                    z
            )
            return 0
        end
))

CommandUtil:_thenL(argZ, blockId)
CommandUtil:_thenL(argY, argZ)
CommandUtil:_thenL(argX, argY)
CommandUtil:_thenL(literal, argX)

dispatcher:register(literal)

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