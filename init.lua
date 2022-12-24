minetest.register_on_joinplayer(function(player)
  player:set_nametag_attributes({
    color = {r=255, g=0, b=0}
  })
end)
local colors = {
  ["player1"] = {r=255, g=0, b=0},
  ["player2"] = {r=0, g=255, b=0},
  ["player3"] = {r=0, g=0, b=255},
}

minetest.register_on_joinplayer(function(player)
  local name = player:get_player_name()
  player:set_nametag_attributes({
    color = colors[name] or {r=255, g=255, b=255}
  })
end)

minetest.register_chatcommand("colored_names", {
  params = "[on/off]",
  description = "Toggles colored names on or off",
  func = function(name, param)
    if param == "on" then
      colored_names_enabled = true
      return true, "Colored names are now enabled"
    elseif param == "off" then
      colored_names_enabled = false
      return true, "Colored names are now disabled"
    else
      return false, "Invalid parameter. Use 'on' or 'off'"
    end
  end
})

local function get_player_color(player)
  local nametag_attributes = player:get_nametag_attributes()
  return nametag_attributes.color
end

local function colorize_text(color, text)
  local r, g, b = color.r, color.g, color.b
  return string.format("#%02x%02x%02x%s#FFFFFF", r, g, b, text)
end

minetest.register_on_chat_message(function(name, message)
  local player = minetest.get_player_by_name(name)
  local color = get_player_color(player)
  return colorize_text(color, message)
end)