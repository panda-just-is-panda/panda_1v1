local tongqu = fk.CreateSkill {
  name = "pang__tongqu",
}

Fk:loadTranslationTable{
  ["pang__tongqu"] = "通渠",
  [":pang__tongqu"] = "你可以将所有非本回合获得的手牌作为【无中生有】使用。",
  ["#pang__tongqu"] = "通渠：你可以将所有非本回合获得的手牌作为【无中生有】使用。",

  ["@@pang__tongqu-inhand-turn"] = "通渠",

  ["$pang__tongqu1"] = "兴凿修渠，依水屯军！",
  ["$pang__tongqu2"] = "开渠疏道，以备军实！",
}

tongqu:addEffect(fk.AfterCardsMove, {
  can_refresh = function(self, event, target, player, data)
    return player:hasSkill(tongqu.name, true)
  end,
  on_refresh = function(self, event, target, player, data)
    local room = player.room
    for _, move in ipairs(data) do
      if move.to == player and move.toArea == Player.Hand then
        for _, info in ipairs(move.moveInfo) do
          if table.contains(player:getCardIds("h"), info.cardId) then
            room:setCardMark(Fk:getCardById(info.cardId), "@@pang__tongqu-inhand-turn", 1)
          end
        end
      end
    end
  end,
})

tongqu:addEffect("viewas", {
  anim_type = "drawcard",
  pattern = "ex_nihilo",
  prompt = "#pang__tongqu",
  handly_pile = true,
  filter_pattern = function (self, player, card_name)
    local cards = table.filter(player:getCardIds("h"), function(id)
      local card_id = Fk:getCardById(id)
      return card_id and card_id:getMark("@@pang__tongqu-inhand-turn") == 0
    end)
    return {
      max_num = #cards,
      min_num = math.max(#cards, 1),
      pattern = tostring(Exppattern{ id = cards }),
      subcards = cards
    }
  end,
  view_as = function(self, player, cards)
    if #cards < 1 then return end
    local c = Fk:cloneCard("ex_nihilo")
    c.skillName = tongqu.name
    c:addSubcard(cards)
    return c
  end,
  enabled_at_play = function(self, player)
    return true
  end,
  enabled_at_response = function(self, player, response)
    return not response
  end,
})


return tongqu