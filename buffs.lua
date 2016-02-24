BuffFrame:ClearAllPoints()
BuffFrame:SetScale(1)
BuffFrame:Show()
BuffFrame:SetParent(unitframePowerbg)
BuffFrame:SetPoint('BOTTOMRIGHT',unitframePowerbg,'TOPRIGHT',0,10)



--TemporaryEnchantFrame:ClearAllPoints()
--TemporaryEnchantFrame:SetPoint('BOTTOMRIGHT',BuffFrame,'BOTTOMRIGHT', 0, 0)


--CHANGES:Lanrutcon:back to alpha check
BuffFrame:HookScript("OnUpdate", function(self)
    if MultiBarBottomRight:GetAlpha() > 0 then
        BuffFrame:SetPoint('BOTTOMRIGHT',unitframePowerbg,'TOPRIGHT',0,150)
    else
        BuffFrame:SetPoint('BOTTOMRIGHT',unitframePowerbg,'TOPRIGHT',0,40)
    end
end)

BuffFrame:HookScript("OnEvent", function(self, event, unit)
    if unit == 'player' or event == "PLAYER_ENTERING_WORLD" then
        local x, px = 1;
        local y, py = 1;
        local row = 0;
        local col = 0;
        local max = 0;
        local preI = 0
        local isConsolidated = false
		
		for i = 1, 32 do
			if _G["BuffButton"..i] then
				_G["BuffButton" .. i]:SetWidth(25)
				_G["BuffButton" .. i]:SetHeight(25)


				if  _G["BuffButton"..i.."Icon"] then
					_G["BuffButton"..i.."Icon"]:SetTexCoord(0.1,0.9,0.1,0.9)
				end
			end
		end
		
		
		for i = 1, 3 do
			if _G["TempEnchant"..i] then
				_G["TempEnchant" .. i]:SetWidth(25)
				_G["TempEnchant" .. i]:SetHeight(25)

				if  _G["TempEnchant"..i.."Icon"] then
					_G["TempEnchant"..i.."Icon"]:SetTexCoord(0.1,0.9,0.1,0.9)
				end
			end
		end
		
		if DebuffButton1 then
			DebuffButton1:SetPoint("TOPRIGHT", BuffFrame, "TOPRIGHT",0, 45);
		end
--[[
        if _G['ConsolidatedBuffs']:IsShown() then
            _G["ConsolidatedBuffs"]:ClearAllPoints()
            _G["ConsolidatedBuffs"]:SetWidth(25)
            _G["ConsolidatedBuffs"]:SetHeight(25)
            _G["ConsolidatedBuffs"]:ClearAllPoints()
            _G["ConsolidatedBuffs"]:SetPoint('BOTTOMRIGHT',BuffFrame,'BOTTOMRIGHT', 0, 0)



            preI = preI + 1
            col = col +1
            isConsolidated = true
        end
	]]
	end
	
end)
BuffFrame:RegisterEvent("UNIT_AURA");
BuffFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
BuffFrame:RegisterEvent("RAID_ROSTER_UPDATE");
BuffFrame:RegisterEvent("GROUP_ROSTER_UPDATE");
