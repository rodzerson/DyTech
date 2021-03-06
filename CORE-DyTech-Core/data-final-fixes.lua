require "config"
require "prototypes.intermediates.intermediates"

TechFix = true
ItemFix = false
Fast_Replace_Fix = true

for i, drill in pairs(data.raw["mining-drill"]) do
	if not drill.storage_slots then 
		drill.storage_slots = 6 
	else
		drill.storage_slots = 6 
	end
end

if Config.Infinite_Resources then
	for k, v in pairs(data.raw.resource) do
		v.infinite = true
		v.minimum = 175
		v.normal = 350
	end
end 

if Config.Super_Size_Resources and Config.Infinite_Resources then
	for k, v in pairs(data.raw.resource) do
		v.minimum = 17500
		v.normal = 35000
		v.autoplace.richness_base = Config.Super_Size_Resources_Size
	end
elseif Config.Super_Size_Resources and not Config.Infinite_Resources then
	for k, v in pairs(data.raw.resource) do
		v.autoplace.richness_base = Config.Super_Size_Resources_Size
	end
end

if Config.Resource_Easier_To_Mine then
	for k, v in pairs(data.raw.resource) do
		v.minable.hardness = 0.1
		v.minable.mining_time = 0.1
	end
end

if Config.Technology_Use_Less_Science_Packs then
	for k, v in pairs(data.raw.technology) do
    local TechCount = v.unit.count
		TechCount = ((TechCount+1)-TechCount)
		v.unit.count = TechCount
	end
end

if Config.Technology_Takes_Less_Time then
	for k, v in pairs(data.raw.technology) do
    local TechTime = v.unit.time
		TechTime = ((TechTime+1)-TechTime)
		v.unit.time = TechTime
	end
end

if Config.All_Recipes_Unlocked_From_Start then
	for k, v in pairs(data.raw.recipe) do
		if not v.enabled then
			v.enabled = true
		elseif v.enabled == "false" then
			v.enabled = "true"
		end
	end
end

if Config.Science_Packs_Last_Long then
	data.raw["tool"]["science-pack-1"].durability = 2500
	data.raw["tool"]["science-pack-2"].durability = 2500
	data.raw["tool"]["science-pack-3"].durability = 2500
	data.raw["tool"]["alien-science-pack"].durability = 2500
end

if Config.Stacksize_Increase then
	for k, v in pairs(data.raw.item) do
		v.default_request_amount = v.stack_size
		v.stack_size = (v.stack_size*Config.Stacksize_Increase_Factor)
	end
	for k, v in pairs(data.raw.ammo) do
		v.default_request_amount = v.stack_size
		v.stack_size = (v.stack_size*Config.Stacksize_Increase_Factor)
	end
	for k, v in pairs(data.raw.gun) do
		v.default_request_amount = v.stack_size
		v.stack_size = (v.stack_size*Config.Stacksize_Increase_Factor)
	end
	for k, v in pairs(data.raw["repair-tool"]) do
		v.default_request_amount = v.stack_size
		v.stack_size = (v.stack_size*Config.Stacksize_Increase_Factor)
	end
	for k, v in pairs(data.raw["mining-tool"]) do
		v.default_request_amount = v.stack_size
		v.stack_size = (v.stack_size*Config.Stacksize_Increase_Factor)
	end
	for k, v in pairs(data.raw.tool) do
		v.default_request_amount = v.stack_size
		v.stack_size = (v.stack_size*Config.Stacksize_Increase_Factor)
	end
	for k, v in pairs(data.raw["capsule"]) do
		v.default_request_amount = v.stack_size
		v.stack_size = (v.stack_size*Config.Stacksize_Increase_Factor)
	end
	for k, v in pairs(data.raw["module"]) do
		v.default_request_amount = v.stack_size
		v.stack_size = (v.stack_size*Config.Stacksize_Increase_Factor)
	end
end

if Config.Ammo_Has_Large_Magazine then
	for k, v in pairs(data.raw.ammo) do
		if not v.magazine_size then
			v.magazine_size = 1000
		else
			v.magazine_size = v.magazine_size*1000
		end
	end
end

if Config.Tools_Have_Large_Durability then
	for k, v in pairs(data.raw["mining-tool"]) do
		v.durability = v.durability*1000
	end
end

for k, v in pairs(data.raw.module) do
	if string.sub("productivity-module-", 1, 20) and v.limitation then
		for index,name in pairs(INTERMEDIATES) do
			if data.raw.recipe[name.Name] then
				table.insert(v.limitation, name.Name)
			end
		end
	end
end

if TechFix then
	for k, v in pairs(data.raw.technology) do
		if not v.upgrade then
			v.upgrade = true
		elseif v.upgrade == "false" then
			v.upgrade = "true"
		end
		v.order = v.name
	end
end 

if ItemFix then
	for k, v in pairs(data.raw.item) do
		v.order = v.name
	end
	for k, v in pairs(data.raw.ammo) do
		v.order = v.name
	end
	for k, v in pairs(data.raw.gun) do
		v.order = v.name
	end
	for k, v in pairs(data.raw["repair-tool"]) do
		v.order = v.name
	end
	for k, v in pairs(data.raw["mining-tool"]) do
		v.order = v.name
	end
	for k, v in pairs(data.raw.tool) do
		v.order = v.name
	end
	for k, v in pairs(data.raw["capsule"]) do
		v.order = v.name
	end
	for k, v in pairs(data.raw["module"]) do
		v.order = v.name
	end
end 

if Fast_Replace_Fix then
	for k, v in pairs(data.raw["inserter"]) do
		v.fast_replaceable_group = "inserter"
		v.collision_box = {{-0.15, -0.15}, {0.15, 0.15}}
		v.selection_box = {{-0.4, -0.35}, {0.4, 0.45}}
	end
end