function fadeFrameShow(f)
    if f:GetAlpha() == 0 then
        f:SetAlpha(1)
    end
end
function fadeFrameHide(f)
    if f:GetAlpha() == 1 then
        UIFrameFadeOut(f, 1,f:GetAlpha(),0)
    end
end

local frameTimer = CreateFrame("FRAME"); --sometimes the icons dont show up after logging in, making a tiny timer to wait for all info
frameTimer.total = 0;
frameTimer:SetScript("OnUpdate", function(self, elapsed)
self.total = self.total + elapsed;
if(self.total > 0.02) then
self:SetScript("OnUpdate",nil);

--CHANGES:Lanrutcon:now only when the player mouseovers the frame it will be shown
MultiBarBottomRight:SetScript("OnUpdate",function(self)
    if self:IsMouseOver(100, -100, -100, 100) then --or UnitAffectingCombat('player') then
       fadeFrameShow(self)
    else
        --if not UnitAffectingCombat('player') then
            if GW2UI_SETTINGS['FADE_BOTTOM_ACTIONBAR']then
                fadeFrameHide(self)   
            end
        --end
    end
end)
MultiBarBottomLeft:SetScript("OnUpdate",function(self)
    if self:IsMouseOver(100, -100, -100, 100) then --or UnitAffectingCombat('player') then
       fadeFrameShow(self)
    else
        --if not UnitAffectingCombat('player') then
             if GW2UI_SETTINGS['FADE_BOTTOM_ACTIONBAR']then
                fadeFrameHide(self)   
            end 
        --end
    end
end)
end
end);