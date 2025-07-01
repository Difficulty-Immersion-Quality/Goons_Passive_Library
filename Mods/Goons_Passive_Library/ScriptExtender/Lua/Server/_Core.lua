Ext.Osiris.RegisterListener("LevelGameplayStarted", 2, "after", function(level, _)
    local modVars = Ext.Vars.GetModVariables(ModuleUUID)
    local assigned = modVars.HasGoonLibraryPassives or {}
    modVars.HasGoonLibraryPassives = assigned

    -- print("[DEBUG] Checking DB_Players for passive assignment")

    -- Unique players from DB_Players
    for i, row in ipairs(Osi.DB_Players:Get(nil) or {}) do
        local charID = row[1]
        if type(charID) == "string" then
            if not assigned[charID] then
                -- print(string.format("[DEBUG] Assigning passive to player %s", charID))
                Osi.AddPassive(charID, "Goon_Psuedo_Status_Groups_Master_Passive")
                assigned[charID] = true
            else
                -- print(string.format("[DEBUG] Skipping already assigned player %s", charID))
            end
        else
            -- print("[DEBUG] Invalid character ID in DB_Players row", i)
        end
    end

    -- All ServerCharacters (excluding already assigned)
    for _, entity in ipairs(Ext.Entity.GetAllEntitiesWithComponent("ServerCharacter") or {}) do
        local charID = entity.Uuid and entity.Uuid.EntityUuid or entity
        if type(charID) == "string" then
            if not assigned[charID] then
                -- print(string.format("[DEBUG] Assigning passive to ServerCharacter %s", charID))
                Osi.AddPassive(charID, "Goon_Psuedo_Status_Groups_Master_Passive")
                assigned[charID] = true
            else
                -- print(string.format("[DEBUG] Skipping already assigned ServerCharacter %s", charID))
            end
        else
            -- print("[DEBUG] Invalid ServerCharacter ID:", charID)
        end
    end

    -- All ServerItems (excluding already assigned)
    for _, entity in ipairs(Ext.Entity.GetAllEntitiesWithComponent("ServerItem") or {}) do
        local itemID = entity.Uuid and entity.Uuid.EntityUuid or entity
        if type(itemID) == "string" then
            if not assigned[itemID] then
                -- print(string.format("[DEBUG] Assigning passive to ServerItem %s", itemID))
                Osi.AddPassive(itemID, "Goon_Psuedo_Status_Groups_Master_Passive")
                assigned[itemID] = true
            else
                -- print(string.format("[DEBUG] Skipping already assigned ServerItem %s", itemID))
            end
        else
            -- print("[DEBUG] Invalid ServerItem ID:", itemID)
        end
    end
end)