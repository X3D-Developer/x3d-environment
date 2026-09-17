# X3D Environment

ล้างแมพ FiveM ให้สะอาด — ปิด NPC / รถ AI / scenario / กล้อง idle, ล้างคราบเลือด-ลอยยาง-รอยกระสุน, เพิ่ม FPS. ไฟล์เดียว 5 โมดูลเปิดปิดแยกกันได้. · Clean the FiveM map: disable NPCs/AI traffic, boost FPS.

> 🆓 **ฟรี / Free** · FiveM script by **[X3D Developer](https://fivem.x3d-developer.com)** — ESX & Standalone
> 🌐 หน้าสินค้า / Product page: **https://fivem.x3d-developer.com/th/products/x3d-environment/**
> 💬 Discord: **https://discord.gg/x3d-developer**
> ⭐ ชอบไหม? ดูสคริปอื่น ๆ (ฟรี + พรีเมียม) ที่ **[fivem.x3d-developer.com](https://fivem.x3d-developer.com)**

---

# x3d_environment — ล้างแมพให้สะอาด (ฟรี)

ลบคราบเลือด ลอยยาง รอยกระสุนบนพื้น · ล้างคราบเลือดกับรอยแผลบนตัวผู้เล่น · ปิด NPC รถ AI และ scenario ทั้งแมพ · ปิดกล้อง idle ที่หมุนเองตอนยืนนิ่ง

ไฟล์เดียว ไม่มี UI ไม่มีฐานข้อมูล **ไม่ต้องลงอะไรเพิ่ม** ใช้ได้ทั้ง ESX, QBCore, standalone

โดย [X3D-Developer](https://x3d-developer.com) · ช่วยเหลือ: discord.gg/x3d-developer

---

## 5 โมดูล เปิดปิดแยกกันได้

| โมดูล | ทำอะไร |
|---|---|
| `Config.Population` | ไม่ให้เกมสร้าง NPC / รถ AI / รถจอด / ตำรวจ AI / เรือ / รถขยะ และลบตัวที่เกิดไปแล้วทิ้ง |
| `Config.Scenarios` | ปิด scenario ของรถทั้งแมพ (รถ AI จอดรอ, ตำรวจขับตรวจ, เครื่องบินทหาร) |
| `Config.IdleCam` | ปิดกล้องที่หมุนเองตอนยืนนิ่ง ทั้งตอนเดินและตอนอยู่ในรถ |
| `Config.Body` | ล้างคราบเลือด รอยแผล ฝุ่น และความเปียก บนตัวผู้เล่น (ของตัวเองและที่เห็นคนอื่น) |
| `Config.Decals` | ล้างคราบบนพื้นรอบตัว — เลือดตกพื้น ลอยยาง รอยกระสุน คราบน้ำมัน |

ปิดโมดูลไหน โค้ดส่วนนั้นไม่ถูกสร้างเป็น thread เลย ไม่กินรอบ CPU

## ติดตั้ง

1. วางโฟลเดอร์ `x3d_environment` ใน `resources/`
2. เพิ่มใน `server.cfg`:

```
ensure x3d_environment
```

เสร็จแล้ว · เปิดเข้าเกม กด F8 จะเห็นบรรทัดสรุปว่าโมดูลไหนทำงานอยู่

## วิธีประหยัด CPU ที่ดีกว่า (แนะนำ)

การสั่ง "ห้ามสร้าง NPC" ต้องสั่งทุกเฟรม เป็นข้อจำกัดของ GTA ไม่ใช่บั๊กของสคริปต์ ถ้าอยากได้ฟรีจริง ๆ ให้สั่งที่ต้นทางแทน — ใส่ใน `server.cfg`:

```
setr onesync_population false
```

เซิร์ฟเวอร์จะไม่สร้าง NPC และรถ AI ตั้งแต่ต้น แล้วค่อยปิด loop ใน `config.lua`:

```lua
Config.Population.densityLoop = false
Config.Population.sweep = false
```

โมดูลอื่น (คราบ, scenario, idlecam) ยังทำงานตามปกติ

## ตั้งค่าที่ใช้บ่อย

แก้ที่ `config.lua` ทั้งหมด ทุกบรรทัดมีคำอธิบายภาษาไทย

```lua
-- อยากให้มีคนเดินถนนบ้าง แต่ไม่เอารถ
Config.Population.ped     = 0.3
Config.Population.vehicle = 0.0

-- อยากเก็บคราบเลือดไว้ให้ RP แต่ล้างรอยแผลบนตัว
Config.Body.blood  = false
Config.Body.damage = true

-- ล้างพื้นถี่ขึ้นและกว้างขึ้น
Config.Decals.interval = 2000
Config.Decals.radius   = 150.0
```

## ⚠ scenario ของคน — ปิดไว้โดยตั้งใจ

`Config.Scenarios.human` ค่าเริ่มต้นคือ `false`

`SetScenarioTypeEnabled` ปิด scenario ทั้งเกม ไม่ได้ปิดเฉพาะ NPC ของเกม — resource อื่นที่สั่ง `TaskStartScenarioInPlace` ให้ NPC ของตัวเอง (NPC ร้านค้า, NPC อาชีพ, NPC ธนาคาร) จะยืนเฉย ๆ ท่าหายหมด

คนเดินถนนของเกมถูกกำจัดด้วย `scenarioInterior` / `scenarioExterior` = `0.0` กับตัว sweep อยู่แล้ว **ไม่ต้องเปิดอันนี้** เปิดก็ต่อเมื่อเซิร์ฟเวอร์ไม่มี NPC ที่ใช้ scenario เลย

## NPC ของ resource อื่นปลอดภัยแน่นอน

ตัว sweep ลบเฉพาะสิ่งที่ **เกม** สร้าง โดยเช็ก `GetEntityPopulationType` ว่าอยู่ในช่วง 1–5 (population ของ engine)

NPC ที่สคริปต์สร้างเป็น type 6 (permanent) หรือ 7 (mission) จึงไม่โดนแตะ · รถของผู้เล่นและรถที่มีผู้เล่นนั่งอยู่มีการเช็กซ้ำอีกชั้น

มีชุดทดสอบยืนยันข้อนี้ 31 เคส:

```bash
pip install lupa
python tools/lua-test/x3d_environment_check.py
```

## เรียกจาก resource อื่น

ปิดโมดูลชั่วคราว (เช่น ตอนทำ cutscene หรือภารกิจที่ต้องมี NPC) แล้วเปิดคืน โดยไม่ต้องรีสตาร์ท

```lua
exports['x3d_environment']:SetEnabled('population', false)
-- ... ทำสิ่งที่ต้องการ ...
exports['x3d_environment']:SetEnabled('population', true)

exports['x3d_environment']:IsEnabled('decals')   --> true / false
```

ชื่อโมดูล: `population` · `scenarios` · `idlecam` · `body` · `decals`

## ข้อควรรู้

| เรื่อง | รายละเอียด |
|---|---|
| `Config.Decals` ล้างทุกคราบในรัศมี | รวมถึงคราบที่ resource อื่นตั้งใจวางไว้ (สเปรย์กราฟฟิตี้, เลือดเป็นหลักฐานให้ตำรวจ) — ถ้าเซิร์ฟใช้ระบบพวกนี้ ให้ปิด `Config.Decals.enabled` |
| `Config.Body.otherPlayers` | ล้างในเครื่องเราเท่านั้น ไม่ได้ไปแก้ตัวละครคนอื่นจริง ๆ ต่างคนต่างเห็นของตัวเอง |
| OneSync Infinity | ถ้า `onesync_population` เป็น `true` NPC เป็น entity ของเซิร์ฟเวอร์ ลบฝั่ง client อาจไม่ติดทุกตัว — ใช้วิธี `onesync_population false` ด้านบนจะชัวร์กว่า |
| ใช้คู่กับ ESX | ESX มีการตั้งค่า population ของตัวเองใน `Config.Multipliers` — ตั้งให้ตรงกันไม่งั้นสองระบบสั่งสวนกันทุกเฟรม |

## ลิขสิทธิ์

ฟรี · ใช้ได้ทุกเซิร์ฟเวอร์ · แก้โค้ดได้ตามใจ

ขอแค่ **อย่านำไปขายต่อ** และอย่าอัปโหลดใหม่ในชื่อตัวเอง — เก็บเครดิตใน `fxmanifest.lua` ไว้พอ

ชอบของเรา? ดูสคริปต์ตัวอื่นได้ที่ [x3d-developer.com](https://x3d-developer.com)

---

### License / ลิขสิทธิ์
ฟรีสำหรับใช้ในเซิร์ฟเวอร์ของคุณ · **ห้ามขายต่อ / แจกจ่ายเพื่อการค้า** · © X3D Developer
Free to use on your own server · **no reselling / commercial redistribution** · © X3D Developer
