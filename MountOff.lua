local allMountsTotal = C_MountJournal.GetNumMounts() -- all
local dropMountsTotal = C_MountJournal.GetNumMounts(1) -- 1 = Drop
local questMountsTotal = C_MountJournal.GetNumMounts(2) -- 2 = Quest
local vendorMountsTotal = C_MountJournal.GetNumMounts(3) -- 3 = Vendor
local professionMountsTotal = C_MountJournal.GetNumMounts(4) -- 4 = Profession
local petBattleMountsTotal = C_MountJournal.GetNumMounts(5) -- 5 = Pet Battles
local achievMountsTotal = C_MountJournal.GetNumMounts(6) -- 6 = Achievements
local eventMountsTotal = C_MountJournal.GetNumMounts(7) -- 7 = World Events
local promotionMountsTotal = C_MountJournal.GetNumMounts(8) -- 8 = Promotional
local tcgMountsTotal = C_MountJournal.GetNumMounts(9) -- 9 = TCG
local shopMountsTotal = C_MountJournal.GetNumMounts(10) -- 10 = Ingame Store

local function whatsMyName(...)
    local name, realm = UnitName("player")
    print("your name is " .. name)
    
    local a = select(2, ...)
    print("second number is " .. a)

    local tbl = {...}
    print("there are " .. #tbl .. " numbers")
end

local player = {
    name = UnitName("player"),
    level = UnitLevel("player"),
    class = UnitClass("player"),
}

print(player.name .. " lvl " .. player.level .. " " .. player.class)
if (IsMounted()) then
    print(" is mounted")
else
    print(" is not mounted")
end

-- put all mounts with relevant data into table indexed according to mountID
local mountIDs = C_MountJournal.GetMountIDs()
local mounts = {}
function generateMountData()
    for i=1,#mountIDs do
        local idx = mountIDs[i]
        mounts[idx] = {
            name,
            spellid,
            icon,
            source,
            faction,
        }
        mounts[idx].name, mounts[idx].spellid, mounts[idx].icon, _, _, mounts[idx].source, _, _, mounts[idx].faction = C_MountJournal.GetMountInfoByID(idx);
        --print ("name: " .. mounts[idx].name)
    end
end

generateMountData()

local randoMount = mounts[mountIDs[math.random(1, allMountsTotal)]]
print(("random mount: %s"):format(randoMount.name))
--yak mount spellid = 122708

local onit = false
-- check all buffs on player
for i=1,40 do
    local bname, bicon, bcount, _, _, _, bsource, _, _, bid = UnitBuff("player",i,"PLAYER|CANCELABLE")
    if (bid and bid == randoMount.spellid) then
        onit = true
        break
    end
end

if (onit) then
    print("you're on the mount, congrats!!!!!!!!!!!!!")
else
    print("you're not on the mount!!!!!!!!!!!")
end

-- Call this function to iterate through each raid member and check if they have the chosen mount buff
local function CheckRaidForMount(randoMount)
    print("ARE YOU ON " .. randoMount.name .. "????")
    for i = 1, 40 do -- For each raid member
        local unit = "raid" .. i
        local onit = false
        if UnitExists(unit) then-- and not UnitIsUnit(unit, "player") then -- If this raid member exists and isn't the player
            for i=1,40 do
                local bname, bicon, bcount, _, _, _, bsource, _, _, bid = UnitBuff("player",i,"PLAYER|CANCELABLE")
                if (bid and bid == randoMount.spellid) then
                    onit = true
                    break
                end
            end
            
            if (onit) then
                print("you're on the mount, congrats")
            else
                print("you're not on the mount")
            end
        end
    end
end

CheckRaidForMount(randoMount)