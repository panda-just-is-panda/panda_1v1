local yuanqing = fk.CreateSkill {
  name = "pang__yuanqing",
}

Fk:loadTranslationTable{
  ["pang__yuanqing"] = "渊清",
  [":pang__yuanqing"] = "当你使用一张牌后，若你登场后使用过的牌类型均相同，你可以摸一张牌。",
  ["#pang__yuanqing"] = "渊清：你可以摸一张牌",

  ["$pang__yuanqing1"] = "存志太虚，安心玄妙。",
  ["$pang__yuanqing2"] = "礼法有度，良德才略。",
}

yuanqing:addEffect(fk.CardUseFinished, {
    anim_type = "drawcard",
    can_trigger = function(self, event, target, player, data)
        return player:getMark("yuanqing_equip") + player:getMark("yuanqing_basic") + player:getMark("yuanqing_Trick") < 2
    end,
    on_cost = function (self, event, target, player, data)
    return player.room:askToSkillInvoke(player,{
      prompt = "#pang__yuanqing",
      skill_name = yuanqing.name,
    })
  end,
    on_use = function(self, event, target, player, data)
        local room = player.room
        player:drawCards(1, yuanqing.name)
    end,
})

yuanqing:addEffect(fk.CardUsing, {
  can_refresh = function(self, event, target, player, data)
    return target == player and player:hasSkill(yuanqing.name)
  end,
  on_refresh = function(self, event, target, player, data)
    local room = player.room
    if data.card.type == Card.TypeEquip then
        room:setPlayerMark(player, "yuanqing_equip", 1)
    elseif data.card.type == Card.TypeBasic then
        room:setPlayerMark(player, "yuanqing_basic", 1)
    elseif data.card.type == Card.TypeTrick then
        room:setPlayerMark(player, "yuanqing_Trick", 1)
    end
  end,
})