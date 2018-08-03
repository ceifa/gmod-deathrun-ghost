AddCSLuaFile()
AddCSLuaFile("ghost/cl_ghost.lua")
AddCSLuaFile("ghost/sh_ghost.lua")
AddCSLuaFile("ghost/sh_preventhooks.lua")

if CLIENT then
    include( "ghost/cl_ghost.lua" )    
else
    include( "ghost/sv_ghost.lua" )
end

include( "ghost/sh_ghost.lua" )
include( "ghost/sh_preventhooks.lua" )