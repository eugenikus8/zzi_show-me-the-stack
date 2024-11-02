-- Show stack size
local function find_localised_name(name)
	for raw_name, items in pairs(data.raw) do
	if raw_name ~= "item" and raw_name ~= "recipe" and raw_name ~= "technology" and items[name] then
		local item = items[name]
		if item and not item.place_result and not item.placed_as_equipment_result and not item.stack_size then
		return item.localised_name
		end
	end
	end
end

local function show_stack_size(item)
	if not item or not item.stack_size or item.stack_size < 1 then return end
	local localised_name = item.localised_name
	if not localised_name or type(localised_name) ~= "table" or type(localised_name[1]) ~= "string" then
		local name = item.place_result or item.placed_as_equipment_result or item.name
		local prefix = item.place_result and "entity" or (item.placed_as_equipment_result or name:find("equipment")) and "equipment" or "item"
		localised_name = find_localised_name(name) or { prefix .. "-name." .. name }
	end
	item.localised_name = { "stack-size.name", tostring(item.stack_size), localised_name }
end

for _, items in pairs(data.raw) do
	for _, item in pairs(items) do
		show_stack_size(item)
	end
end


-- Uniform recipe
for _,r in pairs(data.raw["recipe"]) do
	r.always_show_products=true;
	r.show_amount_in_title=false;
	if r.normal ~= nil then
  		r.normal.always_show_products = true;
  		r.normal.show_amount_in_title = false;
	end
	if r.expensive ~= nil then
 	 	r.expensive.always_show_products = true;
  		r.expensive.show_amount_in_title = false;
	end
end