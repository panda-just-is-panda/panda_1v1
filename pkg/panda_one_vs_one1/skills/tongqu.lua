local tongqu = fk.CreateSkill {
  name = "pang__tongqu",
}

Fk:loadTranslationTable{
  ["pang__tongqu"] = "通渠",
  [":pang__tongqu"] = "每回合结束时，你可以重铸一张牌，然后若你最后四张因此重铸的牌点数递减，你摸一张牌。",
  ["#pang__tongqu"] = "通渠：你可以重铸一张牌",

  ["@pang__tongqu_numbers"] = "通渠",


  ["$pang__tongqu1"] = "兴凿修渠，依水屯军！",
  ["$pang__tongqu2"] = "开渠疏道，以备军实！",
}

tongqu:addEffect(fk.TurnEnd, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(tongqu.name) and not player:isNude()
  end,
  on_cost = function(self, event, target, player, data)
    local cards = player.room:askToCards(player, {
      min_num = 1,
      max_num = 1,
      include_equip = true,
      skill_name = tongqu.name,
      prompt = "#pang__tongqu",
      cancelable = true,
    })
    if #cards == 1 then
      event:setCostData(self, { cards = cards })
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local card_ids = event:getCostData(self).cards
    local card = Fk:getCardById(card_ids[1])
    local number = card.number
    room:recastCard(card_ids, player, tongqu.name)
    local numbers = player:getTableMark("@pang__tongqu_numbers") or {}
    table.insert(numbers, number)
    while #numbers > 4 do
      table.remove(numbers, 1)
    end
    room:setPlayerMark(player, "@pang__tongqu_numbers", numbers)
    if #numbers == 4 and numbers[1] > numbers[2] and numbers[2] > numbers[3] and numbers[3] > numbers[4] then
      player:drawCards(1, tongqu.name)
    end
  end,
})


return tongqu