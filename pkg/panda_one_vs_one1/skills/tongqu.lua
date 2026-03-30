local tongqu = fk.CreateSkill {
  name = "pang__tongqu",
}

Fk:loadTranslationTable{
  ["pang__tongqu"] = "通渠",
  [":pang__tongqu"] = "出牌阶段，你可以弃置三张牌，然后你的摸牌阶段摸牌数+1（至多为5）。",
  ["#pang__tongqu"] = "通渠：你可以弃置三张牌，然后你的摸牌阶段摸牌数+1",
  ["@tongqu_count"] = "通渠",

  ["$pang__tongqu1"] = "兴凿修渠，依水屯军！",
  ["$pang__tongqu2"] = "开渠疏道，以备军实！",
}


tongqu:addEffect("active", {
  anim_type = "control",
  prompt = "#pang__tongqu",
  max_phase_use_time = 3,
  card_num = 3,
  target_num = 0,
  can_use = function(self, player)
    return player:getMark("@tongqu_count") < 3
  end,
  card_filter = function(self, player, to_select, selected)
    return #selected < 3 and not player:prohibitDiscard(to_select)
  end,
  target_filter = Util.FalseFunc,
  on_use = function(self, room, effect)
    local player = effect.from
    room:throwCard(effect.cards, tongqu.name, player, player)
    room:addPlayerMark(player,"@tongqu_count", 1)
    room:addPlayerMark(player,"tongqu_hidden_count", 1)
  end,
})

tongqu:addEffect(fk.DrawNCards, {
  anim_type = "drawcard",
  can_refresh = function(self, event, target, player, data)
    return target == player and player:hasSkill(tongqu.name) and
    player:getMark("@tongqu_count") > 0
  end,
  on_refresh = function(self, event, target, player, data)
    local X = player:getMark("@tongqu_count")
    data.n = data.n + X
  end,
})

tongqu:addLoseEffect(function (self, player, is_death)
  local room = player.room
  room:setPlayerMark(player,"@tongqu_count",0)
end)

tongqu:addAcquireEffect(function (self, player)
  local room = player.room
  local X = player:getMark("tongqu_hidden_count")
  if X > 0 then
    room:setPlayerMark(player,"@tongqu_count",X)
  end
end)


return tongqu