-- ═══════════════════════════════════════════════════════════════
--  x3d_environment — client (ทำงานฝั่งผู้เล่นอย่างเดียว ไม่มี server)
-- ═══════════════════════════════════════════════════════════════

local Enabled = {
    population = Config.Population.enabled,
    scenarios  = Config.Scenarios.enabled,
    idlecam    = Config.IdleCam.enabled,
    body       = Config.Body.enabled,
    decals     = Config.Decals.enabled,
}

-- ── 1) NPC และรถ AI ─────────────────────────────────────────────

local function applyOneShotPopulation()
    local cfg = Config.Population

    if cfg.garbageTrucks then SetGarbageTrucks(false) end
    if cfg.randomBoats then SetRandomBoats(false) end
    if cfg.randomEvents then SetRandomEventFlag(false) end
    if cfg.distantLights then DisableVehicleDistantlights(true) end
    if cfg.lowPriorityGenerators then SetAllLowPriorityVehicleGeneratorsActive(false) end

    if cfg.randomCops then
        SetCreateRandomCops(false)
        SetCreateRandomCopsNotOnScenarios(false)
        SetCreateRandomCopsOnScenarios(false)
    end

    SetPedPopulationBudget(cfg.pedBudget)
    SetVehiclePopulationBudget(cfg.vehicleBudget)
end

if Config.Population.enabled and Config.Population.densityLoop then
    CreateThread(function()
        local cfg = Config.Population
        while true do
            if Enabled.population then
                SetPedDensityMultiplierThisFrame(cfg.ped)
                SetScenarioPedDensityMultiplierThisFrame(cfg.scenarioInterior, cfg.scenarioExterior)
                SetVehicleDensityMultiplierThisFrame(cfg.vehicle)
                SetRandomVehicleDensityMultiplierThisFrame(cfg.randomVehicle)
                SetParkedVehicleDensityMultiplierThisFrame(cfg.parkedVehicle)
                SetAmbientVehicleRangeMultiplierThisFrame(cfg.ambientRange)
                Wait(0)
            else
                Wait(500)
            end
        end
    end)
end

local function isWorldPopulation(entity)
    local popType = GetEntityPopulationType(entity)
    return popType >= 1 and popType <= 5
end

local function vehicleHoldsPlayer(veh)
    for seat = -1, GetVehicleMaxNumberOfPassengers(veh) - 1 do
        local ped = GetPedInVehicleSeat(veh, seat)
        if ped ~= 0 and IsPedAPlayer(ped) then return true end
    end
    return false
end

local function wipe(entity)
    SetEntityAsMissionEntity(entity, true, true)
    DeleteEntity(entity)
end

if Config.Population.enabled and Config.Population.sweep then
    CreateThread(function()
        local cfg = Config.Population
        while true do
            Wait(cfg.sweepInterval)
            if Enabled.population then
                local me = PlayerPedId()

                if cfg.sweepPeds then
                    for _, ped in ipairs(GetGamePool('CPed')) do
                        if ped ~= me and not IsPedAPlayer(ped) and isWorldPopulation(ped) then
                            wipe(ped)
                        end
                    end
                end

                if cfg.sweepVehicles then
                    local myVeh = GetVehiclePedIsIn(me, false)
                    for _, veh in ipairs(GetGamePool('CVehicle')) do
                        if veh ~= myVeh and isWorldPopulation(veh) and not vehicleHoldsPlayer(veh) then
                            wipe(veh)
                        end
                    end
                end
            end
        end
    end)
end

-- ── 2) Scenario ในแมพ ───────────────────────────────────────────

local function applyScenarios(enable)
    if Config.Scenarios.vehicle then
        for _, name in ipairs(Config.VehicleScenarios) do
            SetScenarioTypeEnabled(name, enable)
        end
    end
    if Config.Scenarios.human then
        for _, name in ipairs(Config.HumanScenarios) do
            SetScenarioTypeEnabled(name, enable)
        end
    end
end

-- ── 3) กล้อง idle ───────────────────────────────────────────────

if Config.IdleCam.enabled then
    CreateThread(function()
        while true do
            if Enabled.idlecam then
                InvalidateIdleCam()
                InvalidateVehicleIdleCam()
            end
            Wait(Config.IdleCam.interval)
        end
    end)
end

-- ── 4) คราบบนตัวผู้เล่น ──────────────────────────────────────────

local function cleanPed(ped)
    local cfg = Config.Body
    if cfg.blood then ClearPedBloodDamage(ped) end
    if cfg.damage then ResetPedVisibleDamage(ped) end
    if cfg.dirt then ClearPedEnvDirt(ped) end
    if cfg.wetness then ClearPedWetness(ped) end
end

if Config.Body.enabled then
    CreateThread(function()
        while true do
            Wait(Config.Body.interval)
            if Enabled.body then
                cleanPed(PlayerPedId())

                if Config.Body.otherPlayers then
                    local myId = PlayerId()
                    for _, pid in ipairs(GetActivePlayers()) do
                        if pid ~= myId then
                            local ped = GetPlayerPed(pid)
                            if ped ~= 0 and DoesEntityExist(ped) then cleanPed(ped) end
                        end
                    end
                end
            end
        end
    end)

    AddEventHandler('playerSpawned', function()
        cleanPed(PlayerPedId())
    end)
end

-- ── 5) คราบบนพื้น ───────────────────────────────────────────────

if Config.Decals.enabled then
    CreateThread(function()
        while true do
            Wait(Config.Decals.interval)
            if Enabled.decals then
                local coords = GetEntityCoords(PlayerPedId())
                RemoveDecalsInRange(coords.x, coords.y, coords.z, Config.Decals.radius)
            end
        end
    end)
end

-- ── เริ่มทำงาน ───────────────────────────────────────────────────

CreateThread(function()
    if Config.Population.enabled then applyOneShotPopulation() end
    if Config.Scenarios.enabled then applyScenarios(false) end

    if not Config.PrintStatus then return end

    print('^3[x3d_environment]^7 ' .. table.concat({
        'npc=' .. tostring(Enabled.population),
        'scenarios=' .. tostring(Enabled.scenarios),
        'idlecam=' .. tostring(Enabled.idlecam),
        'body=' .. tostring(Enabled.body),
        'decals=' .. tostring(Enabled.decals),
    }, ' '))
end)

AddEventHandler('onResourceStop', function(res)
    if res ~= GetCurrentResourceName() then return end
    if Config.Scenarios.enabled and Config.Scenarios.restoreOnStop then
        ResetScenarioTypesEnabled()
    end
end)

-- ── ให้ resource อื่นปิด/เปิดชั่วคราวได้ ─────────────────────────
--  ตัวอย่าง: exports['x3d_environment']:SetEnabled('population', false)
--  โมดูล: population · scenarios · idlecam · body · decals

exports('SetEnabled', function(module, state)
    if Enabled[module] == nil then return false end

    Enabled[module] = state == true

    if module == 'population' and state then applyOneShotPopulation() end
    if module == 'scenarios' then applyScenarios(not state) end

    return true
end)

exports('IsEnabled', function(module) return Enabled[module] == true end)
