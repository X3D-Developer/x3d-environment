-- ═══════════════════════════════════════════════════════════════
--  x3d_environment — ตั้งค่า
--  ทุกโมดูลปิด/เปิดแยกกันได้ ปิดอันไหนคือโค้ดส่วนนั้นไม่ทำงานเลย
--  X3D-Developer · https://x3d-developer.com
-- ═══════════════════════════════════════════════════════════════

Config = {}

-- พิมพ์สรุปว่าโมดูลไหนทำงานบ้างตอน resource เริ่ม (F8)
Config.PrintStatus = true

-- ═══════════════════════════════════════════════════════════════
--  1) NPC และรถ AI
-- ═══════════════════════════════════════════════════════════════
Config.Population = {
    enabled = true,

    -- ความหนาแน่น 0.0 = ไม่มีเลย · 1.0 = ปกติ
    -- ต้องสั่งทุกเฟรม เป็นข้อจำกัดของเกม ไม่ใช่บั๊ก
    -- อยากได้ฟรีจริง ๆ: ใส่ set onesync_population false ใน server.cfg
    -- แล้วตั้ง densityLoop = false เซิร์ฟเวอร์จะไม่สร้าง NPC ตั้งแต่ต้น
    densityLoop = true,

    ped              = 0.0,  -- คนเดินถนน
    scenarioInterior = 0.0,  -- คนทำท่าทางในอาคาร
    scenarioExterior = 0.0,  -- คนทำท่าทางนอกอาคาร
    vehicle          = 0.0,  -- รถวิ่ง
    randomVehicle    = 0.0,  -- รถสุ่ม
    parkedVehicle    = 0.0,  -- รถจอด
    ambientRange     = 0.0,  -- ระยะที่เกมสร้างรถรอบตัว

    -- ปิดของที่เกมสร้างเองแบบพิเศษ
    garbageTrucks = true,   -- รถขยะ
    randomBoats   = true,   -- เรือสุ่ม
    randomCops    = true,   -- ตำรวจ AI
    randomEvents  = true,   -- เหตุการณ์สุ่ม (คนวิ่งหนี, ปล้นร้าน ฯลฯ)
    distantLights = true,   -- ไฟรถไกล ๆ ที่ไม่มีรถจริง
    lowPriorityGenerators = true,

    -- งบหน่วยความจำของ NPC / รถ (0 = ต่ำสุด, 3 = ปกติ)
    pedBudget     = 0,
    vehicleBudget = 0,

    -- ลบ NPC / รถ ที่เกิดไปแล้วทิ้ง
    -- ปลอดภัย: ลบเฉพาะของที่ "เกม" สร้าง (population type 1-5)
    -- NPC ที่ resource อื่นสร้าง (ร้านค้า, อาชีพ, ภารกิจ) ไม่โดนแตะ
    sweep         = true,
    sweepInterval = 2000,
    sweepPeds     = true,
    sweepVehicles = true,
}

-- ═══════════════════════════════════════════════════════════════
--  2) Scenario ในแมพ
-- ═══════════════════════════════════════════════════════════════
Config.Scenarios = {
    enabled = true,

    -- scenario ของรถ (รถ AI จอดรอ, ตำรวจขับตรวจ, รถทหารบิน ฯลฯ)
    vehicle = true,

    -- ⚠ scenario ของคน — ค่าเริ่มต้นคือ "ปิดไว้" โดยตั้งใจ
    --
    -- SetScenarioTypeEnabled ปิดทั้งเกม ไม่ได้ปิดแค่ NPC ของเกม
    -- resource อื่นที่สั่ง TaskStartScenarioInPlace (NPC ร้านค้า, NPC อาชีพ,
    -- NPC ธนาคาร) จะยืนเฉย ๆ ท่าหายหมด
    --
    -- คนเดินถนนของเกมถูกกำจัดด้วย scenarioInterior/scenarioExterior = 0.0
    -- และ sweep อยู่แล้ว ไม่ต้องเปิดอันนี้
    --
    -- เปิดก็ต่อเมื่อเซิร์ฟเวอร์ไม่มี NPC ที่ใช้ scenario เลย
    human = false,

    -- คืนค่า scenario ทั้งหมดตอนสั่ง stop x3d_environment
    restoreOnStop = true,
}

Config.VehicleScenarios = {
    'WORLD_VEHICLE_ATTRACTOR',
    'WORLD_VEHICLE_AMBULANCE',
    'WORLD_VEHICLE_BICYCLE_BMX',
    'WORLD_VEHICLE_BICYCLE_BMX_BALLAS',
    'WORLD_VEHICLE_BICYCLE_BMX_FAMILY',
    'WORLD_VEHICLE_BICYCLE_BMX_HARMONY',
    'WORLD_VEHICLE_BICYCLE_BMX_VAGOS',
    'WORLD_VEHICLE_BICYCLE_MOUNTAIN',
    'WORLD_VEHICLE_BICYCLE_ROAD',
    'WORLD_VEHICLE_BIKE_OFF_ROAD_RACE',
    'WORLD_VEHICLE_BIKER',
    'WORLD_VEHICLE_BOAT_IDLE',
    'WORLD_VEHICLE_BOAT_IDLE_ALAMO',
    'WORLD_VEHICLE_BOAT_IDLE_MARQUIS',
    'WORLD_VEHICLE_BROKEN_DOWN',
    'WORLD_VEHICLE_BUSINESSMEN',
    'WORLD_VEHICLE_CLUCKIN_BELL_TRAILER',
    'WORLD_VEHICLE_CONSTRUCTION_PASSENGERS',
    'WORLD_VEHICLE_CONSTRUCTION_SOLO',
    'WORLD_VEHICLE_DISTANT_EMPTY_GROUND',
    'WORLD_VEHICLE_DRIVE_PASSENGERS',
    'WORLD_VEHICLE_DRIVE_PASSENGERS_LIMITED',
    'WORLD_VEHICLE_DRIVE_SOLO',
    'WORLD_VEHICLE_EMPTY',
    'WORLD_VEHICLE_FIRE_TRUCK',
    'WORLD_VEHICLE_HELI_LIFEGUARD',
    'WORLD_VEHICLE_MARIACHI',
    'WORLD_VEHICLE_MECHANIC',
    'WORLD_VEHICLE_MILITARY_PLANES_BIG',
    'WORLD_VEHICLE_MILITARY_PLANES_SMALL',
    'WORLD_VEHICLE_PARK_PARALLEL',
    'WORLD_VEHICLE_PARK_PERPENDICULAR_NOSE_IN',
    'WORLD_VEHICLE_PASSENGER_EXIT',
    'WORLD_VEHICLE_POLICE',
    'WORLD_VEHICLE_POLICE_BIKE',
    'WORLD_VEHICLE_POLICE_CAR',
    'WORLD_VEHICLE_POLICE_NEXT_TO_CAR',
    'WORLD_VEHICLE_QUARRY',
    'WORLD_VEHICLE_SALTON',
    'WORLD_VEHICLE_SALTON_DIRT_BIKE',
    'WORLD_VEHICLE_SECURITY_CAR',
    'WORLD_VEHICLE_STREETRACE',
    'WORLD_VEHICLE_TANDL',
    'WORLD_VEHICLE_TOURBUS',
    'WORLD_VEHICLE_TOURIST',
    'WORLD_VEHICLE_TRACTOR',
    'WORLD_VEHICLE_TRACTOR_BEACH',
    'WORLD_VEHICLE_TRUCKS_TRAILERS',
    'WORLD_VEHICLE_TRUCK_LOGS',
}

-- ใช้เมื่อ Config.Scenarios.human = true เท่านั้น (อ่านคำเตือนด้านบนก่อน)
Config.HumanScenarios = {
    'WORLD_HUMAN_AA_COFFEE',
    'WORLD_HUMAN_AA_SMOKE',
    'WORLD_HUMAN_BINOCULARS',
    'WORLD_HUMAN_BUM_FREEWAY',
    'WORLD_HUMAN_BUM_SHOPPING_CART',
    'WORLD_HUMAN_BUM_SLUMPED',
    'WORLD_HUMAN_BUM_STANDING',
    'WORLD_HUMAN_BUM_WASH',
    'WORLD_HUMAN_CHEERING',
    'WORLD_HUMAN_CLIPBOARD',
    'WORLD_HUMAN_CONST_DRILL',
    'WORLD_HUMAN_COP_IDLES',
    'WORLD_HUMAN_DRINKING',
    'WORLD_HUMAN_DRUG_DEALER',
    'WORLD_HUMAN_DRUG_DEALER_HARD',
    'WORLD_HUMAN_GARDENER_LEAF_BLOWER',
    'WORLD_HUMAN_GARDENER_PLANT',
    'WORLD_HUMAN_GUARD_PATROL',
    'WORLD_HUMAN_GUARD_STAND',
    'WORLD_HUMAN_GUARD_STAND_ARMY',
    'WORLD_HUMAN_HAMMERING',
    'WORLD_HUMAN_HANG_OUT_STREET',
    'WORLD_HUMAN_HIKER_STANDING',
    'WORLD_HUMAN_HUMAN_STATUE',
    'WORLD_HUMAN_JANITOR',
    'WORLD_HUMAN_JOG_STANDING',
    'WORLD_HUMAN_LEANING',
    'WORLD_HUMAN_MAID_CLEAN',
    'WORLD_HUMAN_MUSCLE_FLEX',
    'WORLD_HUMAN_MUSCLE_FREE_WEIGHTS',
    'WORLD_HUMAN_MUSICIAN',
    'WORLD_HUMAN_PAPARAZZI',
    'WORLD_HUMAN_PARTYING',
    'WORLD_HUMAN_PICNIC',
    'WORLD_HUMAN_PROSTITUTE_HIGH_CLASS',
    'WORLD_HUMAN_PROSTITUTE_LOW_CLASS',
    'WORLD_HUMAN_PUSH_UPS',
    'WORLD_HUMAN_SEAT_LEDGE',
    'WORLD_HUMAN_SEAT_LEDGE_EATING',
    'WORLD_HUMAN_SEAT_STEPS',
    'WORLD_HUMAN_SEAT_WALL',
    'WORLD_HUMAN_SEAT_WALL_EATING',
    'WORLD_HUMAN_SEAT_WALL_TABLET',
    'WORLD_HUMAN_SECURITY_SHINE_TORCH',
    'WORLD_HUMAN_SIT_UPS',
    'WORLD_HUMAN_SMOKING',
    'WORLD_HUMAN_SMOKING_POT',
    'WORLD_HUMAN_STAND_FIRE',
    'WORLD_HUMAN_STAND_FISHING',
    'WORLD_HUMAN_STAND_IMPATIENT',
    'WORLD_HUMAN_STAND_MOBILE',
    'WORLD_HUMAN_STRIP_WATCH_STAND',
    'WORLD_HUMAN_STUPOR',
    'WORLD_HUMAN_SUNBATHE',
    'WORLD_HUMAN_SUNBATHE_BACK',
    'WORLD_HUMAN_SWIMMING',
    'WORLD_HUMAN_TENNIS_PLAYER',
    'WORLD_HUMAN_TOURIST_MAP',
    'WORLD_HUMAN_TOURIST_MOBILE',
    'WORLD_HUMAN_VEHICLE_MECHANIC',
    'WORLD_HUMAN_WELDING',
    'WORLD_HUMAN_WINDOW_SHOP_BROWSE',
    'WORLD_HUMAN_YOGA',
}

-- ═══════════════════════════════════════════════════════════════
--  3) กล้อง idle (กล้องที่หมุนเองตอนยืนนิ่ง)
-- ═══════════════════════════════════════════════════════════════
Config.IdleCam = {
    enabled  = true,
    interval = 1000,
}

-- ═══════════════════════════════════════════════════════════════
--  4) คราบบนตัวผู้เล่น (เลือด, แผล, ฝุ่น, เปียก)
-- ═══════════════════════════════════════════════════════════════
Config.Body = {
    enabled  = true,
    interval = 2000,

    blood   = true,   -- คราบเลือด
    damage  = true,   -- รอยแผล / เสื้อผ้าขาดจากการโดนยิง
    dirt    = true,   -- ฝุ่น โคลน
    wetness = true,   -- เปียกน้ำ

    -- ล้างให้ผู้เล่นคนอื่นที่เห็นอยู่ด้วย (ทำเฉพาะในเครื่องเรา ไม่ยุ่งกับคนอื่น)
    otherPlayers = true,
}

-- ═══════════════════════════════════════════════════════════════
--  5) คราบบนพื้น (เลือดตกพื้น, ลอยยาง, รอยกระสุน)
-- ═══════════════════════════════════════════════════════════════
Config.Decals = {
    enabled  = true,
    interval = 5000,
    radius   = 80.0,  -- ล้างในรัศมีนี้รอบตัวผู้เล่น (เมตร)
}
