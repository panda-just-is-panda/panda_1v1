local jianshi = fk.CreateSkill {
  name = "pang__jianshi",
}

Fk:loadTranslationTable{
  ["pang__jianshi"] = "舰势",
  [":pang__jianshi"] = "准备阶段，你可以弃置两张牌并视为使用一张【杀】；你装备区内每有一张牌，需要弃置的牌数-1。",

  ["#jianshi_card0"] = "舰势：你可以视为使用一张【杀】",
  ["#jianshi_card1"] = "舰势：你可以弃置一张牌，视为使用一张【杀】",
  ["#jianshi_card2"] = "舰势：你可以弃置两张牌，视为使用一张【杀】",


  ["$pang__jianshi1"] =  "修橹筑楼舫，伺时补金瓯。",
  ["$pang__jianshi2"] = "连舫披金甲，王气自可收。",
}

local U = require "packages.klee_fk_B.pkg.gamemode.klee_1v1_util"

jianshi:addEffect(fk.EventPhaseStart, {
  mute = true,
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(jianshi.name) and
      player.phase == Player.Start
  end,
  on_cost = function (self, event, target, player, data)
    local X = 2 - #player:getCardIds("e")
    local cards
    if X > 0 then
      cards = player.room:askToDiscard(player, {
        skill_name = jianshi.name,
        prompt = X == 2 and "#jianshi_card2" or "#jianshi_card1",
        cancelable = true,
        num = X == 2 and 2 or 1,
        include_equip = true,
        })
    end
    if X > 0 and #cards == X then
      return true
    elseif X == 0 then
      if player.room:askToSkillInvoke(player, {
        skill_name = jianshi.name,
        prompt = "#jianshi_card0",
      }) then
        return true
      end
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    room:askToUseVirtualCard(player, {
      name = "slash", skill_name = jianshi.name, cancelable = false, skip = false
    })
  end,
})

return jianshi