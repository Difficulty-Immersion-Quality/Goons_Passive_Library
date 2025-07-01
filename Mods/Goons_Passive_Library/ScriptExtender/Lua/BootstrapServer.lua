Ext.Osiris.RegisterListener("LevelGameplayStarted", 2, "after", function(level_name, is_editor_mode)
    for i, v in ipairs(Ext.Entity.GetAllEntitiesWithComponent("ServerCharacter")) do
        Ext.Timer.WaitFor(100, function()
            local charID = v.Uuid and v.Uuid.EntityUuid or v  -- Ensure we get the EntityUuid if available
            if type(charID) == "string" then
                Osi.AddPassive(charID, "Goon_Psuedo_Status_Groups_Master_Passive")
            else
                print("Invalid character ID for AddPassive:", charID)
            end
        end)
    end
end)