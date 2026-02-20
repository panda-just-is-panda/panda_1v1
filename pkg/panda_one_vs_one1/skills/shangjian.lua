local shangjian = fk.CreateSkill {
  name = "pang__shangjian",
}

Fk:loadTranslationTable{
  ["pang__shangjian"] = "尚俭",
  [":pang__shangjian"] = "每轮结束时，你可以获得本轮因弃置进入弃牌堆的一张牌，然后对手也可以如此做。",

  ["#pang__shangjian"] = "尚俭：你可以获得本轮因弃置进入弃牌堆的一张牌",
  ["#pang__shangjian_get"] = "尚俭：获得本轮因弃置进入弃牌堆的一张牌",



  ["$pang__shangjian1"] = "如今乱世，当秉俭行之节。",
  ["$pang__shangjian2"] = "百姓尚处寒饥之困，吾等不可奢费财力。",
}


shangjian:addEffect(fk.RoundEnd,{
    anim_type = "support",
  can_trigger = function (self, event, target, player, data)
    if player:hasSkill(shangjian.name) then
        local room = player.room
        local cards = {}
        local shangjian_all = {}
        room.logic:getEventsByRule(GameEvent.MoveCards, 1, function (e)
        for _, move in ipairs(e.data) do
          for _, info in ipairs(move.moveInfo) do
            local id = info.cardId
            if not table.contains(cards, id) then
              table.insert(cards, id)
              if move.toArea == Card.DiscardPile and move.moveReason == fk.ReasonDiscard and
                room:getCardArea(id) == Card.DiscardPile then
                table.insert(shangjian_all, id)
              end
            end
          end
        end
        return false
      end, nil, Player.HistoryRound)
      if #shangjian_all > 0 then
        event:setCostData(self, {extra_data = {shangjian_all}})
        return true
      end
    end
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    if room:askToSkillInvoke(player, {
      skill_name = shangjian.name,
      prompt = "#pang__shangjian",
    }) then
      event:setCostData(self, {extra_data = event:getCostData(self).extra_data})
      return true
    end
  end,
  on_use = function (self, event, target, player, data)
    local room = player.room
    local shangjian_all = event:getCostData(self).extra_data[1]
    local player_get = room:askToChooseCards(player, {
          pattern = tostring(Exppattern{ id = shangjian_all }),
          min = 1,
          max = 1,
          skill_name = shangjian.name,
          prompt = "#pang__shangjian_get",
        })
    local moveInfos = {}
    table.insert(moveInfos, {
      ids = player_get,
      to = player,
      toArea = Card.PlayerHand,
      moveReason = fk.ReasonJustMove,
      proposer = player,
      skillName = shangjian.name,
    })
    table.removeOne(shangjian_all, player_get[1])
    if #shangjian_all > 0 and room:askToSkillInvoke(player.next, {
      skill_name = shangjian.name,
      prompt = "#pang__shangjian",
    }) then
        local to_get = room:askToChooseCards(player.next, {
          pattern = tostring(Exppattern{ id = shangjian_all }),
          min = 1,
          max = 1,
          skill_name = shangjian.name,
          prompt = "#pang__shangjian_get",
        })
        local moveInfos = {}
        table.insert(moveInfos, {
            ids = to_get,
            to = player.next,
            toArea = Card.PlayerHand,
            moveReason = fk.ReasonJustMove,
            proposer = player,
            skillName = shangjian.name,
        })
    end
    room:moveCards(table.unpack(moveInfos))
  end,
})


return shangjian