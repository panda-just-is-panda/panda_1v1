local hengjiang = fk.CreateSkill({
  name = "pang__hengjiang",
  tags = {},
})

local bingxin = {
  anim_type = "defensive",
  can_trigger = function (self, event, target, player, data)
    return target == player and player:hasSkill(hengjiang.name) and data.to and data.to:getMaxCards() > 0
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
    room:addPlayerMark(to, MarkEnum.MinusMaxCards, 1)
    local choices = {"hengjiang_prevent", "hengjiang__drawcard"}
    local choice = room:askToChoice(player, {
      choices = choices,
      skill_name = hengjiang.name,
    })
    if choice == "hengjiang_prevent" then
        data:preventDamage()
    else
        to:drawCards(2, hengjiang.name)
    end
  end
}
hengjiang:addEffect(fk.DamageCaused, bingxin)
hengjiang:addEffect(fk.DamageInflicted, bingxin)


Fk:loadTranslationTable {["pang__hengjiang"] = "横江",
[":pang__hengjiang"] = "当你造成或受到伤害时，若受伤角色的手牌上限大于0，你可以令其手牌上限-1，然后你选择一项：其摸两张牌；防止此伤害。",
["#pang__hengjiang"] = "横江：你可以令 %src 手牌上限-1，然后选择防止此伤害或令 %src 摸两张牌",

["hengjiang_prevent"] = "防止伤害",
["hengjiang__drawcard"] = "摸两张牌",


  ["$pang__hengjiang1"] = "霸必奋勇杀敌，一雪夷陵之耻！",
  ["$pang__hengjiang2"] = "江横索寒，阻敌绝境之中！",
}
return hengjiang