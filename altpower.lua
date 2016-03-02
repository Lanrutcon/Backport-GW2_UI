ComboFrame:Hide(); -- hiding default combo points
ComboFrame:ClearAllPoints();
--MISSING FUNCTIONS--


function GetSpecialization()
    return GetPrimaryTalentTree();
end

function GetSpecializationInfo(index)
    return GetTalentTabInfo(index);
end

-----------------------


local spe = CreateFrame("frame",'spe',UIParent)
local prevSpec = nil
local prevStance = nil

local altPowerHolder = CreateFrame("frame",'altPowerHolder',UIParent)
altPowerHolder:SetFrameStrata("BACKGROUND")
altPowerHolder:SetWidth(325)
altPowerHolder:SetHeight(15)
altPowerHolder:Show()
altPowerHolder:ClearAllPoints();
--CHANGES:Lanrutcon:altPowerHolder's anchor is MainMenuBar
altPowerHolder:SetPoint('TOPLEFT', MainMenuBar, 'TOPLEFT', 10, 0);

local altPowerHolderS = CreateFrame("frame",'altPowerHolderS',UIParent)
altPowerHolderS:SetFrameStrata("BACKGROUND")
altPowerHolderS:SetWidth(325)
altPowerHolderS:SetHeight(15)
altPowerHolderS:Show()
altPowerHolderS:ClearAllPoints();
altPowerHolderS:SetPoint('TOPLEFT', MainMenuBar, 'TOPLEFT', 10, 0);



function setAltPower(event,unit)
    local playerClassName = UnitClass('player')
    local currentSpec  = GetSpecialization();
    local stance = GetShapeshiftFormID()
    if stance==nil then
        stance = 0
    end
    if playerClassName=="Druid" and event == 'UPDATE_SHAPESHIFT_FORM' and stance~=nil then
        if prevStance==31 then
            unSetAltPowerMoonkin()
		elseif prevStance == 1 then
            unSetAltPowerRogue()
        end
        prevStance = stance
    end

	
    --PALADIN
    if playerClassName=="Paladin" then
        setAltPowerPaladin()
    
	
    -- Rogue
    elseif playerClassName=="Rogue" then
        setAltPowerRogue()
    

    --PRIEST
    elseif playerClassName=="Priest" then
		if (currentSpec==1 or currentSpec == 2) and prevSpec == 3 then
			unSetAltPowerPriestShadow()
			setAltPowerPriestDiscipline()
		elseif (currentSpec==1 or currentSpec == 2) and prevSpec == nil then
			setAltPowerPriestDiscipline()
		elseif currentSpec==3 and prevSpec == nil then
			setAltPowerPriestShadow()
		elseif currentSpec==3 and (prevSpec == 1 or prevSpec == 2) then
			unSetAltPowerPriestDiscipline()
			setAltPowerPriestShadow()
		end


    -- DEATH KNIGHT
    elseif playerClassName=="Death Knight" then
        setAltPowerDeathKnight()
    

    -- WARLOCK
    elseif playerClassName=="Warlock" then
        setAltPowerWarlock()
    

    -- DRUID
    elseif playerClassName=="Druid" then
        if stance==1 then
            setAltPowerRogue()
		elseif stance == 31 then
            setAltPowerMoonkin()
        end
    end

    prevSpec = currentSpec
end

function setAltPowerDeathKnight()
    RuneFrame:Hide();
    for i = 1,6 do

        _G["rune" .. i .. "BG"], _G["rune" .. i .. "BGt"] = createBackgroundName('BOTTOM',15,15,0,0,"Interface\\AddOns\\GW2_UI\\textures\\altpowerbg",1,"rune" .. i .. "BG")
        _G["rune" .. i .. "BG"]:ClearAllPoints();
        _G["rune" .. i .. "BG"]:SetParent(altPowerHolder);
        _G["rune" .. i .. "BGt"]:SetVertexColor(0,0,0,1);
        _G["rune" .. i .. "BG"]:SetPoint('LEFT', altPowerHolder, 'LEFT', 40*(i-1), 0);


        _G["runeFill" .. i .. "BG"], _G["runeFill" .. i .. "BGt"] = createBackgroundName('BOTTOM',15,15,0,0,"Interface\\AddOns\\GW2_UI\\textures\\altpowerfill",1,"runeFill" .. i .. "BG")
        _G["runeFill" .. i .. "BG"]:ClearAllPoints();
        _G["runeFill" .. i .. "BG"]:SetParent(altPowerHolder);
        -- _G["runeFill" .. i .. "BGt"]:SetVertexColor(0,0,0,1);
        _G["runeFill" .. i .. "BG"]:SetPoint('LEFT', altPowerHolder, 'LEFT', 40*(i-1), 0);

    end
    altPowerHolder:SetScript("OnEvent", function(self, event, unit)
        if event=='ACTIVE_TALENT_GROUP_CHANGED' then
            if unit ~= 'player' then
                return
            end
        end
        for i = 1,6 do
            local rune_type = GetRuneType(i)
            local rune_start, rune_duration, rune_ready = GetRuneCooldown(i)

            if rune_type == 1 then
                _G["runeFill" .. i .. "BGt"]:SetVertexColor(1,0.2,0.2,1);
            end
            if rune_type == 2 then
                _G["runeFill" .. i .. "BGt"]:SetVertexColor(0.2,1,0.2,1);
            end
            if rune_type == 3 then
                _G["runeFill" .. i .. "BGt"]:SetVertexColor(0.2,0.2,1,1);
            end
            if rune_type == 4 then
                _G["runeFill" .. i .. "BGt"]:SetVertexColor(0.5,0.2,0.5,1);
            end
            if rune_ready == false then
                _G["runeFill" .. i .. "BGt"]:SetVertexColor(0,0,0,1);
            end

        end

    end)
    altPowerHolder:RegisterEvent("RUNE_POWER_UPDATE");
    altPowerHolder:RegisterEvent("PLAYER_ENTERING_WORLD");
    altPowerHolder:RegisterEvent("UNIT_POWER");
end


spe:HookScript("OnEvent", function(self, event, unit)
	altPowerHolder:UnregisterAllEvents()
    altPowerHolder:SetScript("OnEvent", nil)
    altPowerHolder:SetScript("OnUpdate", nil)
    spe.total = 0;
	    spe:SetScript("OnUpdate", function(self,elapsed)
		spe.total = spe.total + elapsed;
        if (spe.total > 0.05) then
            setAltPower(event,unit)
            spe:SetScript("OnUpdate", nil);
        end
	end)
end)


spe:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
spe:RegisterEvent("PLAYER_ENTERING_WORLD")
spe:RegisterEvent("CHARACTER_POINTS_CHANGED")
spe:RegisterEvent("UPDATE_SHAPESHIFT_FORM")