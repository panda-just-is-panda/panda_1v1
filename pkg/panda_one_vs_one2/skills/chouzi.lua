local chouzi = fk.CreateSkill {
  name = "pang__chouzi&",
  tags = {"kSupport"}
}

Fk:loadTranslationTable{
  ["pang__chouzi&"] = "筹资",
  [":pang__chouzi&"] = "备场技，每局限三次，你可以跳过出牌阶段，然后亮出牌堆顶的三张牌并获得其中一张。",
  ["#chouzi_get"] = "筹资：选择其中一张牌获得",
  ["@chouzi_used"] = "筹资",
  ["#pang__chouzi"] = "筹资：你可以跳过出牌阶段，亮出牌堆顶三张牌并获得其中一张",

  ["$pang__chouzi&1"] = "区区薄礼，万望使君笑纳。",
  ["$pang__chouzi&2"] = "雪中送炭，以解君愁。",
}


chouzi:addEffect(fk.EventPhaseChanging, {
  anim_type = "support",
  audio_index = 1,
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(chouzi.name) and data.phase == Player.Play and not data.skipped
    and player:getMark("@chouzi_used") < 3
  end,
  on_cost = function (self, event, target, player, data)
    return player.room:askToSkillInvoke(player,{
        prompt = "#pang__chouzi",
        skill_name = chouzi.name,
        })
    end,
  on_use = function (self, event, target, player, data)
    local room = player.room
    data.skipped = true
    local cards = room:getNCards(3)
    room:turnOverCardsFromDrawPile(player, cards, chouzi.name, false)
    local card = room:askToChooseCard(player, {
        target = player,
        flag = { card_data = {{ "Top", cards }} },
        skill_name = chouzi.name,
        prompt = "#chouzi_get",
      })
    room:obtainCard(player, card, false, fk.ReasonJustMove, player, chouzi.name)
    room:cleanProcessingArea(cards)
    room:addPlayerMark(player, "@chouzi_used", 1)
  end,
})

chouzi:addAcquireEffect(function (self, player)
  local room = player.room
  if player:usedSkillTimes(chouzi.name, Player.HistoryGame) > 0 then
    room:setPlayerMark(player, "@chouzi_used", player:usedSkillTimes(chouzi.name, Player.HistoryGame))
  end
end)

chouzi:addLoseEffect(function (self, player, is_death)
  local room = player.room
  room:setPlayerMark(player,"@chouzi_used",0)
end)

return chouzi