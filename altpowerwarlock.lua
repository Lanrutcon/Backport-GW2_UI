  function setAltPowerWarlock()
            for i = 1,3 do
                if i>3 then
                    createBackgroundName('BOTTOM',16,16,0,0,"Interface\\AddOns\\GW2_UI\\textures\\altpowerbg",1,"soulShards" .. i .. "BG")
                else
                 createBackgroundName('BOTTOM',45,16,0,0,"Interface\\AddOns\\GW2_UI\\textures\\altpowerbarbg",1,"soulShards" .. i .. "BG")
                end
                _G["soulShards" .. i .. "BG"]:ClearAllPoints();
                _G["soulShards" .. i .. "BG"]:SetParent(altPowerHolder);
                _G["soulShards" .. i .. "BGTexture"]:SetVertexColor(0,0,0,1);
                local p  = 50*(i-1)
                if i > 3 then
                    p = (50*2) + (25 * (i-4)) + (36)
                end
                _G["soulShards" .. i .. "BG"]:SetPoint('LEFT', altPowerHolder, 'LEFT', p, 7);


                if i>3 then
                    createBackgroundName('BOTTOM',16,16,0,0,"Interface\\AddOns\\GW2_UI\\textures\\altpowerfill",2,"soulShardsFill" .. i .. "BG")
                else
                    createBackgroundName('BOTTOM',45,16,0,0,"Interface\\AddOns\\GW2_UI\\textures\\altpowerbarfill",2,"soulShardsFill" .. i .. "BG")
                end
                _G["soulShardsFill" .. i .. "BG"]:ClearAllPoints();
                _G["soulShardsFill" .. i .. "BG"]:SetParent(altPowerHolder);
                _G["soulShardsFill" .. i .. "BGTexture"]:SetVertexColor(93/255,5/255,255/255,0);
                _G["soulShardsFill" .. i .. "BG"]:SetPoint('LEFT', altPowerHolder, 'LEFT', p, 7);

            end
            altPowerHolder:SetScript("OnEvent", function(self, event, unit)
                    if unit =='player' then
                         updateSoulShards()
                    end
            end)
            altPowerHolder:RegisterEvent("UNIT_POWER");
            updateSoulShards()
        end

  function updateSoulShards()
       for i = 1,3 do
            if UnitPower('player',7)>= i then
                _G["soulShardsFill" .. i .. "BGTexture"]:SetVertexColor(228/255,102/255,255/255,1);
            else
                _G["soulShardsFill" .. i .. "BGTexture"]:SetVertexColor(233/255,174/255,5/255,0);
            end
                                
            if i>UnitPowerMax('player',7) then
                _G["soulShardsFill" .. i .. "BGTexture"]:SetVertexColor(0,0,0,0);
            end
        end
    end