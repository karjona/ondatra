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
#include src/scenes/won.lua

-- utilities
#include src/utilities/say.lua
#include src/utilities/log.lua
#include src/utilities/rspr.lua
#include src/utilities/bg.lua
#include src/utilities/moves.lua
#include src/utilities/rectfillout.lua
#include src/utilities/shots.lua
#include src/utilities/menus.lua
#include src/utilities/buttons.lua

-- entities
#include src/entities/ship.lua
#include src/entities/enemy.lua
#include src/entities/bullet.lua

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
00066000000110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000555dd6007766667707666670000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0016610000651ddd0061160000611600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
60077006ddd15600776dd677076dd670000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
607cc70600651ddd0061160000611600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
67cccc76ddd156007766667707666670000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6cc55cc6006dd5550007700000077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
65511556000660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77000000007ee70000077000000000007700000007770000007ee70000000000007ee70077777777077777700077770000000000000000000000000000000000
70000000007ee700007ee700000000007870000007ee7000007ee70000000000007ee70078888887078888700078870000000000000000000000000000000000
00000000007ee700007ee700007777777887000077ee7770007ee77777777700777ee70007888870007887000078870000000000000000000000000000000000
00000000007ee700077ee770007eeeee78700000eeeeeee7007eeeeeeeeee700eeeee70000788700007887000007700000000000000000000000000000000000
00000000007ee7007eeeeee7007eeeee77000000eeeeeee7007eeeeeeeeee700eeeee70000077000000770000007700000000000000000000000000000000000
00000000007ee7007eeeeee7007ee7770000000077ee777000777777777ee7007777770000000000000000000000000000000000000000000000000000000000
00000000007ee700777ee777007ee7000000000007ee700000000000007ee7000000000000000000000000000000000000000000000000000000000000000000
00000000007ee700007ee700007ee700000000000777000000000000007ee7000000000000000000000000000000000000000000000000000000000000000000
__map__
4000520051000000005355000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5700000053550000005655000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5655000058000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100000000000000000002b0502c0502c0502c0502c0502c0502c0502b0502a0502805027050230501e0501505014050140501405016050180501a0501d0502205027050290500000000000000000000000000
