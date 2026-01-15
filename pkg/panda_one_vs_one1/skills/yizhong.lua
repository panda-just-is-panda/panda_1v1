local yizhong = fk.CreateSkill {
  name = "pang__yizhong",
}

Fk:loadTranslationTable{
  ["pang__yizhong"] = "毅重",
  [":pang__yizhong"] = "当你成为伤害牌的目标后，你可以摸一张牌；若如此做，你本回合下次成为伤害牌的目标时失去此技能。",
  ["#pang__yizhong"] = "毅重：你可以摸一张牌",

  ["$pang__yizhong1"] = "奉令无犯，当敌制决！",
  ["$pang__yizhong2"] = "此役一败，晚节不保啊……",
}


yizhong:addEffect(fk.TargetConfirmed, {
    mute = true,
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(yizhong.name) and data.card.is_damage_card
  end,
  on_cost = function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player,{
      prompt = "#pang__yizhong",
      skill_name = yizhong.name,
    })
  end,
  on_use = function(self, event, target, player, data)
    player:drawCards(1, yizhong.name)
    player.room:addPlayerMark(player, "pang__yizhong-turn", 1)
    player:broadcastSkillInvoke(yizhong.name, 1)
  end,
})

yizhong:addEffect(fk.TargetConfirming, {
  can_refresh = function(self, event, target, player, data)
    return target == player and player:hasSkill(yizhong.name) and player:getMark("pang__yizhong-turn") > 0 and data.card.is_damage_card
  end,
  on_refresh = function(self, event, target, player, data)
    local room = player.room
    room:handleAddLoseSkills(player, "pang__yizhong", nil, false, true)
    player:broadcastSkillInvoke(yizhong.name, 2)
  end,
})

return yizhong