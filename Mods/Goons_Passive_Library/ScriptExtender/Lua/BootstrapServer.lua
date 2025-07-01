Ext.Osiris.RegisterListener("LevelGameplayStarted", 2, "after", function(levelName, isEditorMode)
    -- All ServerCharacters (NPCs and possibly some players)
    for _, v in ipairs(Ext.Entity.GetAllEntitiesWithComponent("ServerCharacter") or {}) do
        Ext.Timer.WaitFor(100, function()
            local charID = v.Uuid and v.Uuid.EntityUuid or v
            if type(charID) == "string" then
                Osi.AddPassive(charID, "Goon_Psuedo_Status_Groups_Master_Passive")
            else
                print("Invalid ServerCharacter ID:", charID)
            end
        end)
    end
    -- All players from DB_Players
    local party = Osi.DB_Players:Get(nil) or {}
    for _, p in pairs(party) do
        local playerID = p[1]
        Ext.Timer.WaitFor(100, function()
            if type(playerID) == "string" then
                Osi.AddPassive(playerID, "Goon_Psuedo_Status_Groups_Master_Passive")
            else
                print("Invalid Player ID:", playerID)
            end
        end)
    end
    -- All ServerItems
    for _, v in ipairs(Ext.Entity.GetAllEntitiesWithComponent("ServerItem") or {}) do
        Ext.Timer.WaitFor(100, function()
            local itemID = v.Uuid and v.Uuid.EntityUuid or v
            if type(itemID) == "string" then
                Osi.AddPassive(itemID, "Goon_Psuedo_Status_Groups_Master_Passive")
            else
                print("Invalid ServerItem ID:", itemID)
            end
        end)
    end
end)