function setAltPowerPriestDiscipline()
	if not UnitAura('player','Evangelism') then
		altPowerHolderS:Hide()
	end
	for i = 1,5 do
        createBackgroundName('BOTTOM',45,16,0,0,"Interface\\AddOns\\GW2_UI\\textures\\altpowerbarbg",1,"light" .. i .. "BG")
        _G["light" .. i .. "BG"]:ClearAllPoints();
        _G["light" .. i .. "BG"]:SetParent(altPowerHolderS);
        _G["light" .. i .. "BGTexture"]:SetVertexColor(0,0,0,1);
        _G["light" .. i .. "BG"]:SetPoint('TOPLEFT', altPowerHolderC, 'TOPLEFT', 50*(i-1), 10);

        createBackgroundName('BOTTOM',45,16,0,0,"Interface\\AddOns\\GW2_UI\\textures\\altpowerbarfill",2,"lightFill" .. i .. "BG")
        _G["lightFill" .. i .. "BG"]:ClearAllPoints();
        _G["lightFill" .. i .. "BG"]:SetParent(altPowerHolderS);
        _G["lightFill" .. i .. "BGTexture"]:SetVertexColor(233/255,208/255,82/255,0);
        _G["lightFill" .. i .. "BG"]:SetPoint('TOPLEFT', altPowerHolderC, 'TOPLEFT', 50*(i-1), 10);
    end

    altPowerHolderS:SetScript("OnEvent", function(self, event, unit)
        if unit =='player' then
            if UnitAura('player','Evangelism') then
				altPowerHolderS:Show()
                name, rank, icon, count = UnitAura('player','Evangelism')
                    for i = 1,5 do
                        if count>= i then
                            _G["lightFill" .. i .. "BGTexture"]:SetVertexColor(233/255,174/255,5/255,1);
                        else
                            _G["lightFill" .. i .. "BGTexture"]:SetVertexColor(233/255,174/255,5/255,0);
                        end                   
                    end
            else
				altPowerHolderS:Hide()
                for i = 1,5 do
                    _G["lightFill" .. i .. "BGTexture"]:SetVertexColor(233/255,208/255,82/255,0);
                end
            end
        end
    end)
    altPowerHolderS:RegisterEvent("UNIT_AURA");
end

function setAltPowerPriestShadow()
	if not UnitAura('player','Shadow Orb') then
		altPowerHolderP:Hide()
	end
	
 	if not UnitAura('player','Dark Evangelism') then
		altPowerHolderS:Hide()
	end

	for i = 1,3 do
	createBackgroundName('BOTTOM',65,16,0,0,"Interface\\AddOns\\GW2_UI\\textures\\altpowerbarbg",1,"shadowOrb" .. i .. "BG")
    _G["shadowOrb" .. i .. "BG"]:ClearAllPoints();
    _G["shadowOrb" .. i .. "BG"]:SetParent(altPowerHolderP);
    _G["shadowOrb" .. i .. "BGTexture"]:SetVertexColor(0,0,0,1);
    _G["shadowOrb" .. i .. "BG"]:SetPoint('LEFT', altPowerHolderP, 'TOPLEFT', 75*(i-1), 0);

	createBackgroundName('BOTTOM',65,16,0,0,"Interface\\AddOns\\GW2_UI\\textures\\altpowerbarfill",2,"shadowOrbFill" .. i .. "BG")
    _G["shadowOrbFill" .. i .. "BG"]:ClearAllPoints();
    _G["shadowOrbFill" .. i .. "BG"]:SetParent(altPowerHolderP);
    _G["shadowOrbFill" .. i .. "BGTexture"]:SetVertexColor(93/255,5/255,255/255,0);
    _G["shadowOrbFill" .. i .. "BG"]:SetPoint('LEFT', altPowerHolderP, 'TOPLEFT', 75*(i-1), 0);
	end
    
	for i = 1,5 do
        createBackgroundName('BOTTOM',45,16,0,0,"Interface\\AddOns\\GW2_UI\\textures\\altpowerbarbg",1,"light" .. i .. "BG")
        _G["light" .. i .. "BG"]:ClearAllPoints();
        _G["light" .. i .. "BG"]:SetParent(altPowerHolderS);
        _G["light" .. i .. "BGTexture"]:SetVertexColor(0,0,0,1);
        _G["light" .. i .. "BG"]:SetPoint('TOPLEFT', altPowerHolderS, 'TOPLEFT', 50*(i-1), 10);

        createBackgroundName('BOTTOM',45,16,0,0,"Interface\\AddOns\\GW2_UI\\textures\\altpowerbarfill",2,"lightFill" .. i .. "BG")
        _G["lightFill" .. i .. "BG"]:ClearAllPoints();
        _G["lightFill" .. i .. "BG"]:SetParent(altPowerHolderS);
        _G["lightFill" .. i .. "BGTexture"]:SetVertexColor(233/255,208/255,82/255,0);
        _G["lightFill" .. i .. "BG"]:SetPoint('TOPLEFT', altPowerHolderS, 'TOPLEFT', 50*(i-1), 10);
    end

	altPowerHolderP:SetScript("OnEvent", function(self, event, unit)
		if unit =='player' and GetSpecialization()==3 then
            if UnitAura('player','Shadow Orb') then
				altPowerHolderP:Show()
				name, rank, icon, count = UnitAura('player','Shadow Orb')
                    for i = 1,3 do
                        if count>= i then
                            _G["shadowOrbFill" .. i .. "BGTexture"]:SetVertexColor(129/255,79/255,255/255,1);
                        else
                            _G["shadowOrbFill" .. i .. "BGTexture"]:SetVertexColor(233/255,174/255,5/255,0);
                        end
                    end
            else
                altPowerHolderP:Hide()
				for i = 1,3 do
                    _G["shadowOrbFill" .. i .. "BGTexture"]:SetVertexColor(93/255,5/255,255/255,0);
                end
            end
		end
	end)
	
	    altPowerHolderS:SetScript("OnEvent", function(self, event, unit)
        if unit =="player"  then
            if UnitAura('player','Dark Evangelism') then
				altPowerHolderS:Show()
                name, rank, icon, count = UnitAura('player','Dark Evangelism')
                    for i = 1,5 do
                        if count>= i then
                            _G["lightFill" .. i .. "BGTexture"]:SetVertexColor(233/255,174/255,5/255,1);
                        else
                            _G["lightFill" .. i .. "BGTexture"]:SetVertexColor(233/255,174/255,5/255,0);
                        end                   
                    end
            else
				altPowerHolderS:Hide()
                for i = 1,5 do
                    _G["lightFill" .. i .. "BGTexture"]:SetVertexColor(233/255,208/255,82/255,0);
                end
            end
        end
    end)
    altPowerHolderP:RegisterEvent("UNIT_AURA");
    altPowerHolderS:RegisterEvent("UNIT_AURA");
end

function unSetAltPowerPriestDiscipline()
    for i = 1,5 do
        _G["light" .. i .. "BGTexture"]:SetVertexColor(0,0,0,0);
        _G["lightFill" .. i .. "BGTexture"]:SetVertexColor(233/255,208/255,82/255,0);
    end
end

function unSetAltPowerPriestShadow()
	altPowerHolderP:Hide()
	altPowerHolderS:Hide()
	for i = 1,3 do
        if _G["shadowOrb" .. i .. "BGTexture"] then
			_G["shadowOrb" .. i .. "BGTexture"]:SetVertexColor(0,0,0,0);
        end
		if _G["shadowOrbFill" .. i .. "BGTexture"] then
			_G["shadowOrbFill" .. i .. "BGTexture"]:SetVertexColor(233/255,208/255,82/255,0);
		end
	end
end