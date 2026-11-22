local _, ns = ...

--------------------------------------------------
-- SWING TIMER ON THE HEALTH BAR (an extension for FlareUI's player frame)
-- A spark crosses the player's health bar over each main-hand swing, as FlareUI's Five-Second Rule
-- spark does the mana bar: the next swing lands as it reaches the end. PLAYER_SWING gives the swing's
-- length as it starts.
--------------------------------------------------
local SwingSpark = {}   -- finish, duration: the main-hand swing running now; holder: the spark's frame
ns.SwingSpark = SwingSpark

local DEFAULTS = { enabled = true }
local SPARK = "Interface\\CastingBar\\UI-CastingBar-Spark"

-- FlareUI's player frame's health bar
local function HealthBar()
    local frame = _G.FlareUI_UF_Player
    local bar = type(frame) == "table" and frame.Health
    return type(bar) == "table" and bar.GetWidth and bar or nil
end

function SwingSpark.Move(holder)
    local duration = SwingSpark.duration
    local remaining = SwingSpark.finish and (SwingSpark.finish - GetTime())
    if not remaining or remaining <= 0 or not (duration and duration > 0) then
        SwingSpark.finish = nil
        holder:Hide()
        return
    end
    local bar = holder:GetParent()
    local width = bar:GetWidth()
    local x = width * math.max(0, 1 - remaining / duration)
    if bar.GetReverseFill and bar:GetReverseFill() then x = width - x end
    holder.Spark:SetPoint("CENTER", bar, "LEFT", x, 0)
end

-- the spark on the health bar, hidden until a swing runs
function SwingSpark.Create()
    if SwingSpark.holder then return SwingSpark.holder end
    local bar = HealthBar()
    if not bar then return nil end
    local holder = CreateFrame("Frame", nil, bar)
    holder:SetAllPoints(bar)
    holder:SetFrameLevel(bar:GetFrameLevel() + 2)
    holder:Hide()
    local spark = holder:CreateTexture(nil, "OVERLAY")
    spark:SetTexture(SPARK)
    spark:SetBlendMode("ADD")
    holder.Spark = spark
    -- the spark art is mostly glow, so it is taller than the bar
    holder:SetScript("OnShow", function(self)
        local height = bar:GetHeight()
        self.Spark:SetSize(math.max(height, 8), math.max(height * 2.2, 18))
    end)
    holder:SetScript("OnUpdate", SwingSpark.Move)
    SwingSpark.holder = holder
    return holder
end

function SwingSpark.Update()
    local holder = SwingSpark.Create()
    if not holder then return end
    if SwingSpark.finish and GetTime() >= SwingSpark.finish then SwingSpark.finish = nil end
    local on = ns.db and ns.db.enabled and SwingSpark.finish ~= nil and holder:GetParent():IsShown()
    holder:SetShown(on and true or false)
end

function SwingSpark.Init()
    local mainHand = Enum.PlayerSwingType and Enum.PlayerSwingType.MainHand
    local events = CreateFrame("Frame")
    if mainHand == nil or not pcall(events.RegisterEvent, events, "PLAYER_SWING") then
        ns.Print("this game version does not report swings, so the swing timer cannot show.")
        return
    end
    events:SetScript("OnEvent", function(_, _, duration, swingType)
        if swingType ~= mainHand then return end
        if canaccessvalue ~= nil and not canaccessvalue(duration) then return end
        if type(duration) ~= "number" or duration <= 0 then return end
        SwingSpark.finish, SwingSpark.duration = GetTime() + duration, duration
        SwingSpark.Update()
    end)
end

local started = false
ns.OnReady("FlareUI_SwingSparkDB", DEFAULTS, function()
    ns.RegisterOptions("Swing Timer on Health Bar for FlareUI", {
        { key = "enabled", label = "Swing Timer on Health Bar",
          flare = { key = "uf.extSwing", section = "uf.extensions", sectionTitle = "Extensions", tab = "settings", half = true },
          tip = "A spark crosses the health bar of FlareUI's player frame over each main-hand swing: your next swing lands as it reaches the end." },
    }, "/flareswing", function() if started then SwingSpark.Update() end end)
end, function()
    started = true
    SwingSpark.Init()
    SwingSpark.Update()
end)
