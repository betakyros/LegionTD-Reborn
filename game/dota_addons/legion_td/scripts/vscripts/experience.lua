ExperienceTracker = {}

function ExperienceTracker:init()
    ListenToGameEvent("entity_killed", Dynamic_Wrap(ExperienceTracker, "OnUnitKilled"), self)
end

function ExperienceTracker:OnUnitKilled(entry)
    local killed = EntIndexToHScript(entry.entindex_killed)
    local murderer = EntIndexToHScript(entry.entindex_attacker)
    local playerID = murderer:GetPlayerOwnerID()
    if playerID == -1 or killed == murderer then
        return
    end
    local player = Game:FindPlayerWithID(playerID)
    local experience = Game.UnitKV[killed:GetUnitName()].Legion_Experience or 0
    local fraction = Game.UnitKV[killed:GetUnitName()].Legion_Fraction or "other"
    player:AddExperience(experience)
    if (fraction == "humans") then
        print(killed:GetUnitName())
        print(murderer:GetUnitName())
    end
    player:KilledUnit(killed)
end

ExperienceTracker:init()
