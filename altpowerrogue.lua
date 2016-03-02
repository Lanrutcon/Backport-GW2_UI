function setAltPowerRogue()
	for i = 1,5 do
		createBackgroundName('BOTTOM',45,16,0,0,"Interface\\AddOns\\GW2_UI\\textures\\altpowerbarbg",1,"combatPoints" .. i .. "BG")
		_G["combatPoints" .. i .. "BG"]:ClearAllPoints();
		_G["combatPoints" .. i .. "BG"]:SetParent(altPowerHolderC);
		_G["combatPoints" .. i .. "BGTexture"]:SetVertexColor(0,0,0,1);
		_G["combatPoints" .. i .. "BG"]:SetPoint('LEFT', altPowerHolderC, 'LEFT', 50*(i-1), 7);
		
		createBackgroundName('BOTTOM',45,16,0,0,"Interface\\AddOns\\GW2_UI\\textures\\altpowerbarfill",2,"combatPointsFill" .. i .. "BG")
		_G["combatPointsFill" .. i .. "BG"]:ClearAllPoints();
		_G["combatPointsFill" .. i .. "BG"]:SetParent(altPowerHolderC);
		_G["combatPointsFill" .. i .. "BGTexture"]:SetVertexColor(93/255,5/255,255/255,0);
		_G["combatPointsFill" .. i .. "BG"]:SetPoint('LEFT', altPowerHolderC, 'LEFT', 50*(i-1), 7);
	end
    
	altPowerHolderC:SetScript("OnEvent", function(self,event,unit)
        if unit =='player' then
			updateCombatPoints()
		end
	end);
	altPowerHolderC:RegisterEvent("UNIT_TARGET");
	altPowerHolderC:RegisterEvent("UNIT_COMBO_POINTS");
	updateCombatPoints();
end

function updateCombatPoints()
	local comboPoints = GetComboPoints(UnitHasVehicleUI("player") and "vehicle" or "player")
	if comboPoints>0 then
		for i = 1,5 do
			if comboPoints>= i then
				_G["combatPointsFill" .. i .. "BGTexture"]:SetVertexColor(165/255,114/255,63/255,1);
			else
				_G["combatPointsFill" .. i .. "BGTexture"]:SetVertexColor(233/255,174/255,5/255,0);
			end
		end
	else
		for i = 1,3 do
			_G["combatPointsFill" .. i .. "BGTexture"]:SetVertexColor(93/255,5/255,255/255,0);
		end
	end
end

function unSetAltPowerRogue()
    for i = 1,5 do
        if _G["combatPoints" .. i .. "BGTexture"] then
            _G["combatPoints" .. i .. "BGTexture"]:SetVertexColor(0,0,0,0);
        end
        if _G["combatPointsFill" .. i .. "BGTexture"] then
            _G["combatPointsFill" .. i .. "BGTexture"]:SetVertexColor(0,0,0,0);
        end
    end
end