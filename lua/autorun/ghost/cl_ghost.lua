if CLIENT then
    notifications = {}

    local tab = {
        ["$pp_colour_addr"] = 0,
        ["$pp_colour_addg"] = 0,
        ["$pp_colour_addb"] = 0,
        ["$pp_colour_brightness"] = 0,
        ["$pp_colour_contrast"] = 1.2,
        ["$pp_colour_colour"] = 0.6,
        ["$pp_colour_mulr"] = 0,
        ["$pp_colour_mulg"] = 0,
        ["$pp_colour_mulb"] = 0
    }

    hook.Add("RenderScreenspaceEffects", "HandleCustomGhostScreenEffects", function()
        if LocalPlayer():IsGhost() then
            DrawColorModify(tab)
        end
    end)

    hook.Add("HUDPaint", "HandleNotifications", function()
        if LocalPlayer():IsGhost() and #notifications > 0 then
            local w = 96
            local x = ScrW() / 2
    
            for k, v in pairs(notifications) do
                if v.frame < 0 then
                    table.remove(notifications, k)
                else
                    v.frame = v.frame - FrameTime()
                end
    
                surface.SetFont("Default")
                local w, h = surface.GetTextSize(v.text)
                w = w + 16 + 32
    
                v.y = v.y or ScrH()
                v.y = Lerp(FrameTime() * 2, v.y, ScrH() - 64 - k * 32 + 32)
                k = k - 1
                
                surface.SetDrawColor(255, 255, 255, 150 * ((v.frame or 0) / 3))
                surface.DrawRect(x - w / 2, v.y, w, 24)
    
                draw.SimpleText(v.text, "Default", x, v.y + 4, Color(75, 75, 75, 255 * ((v.frame or 0) / 3)), TEXT_ALIGN_CENTER)
    
                surface.SetDrawColor(255, 255, 255, 255 * ((v.frame or 0) / 3))
            end
        end
    end)
end