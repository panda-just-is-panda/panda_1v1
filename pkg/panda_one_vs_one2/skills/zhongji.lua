local zhongji = fk.CreateSkill {
  name = "pang__zhongji",
  tags = {Skill.Limited},
}

Fk:loadTranslationTable{
  ["pang__zhongji"] = "螽集",
  [":pang__zhongji"] = "限定技，摸牌阶段，你可以改为从弃牌堆中获得两张【杀】和两张【闪】。",
  ["#pang__zhongji"] = "螽集：你可以改为从弃牌堆中获得两张【杀】和两张【闪】。",

  ["$pang__zhongji1"] = "羸汉暴政不息，黄巾永世不绝。",
  ["$pang__zhongji2"] = "朱紫视吾为蝼蚁，其可知蝼蚁之怒乎？",
}

zhongji:addEffect(fk.DrawNCards, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(zhongji.name) and
    player:usedSkillTimes(zhongji.name, Player.HistoryGame) == 0
  end,
    on_cost = function (self, event, target, player, data)
    return player.room:askToSkillInvoke(player,{
      prompt = "#pang__zhongji",
      skill_name = zhongji.name,
    })
  end,
  on_use = function(self, event, target, player, data)
    data.n = 0
    local cards1 = player.room:getCardsFromPileByRule("slash", 2, "discardPile")
    local cards2 = player.room:getCardsFromPileByRule("jink", 2, "discardPile")
    if #cards1 > 0 then
        player.room:obtainCard(player, cards1[1], true, fk.ReasonJustMove, player, zhongji.name)
        if #cards1 > 1 then
            player.room:obtainCard(player, cards1[2], true, fk.ReasonJustMove, player, zhongji.name)
        end
    end
    if #cards2 > 0 then
        player.room:obtainCard(player, cards2[1], true, fk.ReasonJustMove, player, zhongji.name)
        if #cards2 > 1 then
            player.room:obtainCard(player, cards2[2], true, fk.ReasonJustMove, player, zhongji.name)
        end
    end
  end,
})

return zhongji