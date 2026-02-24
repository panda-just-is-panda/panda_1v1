local yuanqing = fk.CreateSkill {
  name = "pang__yuanqing",
}

Fk:loadTranslationTable{
  ["pang__yuanqing"] = "渊清",
  [":pang__yuanqing"] = "摸牌阶段，若你登场后使用过的牌类型或花色均相同，你可以多摸两张牌。",
  ["#pang__yuanqing"] = "渊清：你可以多摸两张牌",

  ["$pang__yuanqing1"] = "存志太虚，安心玄妙。",
  ["$pang__yuanqing2"] = "礼法有度，良德才略。",
}

local U = require "packages.klee_fk_B.pkg.gamemode.klee_1v1_util"

yuanqing:addEffect(fk.DrawNCards, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(yuanqing.name) and
    player:getMark("yuanqing_true") == 1
  end,
    on_cost = function (self, event, target, player, data)
    return player.room:askToSkillInvoke(player,{
      prompt = "#pang__yuanqing",
      skill_name = yuanqing.name,
    })
  end,
  on_use = function(self, event, target, player, data)
    data.n = data.n + 2
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
    if data.card.suit == Card.Club then
      room:setPlayerMark(player, "yuanqing_club", 1)
    elseif data.card.suit == Card.Spade then
      room:setPlayerMark(player, "yuanqing_spade", 1)
    elseif data.card.suit == Card.Heart then
      room:setPlayerMark(player, "yuanqing_heart", 1)
    elseif data.card.suit == Card.Diamond then
      room:setPlayerMark(player, "yuanqing_diamond", 1)
    end
    if player:getMark("yuanqing_equip") + player:getMark("yuanqing_basic") + player:getMark("yuanqing_Trick") > 1
    and player:getMark("yuanqing_club") + player:getMark("yuanqing_spade") + player:getMark("yuanqing_heart") + player:getMark("yuanqing_diamond") > 1 then
      room:setPlayerMark(player, "yuanqing_true", 0)
    end
  end,
})

yuanqing:addEffect(U.AfterDebut, {
  can_refresh = function (self, event, target, player, data)
    return target == player and player:hasSkill(yuanqing.name)
  end,
  on_refresh = function (self, event, target, player, data)
    local room = player.room
    room:setPlayerMark(player, "yuanqing_true", 1)
  end,
})

return yuanqing