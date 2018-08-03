-- all hooks to prevent some ghost actions

-- server side hooks
if SERVER then

	hook.Add("PlayerSpray", "DisableGhostSpray", function( ply )
		return ply:IsGhost()
	end )

	hook.Add("PlayerCanPickupWeapon", "DisableGhostPickupWeapons", function( ply, ent )
		return not ply:IsGhost()
	end)

	hook.Add("AcceptInput", "FixGhostTeleport", function( ent, input, activator, caller, value )
		return activator:IsPlayer() and activator:IsGhost()
	end)

	hook.Add("PlayerUse", "DisableGhostPicking", function( ply )
		return not ply:IsGhost()
	end)

	hook.Add("PlayerSwitchFlashlight", "PlayerSwitchFlashlight", function( ply, turningOn )
		return not ply:IsGhost()
	end)

	hook.Add("PlayerShouldTakeDamage", "RemoveGhostDamage", function( target, dmg )
		return target:IsPlayer() and not target:IsGhost()
	end)

	hook.Add("GetFallDamage", "RemoveFallDamageSound", function( ply, speed )
		return not (ply:IsPlayer() and ply:IsGhost())
	end)
end

-- client side hooks
if CLIENT then

	hook.Add("PrePlayerDraw", "DrawGhosts", function( ply )
		return ply:IsGhost() and not LocalPlayer():IsGhost()
	end)
end

-- shared hooks

hook.Add("PlayerFootstep", "RemoveGhostFootstep", function( ply )
	return ply:IsGhost()
end)

hook.Add("OnEntityCreated", "SetCustomCollisionToAllPlayers", function( ent )
	if IsValid(ent) and ent:IsPlayer() then ent:SetCustomCollisionCheck(true) end
end)

hook.Add("ShouldCollide", "RemoveGhostCollision", function( ent1, ent2 )
	return not (ent1:IsPlayer() and ent2:IsPlayer() and (ent1:IsGhost() or ent2:IsGhost()))
end)

hook.Add("EntityEmitSound", "DisableGhostSound", function( t )
	if t.Entity:IsPlayer() and t.Entity:IsGhost() then
		if CLIENT then
			-- dont return true, it will be apply changes to data table
			if t.Entity ~= LocalPlayer() then
				return false
			end
		else
			return false
		end
	end
end )