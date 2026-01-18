local duoduan = fk.CreateSkill {
  name = "pang__duoduan",
}

Fk:loadTranslationTable{
  ["pang__duoduan"] = "度断",
  [":pang__duoduan"] = "你每回合首次造成伤害时，你观看牌堆顶的两张牌，然后你可以防止此伤害并获得这些牌。",
  ["#pang__duoduan"] = "度断：你可以防止此伤害并获得观看的牌",


  ["$pang__duoduan1"] = "奋笔墨为锄，茁大汉以壮、慷国士以慨。",
  ["$pang__duoduan2"] = "执金戈为尺，定国之方圆、立人之规矩。",
}

duoduan:addEffect(fk.DamageCaused, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(duoduan.name) and target == player 
    and player:getMark("duoduan_damage-turn") == 0
  end,
  on_cost = function (self, event, target, player, data)
    player.room:setPlayerMark(player, "duoduan_damage-turn", 1)
    player.room:viewCards(player, { cards = player.room:getNCards(2), skill_name = duoduan.name })
    return player.room:askToSkillInvoke(player,{
      prompt = "#pang__duoduan",
      skill_name = duoduan.name,
    })
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local get = room:getNCards(2)
    data:preventDamage()
    room:moveCardTo(get, Card.PlayerHand, player, fk.ReasonJustMove, duoduan.name, nil, true, player)
  end,
})

return duoduan