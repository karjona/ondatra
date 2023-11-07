pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
-- battle for ondatra
-- a game for game off 2023

-- by kilian arjona
-- and valeria sivkova


#include src/main.lua

-- scenes
#include src/scenes/logo.lua
#include src/scenes/battle.lua

-- utilities
#include src/utilities/say.lua
#include src/utilities/cards.lua
#include src/utilities/log.lua
#include src/utilities/rspr.lua
#include src/utilities/bg.lua
#include src/utilities/moves.lua

-- entities
#include src/entities/ship.lua

-- levels
#include src/levels/1.lua
__gfx__
00000000000a0aa999aa000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000aaaaa99999aa0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007000aaafffffffffa0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000a9ffaaffffaafaa900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700009ff55ffff55fff900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700faff55ffff55ffaa00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000aafffff5fffffaaf00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000fffffff5ffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000fffffff5ffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000fffffff555ffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000ffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000ff55ffffff55ff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000ffff555555ffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000ffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000ffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000ffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00066000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00166100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
60077006000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
607cc706000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
67cccc76000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6cc55cc6000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
65511556000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77000000007ee7000007700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
70000000007ee700007ee70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000007ee700007ee70000777777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000007ee700077ee770007eeeee000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000007ee7007eeeeee7007eeeee000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000007ee7007eeeeee7007ee777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000007ee700777ee777007ee700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000007ee700007ee700007ee700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
4000520000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100000000000000000002b0502c0502c0502c0502c0502c0502c0502b0502a0502805027050230501e0501505014050140501405016050180501a0501d0502205027050290500000000000000000000000000
