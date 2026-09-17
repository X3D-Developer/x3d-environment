# X3D Environment

**TH:** ล้างแมพ FiveM ให้สะอาด — ปิด NPC / รถ AI / scenario / กล้อง idle, ล้างคราบเลือด-ลอยยาง-รอยกระสุน, เพิ่ม FPS. ไฟล์เดียว
**EN:** Clean the FiveM map — disable NPCs / AI traffic / scenarios / idle camera, clear blood-tyre-bullet decals, boost FPS. Single file.

> 🆓 **ฟรี / Free** · FiveM script by **[X3D Developer](https://fivem.x3d-developer.com)** — ESX & Standalone
> 🌐 หน้าสินค้า / Product page: **https://fivem.x3d-developer.com/th/products/x3d-environment/**
> 💬 Discord: **https://discord.gg/x3d-developer** · ⭐ สคริปอื่น ๆ (ฟรี + พรีเมียม) ที่ **[fivem.x3d-developer.com](https://fivem.x3d-developer.com)**

---

## 🇹🇭 ภาษาไทย

### คุณสมบัติ
- ปิด **NPC / รถ AI / scenario / กล้อง idle** ทั้งแมพ
- ล้าง **คราบเลือด ลอยยาง รอยกระสุนบนพื้น รอยแผลบนตัวผู้เล่น**
- **5 โมดูล** เปิด/ปิดแยกกันได้ใน `config.lua`
- **ไฟล์เดียว** ไม่ต้องลงอะไรเพิ่ม
- `exports` ปิดโมดูลชั่วคราวจากสคริปอื่นได้
- NPC ของสคริปอื่นไม่โดนลบ (ทดสอบ 31 เคส)

### ติดตั้ง
1. วางโฟลเดอร์ `x3d-environment` ใน `resources/`
2. ใส่ `ensure x3d-environment` ใน `server.cfg`
3. ปรับค่าใน `config.lua` (แต่ละโมดูลเปิด/ปิดได้)
4. อยากให้เซิร์ฟไม่สร้าง NPC ตั้งแต่ต้น: `set onesync_population false` + `densityLoop = false`

---

## 🇬🇧 English

### Features
- Disable **NPCs / AI traffic / scenarios / idle camera** across the map
- Clear **blood stains, tyre marks, bullet decals, player wounds**
- **5 modules**, each independently toggleable in `config.lua`
- **Single file**, no dependencies
- `exports` to pause a module from another script
- Other scripts' NPCs are never swept (31 test cases)

### Install
1. Put the `x3d-environment` folder in `resources/`
2. Add `ensure x3d-environment` to `server.cfg`
3. Configure in `config.lua` (toggle each module)
4. To stop the server spawning NPCs at all: `set onesync_population false` + `densityLoop = false`

---

### License / ลิขสิทธิ์
ฟรีสำหรับใช้ในเซิร์ฟเวอร์ของคุณ · **ห้ามขายต่อ / แจกจ่ายเพื่อการค้า** · © X3D Developer
Free to use on your own server · **no reselling / commercial redistribution** · © X3D Developer
