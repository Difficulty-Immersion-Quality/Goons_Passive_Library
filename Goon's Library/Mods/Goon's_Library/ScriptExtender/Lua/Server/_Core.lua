Ext.Osiris.RegisterListener("LevelGameplayStarted", 2, "after", function(level, _)
    local modVars = Ext.Vars.GetModVariables(ModuleUUID)
    local assigned = modVars.HasGoonLibraryPassives or {}
    modVars.HasGoonLibraryPassives = assigned

    local MasterPassives = {
        "Goon_DamageReroll_Throwing_Master_Passive",
        "Goon_Advantage_Throwing_Master_Passive",
        "Goon_IgnoreResistance_Throwing_Master_Passive"
    }

    local function ProcessMasterPassives(entityID)
        if type(entityID) ~= "string" then return end
        if type(assigned[entityID]) ~= "table" then
            assigned[entityID] = {}
        end
        for _, passive in ipairs(MasterPassives) do
            if not assigned[entityID][passive] then
                if Osi.HasPassive(entityID, passive) == 0 then
                    Osi.AddPassive(entityID, passive)
                    assigned[entityID][passive] = true
                    -- print(string.format("[DEBUG] Assigned %s to %s", passive, entityID))
                end
            end
        end
    end

    -- Unique players from DB_Players
    for _, row in ipairs(Osi.DB_Players:Get(nil) or {}) do
        ProcessMasterPassives(row[1])
    end

    -- All ServerCharacters (excluding already assigned)
    for _, entity in ipairs(Ext.Entity.GetAllEntitiesWithComponent("ServerCharacter") or {}) do
        local charID = entity.Uuid and entity.Uuid.EntityUuid or entity
        ProcessMasterPassives(charID)
    end
end)
