local jiewei = fk.CreateSkill {
  name = "pang__jiewei",
}

Fk:loadTranslationTable{
  ["pang__jiewei"] = "解围",
  [":pang__jiewei"] = "每回合限一次，当你造成或受到伤害后，你可以和对手交换手牌；本回合结束时，你再次和对手交换手牌。",
  ["@@pang__jiewei"] = "解围",


  ["$pang__jiewei1"] = "同袍之谊，断不可弃之！",
  ["$pang__jiewei2"] = "贼虽势盛，若吾出马，亦可解之。",
}

local spec = {
  anim_type = "masochism",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(jiewei.name) and player:usedSkillTimes(jiewei.name, Player.HistoryTurn) == 0
  end,
  on_use = function (self, event, target, player, data)
    local room = player.room
    local to = player.next
    room:setPlayerMark(player,"@@pang__jiewei", 1)
    room:swapAllCards(player, {player, to}, jiewei.name, "h")
  end,
}

jiewei:addEffect(fk.Damage, spec)
jiewei:addEffect(fk.Damaged, spec)

jiewei:addEffect(fk.TurnEnd, {
    is_delay_effect = true,
    anim_type = "offensive", 
    can_refresh = function(self, event, target, player, data)
        return player:getMark("@@pang__jiewei") > 0
  end,
  on_refresh = function(self, event, target, player, data)
    local room = player.room
    local to = player.next
    room:swapAllCards(player, {player, to}, jiewei.name, "h")
    room:setPlayerMark(player,"@@pang__jiewei", 0)
end,
})

return jiewei