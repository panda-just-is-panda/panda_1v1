local jianshi = fk.CreateSkill {
  name = "pang__jianshi",
}

Fk:loadTranslationTable{
  ["pang__jianshi"] = "舰势",
  [":pang__jianshi"] = "准备阶段，你可以弃置两张牌并视为使用一张【杀】；你的装备区内每有一张牌，需要弃置的牌数-1。",

  ["#jianshi_card0"] = "舰势：你可以视为使用一张【杀】",
  ["#jianshi_card1"] = "舰势：你可以弃置一张牌，视为使用一张【杀】",
  ["#jianshi_card2"] = "舰势：你可以弃置两张牌，视为使用一张【杀】",


  ["$pang__jianshi1"] = "布横江之铁索，徒自缚耳。",
  ["$pang__jianshi2"] = "艨艟击浪，可下千里江陵。",
}

local U = require "packages.klee_fk_B.pkg.gamemode.klee_1v1_util"

jianshi:addEffect(fk.EventPhaseStart, {
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(jianshi.name) and
      player.phase == Player.Start
  end,
  on_cost = function (self, event, target, player, data)
    local X = 2 - #player:getCardIds("e")
    local cards
    if X == 1 then
      cards = player.room:askToDiscard(player, {
        skill_name = jianshi.name,
        prompt = "#jianshi_card1",
        cancelable = true,
        min_num = 1,
        max_num = 1,
        include_equip = true,
      })
    elseif X == 2 then
      cards = player.room:askToDiscard(player, {
        skill_name = jianshi.name,
        prompt = "#jianshi_card2",
        cancelable = true,
        min_num = 2,
        max_num = 2,
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
    local slash = Fk:cloneCard("slash")
    room:useVirtualCard("slash", slash, player, player.next, jianshi.name, true)
  end,
})

return jianshi