local hengjiang = fk.CreateSkill({
  name = "pang__hengjiang",
  tags = {},
})

hengjiang:addEffect(fk.Damaged, {
  anim_type = "control",
  can_trigger = function (self, event, target, player, data)
    return player:hasSkill(hengjiang.name) and data.to
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
    local cards = room:askToDiscard(to, {
          skill_name = hengjiang.name,
          cancelable = true,
          min_num = 2,
          max_num = 2,
          include_equip = false,
    })
    if #cards == 2 then
      room:addPlayerMark(to, MarkEnum.AddMaxCards, 1)
    end
    room:addPlayerMark(to, MarkEnum.MinusMaxCards, 1)
    to:drawCards(2, hengjiang.name)
  end,
})


Fk:loadTranslationTable {["pang__hengjiang"] = "横江",
[":pang__hengjiang"] = "当一名角色受到伤害后，你可以令其摸两张牌，然后手牌上限-1；其可以先弃置两张手牌，然后手牌上限+1。",
["#pang__hengjiang"] = "横江：你可以令 %src 摸两张牌且手牌上限-1，%src 可以先弃置两张牌并令手牌上限+1",

["hengjiang_prevent"] = "防止伤害",
["hengjiang__drawcard"] = "摸两张牌",


  ["$pang__hengjiang1"] = "霸必奋勇杀敌，一雪夷陵之耻！",
  ["$pang__hengjiang2"] = "江横索寒，阻敌绝境之中！",
}
return hengjiang