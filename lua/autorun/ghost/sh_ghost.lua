AddCSLuaFile()

local ply = FindMetaTable("Player")

function ply:IsGhost()
	return self:GetNWBool("IsGhost", false)
end

hook.Add("KeyPress", "HandlePositionRequest", function(ply, key)
	if IsFirstTimePredicted() then
		if key == IN_ATTACK and ply:IsGhost() then
			if CLIENT then
				table.insert(notifications, { text = "Salvo", frame = 3 })
			else
				ply:SetNWVector("Ghost_Spawnpoint_Position",ply:GetPos())
				ply:SetNWAngle("Ghost_Spawnpoint_Angle",ply:EyeAngles())
			end
		elseif key == IN_ATTACK2 and ply:IsGhost() then
			local position = ply:GetNWVector("Ghost_Spawnpoint_Position")

			if position ~= Vector(0, 0, 0) then
				local angle = ply:GetNWAngle("Ghost_Spawnpoint_Angle")

				if angle ~= Vector(0, 0, 0) then
					if CLIENT then
						table.insert(notifications, { text = "Respawnado", frame = 3 })
					else
						ply:SetPos(position)
						ply:SetEyeAngles(angle)
					end
				end
			end
		end
	end
end)