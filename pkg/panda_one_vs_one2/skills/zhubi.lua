local zhubi = fk.CreateSkill {
  name = "pang__zhubi",
}

Fk:loadTranslationTable{
  ["pang__zhubi"] = "铸币",
  [":pang__zhubi"] = "你可以将所有不为本回合获得的手牌作为【无中生有】使用。",
  ["#pang__zhubi"] = "铸币：你可以将所有非本回合获得的手牌作为【无中生有】使用。",

  ["@@pang__zhubi-inhand-turn"] = "本回合获得",

  ["$pang__zhubi1"] = "铸币",
  ["$pang__zhubi2"] = "铸币",
}

zhubi:addEffect(fk.AfterCardsMove, {
  can_refresh = function(self, event, target, player, data)
    return player:hasSkill(zhubi.name, true)
  end,
  on_refresh = function(self, event, target, player, data)
    local room = player.room
    for _, move in ipairs(data) do
      if move.to == player and move.toArea == Player.Hand then
        for _, info in ipairs(move.moveInfo) do
          if table.contains(player:getCardIds("h"), info.cardId) then
            room:setCardMark(Fk:getCardById(info.cardId), "@@pang__zhubi-inhand-turn", 1)
          end
        end
      end
    end
  end,
})

zhubi:addEffect("viewas", {
  anim_type = "drawcard",
  pattern = "ex_nihilo",
  prompt = "#pang__zhubi",
  handly_pile = true,
  filter_pattern = function (self, player, card_name, selected)
    local cards = table.filter(player:getCardIds("h"), function(id)
      local card_id = Fk:getCardById(id)
      return card_id and card_id:getMark("@@pang__zhubi-inhand-turn") == 0
    end)
    if #cards > 0 then
      return {
        max_num = #cards,
        min_num = #cards,
        pattern = ".|.|.|hand",
        subcards = cards
      }
    end
  end,
  card_filter = Util.FalseFunc,
  view_as = function(self, player, cards)
    local cards2 = table.filter(player:getCardIds("h"), function(id)
      local card_id = Fk:getCardById(id)
      return card_id and card_id:getMark("@@pang__zhubi-inhand-turn") == 0
    end)
    if #cards2 < 1 then return end
    local c = Fk:cloneCard("ex_nihilo")
    c.skillName = zhubi.name
    c:addSubcards(cards2)
    return c
  end,
  enabled_at_play = function(self, player)
    local cards = table.filter(player:getCardIds("h"), function(id)
    local card_id = Fk:getCardById(id)
      return card_id and card_id:getMark("@@pang__zhubi-inhand-turn") == 0
    end)
    return #cards > 0
  end,
  enabled_at_response = function(self, player, response)
    local cards = table.filter(player:getCardIds("h"), function(id)
    local card_id = Fk:getCardById(id)
      return card_id and card_id:getMark("@@pang__zhubi-inhand-turn") == 0
    end)
    return not response and #cards > 0
  end,
})


return zhubi