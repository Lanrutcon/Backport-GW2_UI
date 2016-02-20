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

function setAltPower(event,unit)
local playerClassName, playerClassEng = UnitClass('player')
local currentSpec  = GetSpecialization();
local stance = GetShapeshiftFormID()
    if stance==nil then
        stance = 0
    end
    if event == 'UPDATE_SHAPESHIFT_FORM' and stance~=nil then
        if prevStance==31 then
            unSetAltPowerMoonkin()
        end
          if prevStance == 1 then
                unSetAltPowerRogue()
            end
        prevStance = stance
    end
    
    --PALADIN
   if  playerClassName=="Paladin" then
        setAltPowerPaladin()
    end
    
    if playerClassName==4 then
        setAltPowerRogue()
    end
    
    --PRIEST
    if  playerClassName=="Priest" and currentSpec==1 then
        if prevSpec == 3 then
            unSetAltPowerPriestShadow()
        end
        setAltPowerPriestDiscipline()
    end
    if  playerClassName=="Priest" and currentSpec==2 then
        if prevSpec == 1 then
            unSetAltPowerPriestDiscipline()
        end
        if prevSpec == 3 then
           unSetAltPowerPriestShadow()
        end
    end
    if  playerClassName=="Priest" and currentSpec==3 then
        if prevSpec == 1 then
            unSetAltPowerPriestDiscipline()
        end
        
        setAltPowerPriestShadow()
    end
    
    
    -- DEATH KNIGHT
    if  playerClassName=="Death Knight" then
        setAltPowerDeathKnight()
    end
    
    
    -- WARLOCK
     if  playerClassName=="Warlock" and currentSpec==1 then
        if prevSpec == 2 then
            unSetAltPowerWarlockDemonology()
        end
        if prevSpec == 3 then
            unSetAltPowerWarlockDestruction()
        end
        setAltPowerWarlockAffliction()
    end
    
    if  playerClassName=="Warlock" and currentSpec==2 then
        if prevSpec == 1 then
            unSetAltPowerWarlockAffliction()
        end
        if prevSpec == 3 then
            unSetAltPowerWarlockDestruction()
        end
        setAltPowerWarlockDemonology()
    end
     if  playerClassName=="Warlock" and currentSpec==3 then
        if prevSpec == 2 then
            unSetAltPowerWarlockDemonology()
        end
        if prevSpec == 1 then
            unSetAltPowerWarlockAffliction()
        end
         setAltPowerWarlockDestruction()
    end
    
    
    -- DRUID
    if  playerClassName=="Druid" then
        
        if stance==1 then
            setAltPowerRogue()
        end
        
        if stance==5 or stance==4 or stance==3 or stance==2 or stance==29 then
            
            
        end
        if stance == 31 then
          
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
		spe:SetScript("OnUpdate", function(self, elapsed)
			spe.total = spe.total + elapsed;
			if(spe.total > 0.05) then
				setAltPower(event,unit)
				spe:SetScript("OnUpdate", nil);
			end
		end);
    end)



spe:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
spe:RegisterEvent("PLAYER_ENTERING_WORLD")
spe:RegisterEvent("CHARACTER_POINTS_CHANGED")
spe:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
