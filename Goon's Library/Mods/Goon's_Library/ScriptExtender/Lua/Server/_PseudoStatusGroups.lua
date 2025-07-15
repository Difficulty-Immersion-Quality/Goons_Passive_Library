    local BleedingCondition = {
    "BLEEDING",
    "BARBED_ARROW",
    "HEAVY_BLEEDING"
    }

    local BurningCondition = {
    "BURNING",
    "BURNING_AZER",
    "BURNING_HOLY",
    "BURNING_HELLFIRE",
    "BURNING_LAVA",
    "BURNING_TRAPWALL",
    "FLAMING_SPHERE_AURA",
    "FLAMING_SPHERE_AURA_3",
    "FLAMING_SPHERE_AURA_4",
    "FLAMING_SPHERE_AURA_5",
    "FLAMING_SPHERE_AURA_6",
    "FLAMING_SPHERE_AURA_7",
    "FLAMING_SPHERE_AURA_8",
    "FLAMING_SPHERE_AURA_9",
    "FLAMING_SPHERE",
    "FLAMING_SPHERE_3",
    "FLAMING_SPHERE_4",
    "FLAMING_SPHERE_5",
    "FLAMING_SPHERE_6",
    "FLAMING_SPHERE_7",
    "FLAMING_SPHERE_8",
    "FLAMING_SPHERE_9",
    "HAV_MAG_INFERNAL_FIRE",
    "LOW_HOH_BOAR_BURNING_DAMAGE",
    "MAG_FIRE_HEAT",
    "MAG_INFERNAL_BURNING",
    "ORI_KARLACH_ENRAGE",
    "ORI_KARLACH_INFERNAL_FURY",
    "SEARING_SMITE",
    "WILD_MAGIC_BURNING"
    }

    local DeafenedCondition = {
    "DEAFENED"
    }

    local SilencedCondition = {
    "SILENCED",
    "SHA_SILENTLIBRARY_LIBRARIANSILENCE_STATUS",
    "LOW_VoicelessPenitent_Silenced",
    "SILENCED_MOVEMENT",
    "GARROTE_SILENCED"
    }


local function HasAnyStatus(statusTable, charID)
    for _, status in ipairs(statusTable) do
        if Osi.HasActiveStatus(charID, status) == 1 then
            return true
        end
    end
    return false
end

local function HasBleedingCondition(charID)
    return HasAnyStatus(BleedingCondition, charID)
end

local function HasBurningCondition(charID)
    return HasAnyStatus(BurningCondition, charID)
end

local function HasDeafenedCondition(charID)
    return HasAnyStatus(DeafenedCondition, charID)
end

local function HasSilencedCondition(charID)
    return HasAnyStatus(SilencedCondition, charID)
end

local function RunPseudoStatusGroups(charID)
    -- Bleeding
    if HasBleedingCondition(charID) then
        if Osi.HasActiveStatus(charID, "SG_Bleeding") == 0 then
            Osi.ApplyStatus(charID, "SG_Bleeding", 100, 1, charID)
        end
    else
        if Osi.HasActiveStatus(charID, "SG_Bleeding") == 1 then
            Osi.RemoveStatus(charID, "SG_Bleeding")
        end
    end
    -- Burning
    if HasBurningCondition(charID) then
        if Osi.HasActiveStatus(charID, "SG_Burning") == 0 then
            Osi.ApplyStatus(charID, "SG_Burning", 100, 1, charID)
        end
    else
        if Osi.HasActiveStatus(charID, "SG_Burning") == 1 then
            Osi.RemoveStatus(charID, "SG_Burning")
        end
    end
    -- Deafened
    if HasDeafenedCondition(charID) then
        if Osi.HasActiveStatus(charID, "SG_Deafened") == 0 then
            Osi.ApplyStatus(charID, "SG_Deafened", 100, 1, charID)
        end
    else
        if Osi.HasActiveStatus(charID, "SG_Deafened") == 1 then
            Osi.RemoveStatus(charID, "SG_Deafened")
        end
    end
    -- Silenced
    if HasSilencedCondition(charID) then
        if Osi.HasActiveStatus(charID, "SG_Silenced") == 0 then
            Osi.ApplyStatus(charID, "SG_Silenced", 100, 1, charID)
        end
    else
        if Osi.HasActiveStatus(charID, "SG_Silenced") == 1 then
            Osi.RemoveStatus(charID, "SG_Silenced")
        end
    end
end

Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function(charID, status, causee, storyActionID)
    RunPseudoStatusGroups(charID)
end)

Ext.Osiris.RegisterListener("StatusRemoved", 4, "after", function(charID, status, causee, storyActionID)
    RunPseudoStatusGroups(charID)
end)