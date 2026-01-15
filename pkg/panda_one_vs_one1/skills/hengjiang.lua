local hengjiang = fk.CreateSkill({
  name = "pang__hengjiang",
  tags = {},
})

local bingxin = {
  anim_type = "defensive",
  can_trigger = function (self, event, target, player, data)
    return player:hasSkill(hengjiang.name) and data.to and data.to:getMaxCards() > 0
  end,
  on_cost = function (self, event, target, player, data)
    return player.room:askToSkillInvoke(player,{
      prompt = "#pang__hengjiang:"..data.to.id,
      skill_name = hengjiang.name,
    })
  end,
  on_use = function (self, event, target, player, data)
    local room = player.room
    local to = data.to
    data:preventDamage()
    room:addPlayerMark(to, MarkEnum.MinusMaxCards, 1)
  end
}
hengjiang:addEffect(fk.DamageCaused, bingxin)
hengjiang:addEffect(fk.DamageInflicted, bingxin)


Fk:loadTranslationTable {["pang__hengjiang"] = "横江",
[":pang__hengjiang"] = "当你造成或受到伤害时，若受伤角色的手牌上限大于0，你可以防止此伤害并令其手牌上限-1。",
["#pang__hengjiang"] = "横江：你可以防止对 %src 造成的伤害并令其手牌上限-1",


  ["$pang__hengjiang1"] = "霸必奋勇杀敌，一雪夷陵之耻！",
  ["$pang__hengjiang2"] = "江横索寒，阻敌绝境之中！",
}
return hengjiang