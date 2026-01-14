local saying = fk.CreateSkill {
  name = "pang__saying",
}

Fk:loadTranslationTable{
  ["pang__saying"] = "飒影",
  [":pang__saying"] = "当你需要使用【杀】时，你可以和对手交换装备区内的牌，然后若你装备区内的牌数因此：减少，你摸两张牌；不变，你视为使用之；增加，你失去此技能。",

  ["#pang__saying1"] = "飒影：你可以和对手交换装备区内的牌，然后摸两张牌",
  ["#pang__saying2"] = "飒影：你可以和对手交换装备区内的牌，然后视为使用【杀】",
  ["#pang__saying3"] = "飒影：你可以和对手交换装备区内的牌，然后失去此技能",

  ["$pang__saying1"] = "倩影映江汀，巾帼犹飒爽！",
  ["$pang__saying2"] = "我有一袭红袖，欲揾英雄泪！"
}

saying:addEffect("viewas", {
  pattern = "slash",
  prompt = function (self, player)
    local to = player.next
    if #player:getCardIds("e") < #to:getCardIds("e") then
        return "#pang__saying3"
    elseif #player:getCardIds("e") == #to:getCardIds("e") then
        return "#pang__saying2"
    elseif #player:getCardIds("e") > #to:getCardIds("e") then
        return "#pang__saying1"
    end
  end,
  card_filter = Util.FalseFunc,
  view_as = function(self, player, cards)
    local card = Fk:cloneCard("slash")
    card.skillName = saying.name
    return card
  end,
  before_use = function(self, player, use)
    local room = player.room
    local to = player.next
    local effect_to = {player, to}
    room:swapAllCards(player, effect_to, saying.name, "e")
    if #player:getCardIds("e") < #to:getCardIds("e") then
        player:drawCards(2, saying.name)
        return saying.name
    elseif #player:getCardIds("e") > #to:getCardIds("e") then
        room:handleAddLoseSkills(player, "-pang__saying", nil, false, true)
        return saying.name
    end
  end,
  enabled_at_play = function(self, player)
    return true
  end,
  enabled_at_response = function(self, player, response)
    return not response
  end,
})

return saying