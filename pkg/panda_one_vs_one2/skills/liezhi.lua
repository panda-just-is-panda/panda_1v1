local liezhi = fk.CreateSkill {
  name = "pang__liezhi",
}

Fk:loadTranslationTable{
  ["pang__liezhi"] = "烈直",
  [":pang__liezhi"] = "当你受到伤害后，你可以弃置对手两张牌，然后你减1点体力上限，手牌上限+1。",
  ["#pang__liezhi"] = "烈直：你可以弃置对手两张牌，然后减1点体力上限，加1点手牌上限",
  ["#pang__liezhi_discard"] = "烈直：弃置对手两张牌",


  ["$pang__liezhi1"] = "只恨箭支太少，不能射杀汝等！",
  ["$pang__liezhi2"] = "身陨事小，秉节事大。",
}

liezhi:addEffect(fk.Damaged, {
  anim_type = "control",
  can_trigger = function (self, event, target, player, data)
    return player:hasSkill(liezhi.name) and target == player and not player.next:isNude()
  end,
  on_cost = function (self, event, target, player, data)
    return player.room:askToSkillInvoke(player,{
      prompt = "#pang__liezhi",
      skill_name =liezhi.name,
    })
  end,
  on_use = function (self, event, target, player, data)
    local room = player.room
    local to = player.next
    local discard = room:askToChooseCards(player, {
      target = to,
      min = 2,
      max = 2,
      flag = "he",
      skill_name = liezhi.name,
      prompt = "#pang__liezhi_discard",
    })
    if #discard > 0 then
      room:throwCard(discard, liezhi.name, to, player)
      room:changeMaxHp(player, -1)
      room:addPlayerMark(player, MarkEnum.AddMaxCards, 1)
    end
  end,
})

return liezhi