local liezhi = fk.CreateSkill {
  name = "pang__liezhi",
}

Fk:loadTranslationTable{
  ["pang__liezhi"] = "烈直",
  [":pang__liezhi"] = "当一名角色回复体力后，你可以和对手依次失去1点体力。",
  ["#pang__liezhi"] = "烈直：你可以和对手依次失去1点体力。",


  ["$pang__liezhi1"] = "只恨箭支太少，不能射杀汝等！",
  ["$pang__liezhi2"] = "身陨事小，秉节事大。",
}

liezhi:addEffect(fk.HpRecover, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(liezhi.name) and
      not player.dying and not player.next.dying
  end,
  on_cost = function (self, event, target, player, data)
    return player.room:askToSkillInvoke(player,{
      prompt = "#pang__liezhi",
      skill_name = liezhi.name,
    })
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    room:loseHp(player, 1, liezhi.name)
    room:loseHp(player.next, 1, liezhi.name)
  end,
})

return liezhi