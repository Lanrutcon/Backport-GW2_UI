local paladingPowersCreated = false
local lerpRunningPalading = false
local oldValuePaladin = UnitPower('player',9) * 1000
local newValuePaladin = 0
local startTimePaladin = 0
local currentLerpPaladin = 0

function setAltPowerPaladin()
    if paladingPowersCreated==true then
        return
    end
    paladingPowersCreated = true
    
    --SPELLS/PRIEST_LIGHTWELL_V2.m2
    
    _G["holyPowerBG"],_G["holyPowerTexture"] = createBackground('TOPLEFT',256,32,0,0,"Interface\\AddOns\\GW2_UI\\textures\\holypower_bg",1)
    _G["holyPowerBG"]:ClearAllPoints()
    _G["holyPowerBG"]:SetParent(altPowerHolder);
    _G["holyPowerBG"]:SetPoint('LEFT', altPowerHolderC, 'LEFT', -5, 10);
    
    _G["holyPowerBar"] = CreateFrame("StatusBar", nil, _G["holyPowerBG"])
    _G["holyPowerBar"]:SetStatusBarTexture("Interface\\AddOns\\GW2_UI\\textures\\holypower_fill")
    _G["holyPowerBar"]:GetStatusBarTexture():SetHorizTile(false)
    _G["holyPowerBar"]:SetMinMaxValues(0, 3000)
    _G["holyPowerBar"]:SetValue(0)
    _G["holyPowerBar"]:SetWidth(256)
    _G["holyPowerBar"]:SetHeight(32)
    _G["holyPowerBar"]:SetPoint('CENTER', _G["holyPowerBG"], 'CENTER', 0, 0);

    HolyShine = CreateFrame("PlayerModel",HolyShine,altPowerHolder)
    HolyShine:SetFrameStrata("BACKGROUND")
    HolyShine:SetFrameLevel(0)
    HolyShine:SetWidth(500) 
    HolyShine:SetHeight(474) 
    HolyShine:SetPoint('BOTTOM',MainMenuBar,'BOTTOM',0,-100)
    HolyShine:SetModel('SPELLS/HolyZone.m2')
    HolyShine:SetPosition(-12,0,0)
    HolyShine:SetAlpha(0)
    
          
            _G["holyPowerBG"]:SetScript('OnUpdate',function()

			m = UnitPower('player',9)*1000
            
              if oldValuePaladin ~= m and lerpRunningPaladin~=true then

                    newValuePaladin = UnitPower('player',9) * 1000
                    lerpRunningPaladin = true
                    startTimePaladin = GetTime()
                 
                end
                if lerpRunningPaladin then

                    currentLerpPaladin = lerp(oldValuePaladin, newValuePaladin, (GetTime() - startTimePaladin) / 0.3)
                    HolyShine:SetAlpha((currentLerpPaladin/1000)/3)
                    if (GetTime() - startTimePaladin)>=0.3 then
                        lerpRunningPaladin = false
                        oldValuePaladin = UnitPower('player',9) * 1000
                        currentLerpPaladin = oldValuePaladin
                    end
                end
                _G["holyPowerBar"]:SetValue(currentLerpPaladin)
            end)
         
        end