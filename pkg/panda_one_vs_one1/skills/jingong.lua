local jingong = fk.CreateSkill {
  name = "pang__jingong",
}

Fk:loadTranslationTable{
  ["pang__jingong"] = "矜功",
  [":pang__jingong"] = "结束阶段，你可以摸三张牌，然后若此技能发动次数大于你杀死过的角色数，你减1点体力上限。",

  ["#pang__jingong1"] = "矜功：你可以摸三张牌",
  ["#pang__jingong2"] = "矜功：你可以摸三张牌，然后减1点体力上限",


  ["$pang__jingong1"] = "首恶不容，余恶亦不轻饶。",
  ["$pang__jingong2"] = "我以一己之力讨贼匡政。",
}

local U = require "packages.klee_fk_B.pkg.gamemode.klee_1v1_util"

jingong:addEffect(fk.EventPhaseStart, {
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(jingong.name) and
      target.phase == Player.Finish
  end,
  on_cost = function (self, event, target, player, data)
    return player.room:askToSkillInvoke(player,{
      prompt = player:usedSkillTimes(jingong.name, Player.HistoryGame) < player:getMark("pang_jingong") and "#pang__jingong1" or "#pang__jingong2",
      skill_name = jingong.name,
    })
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    player:drawCards(3, jingong.name)
    if player:usedSkillTimes(jingong.name, Player.HistoryGame) > player:getMark("pang_jingong") then
        room:changeMaxHp(player, -1)
    end
  end,
})

jingong:addEffect(fk.Death, {
  can_refresh = function(self, event, target, player, data)
    return player:hasSkill(jingong.name) and data.killer == player
  end,
  on_refresh = function(self, event, target, player, data)
    player.room:addPlayerMark(player,"pang_jingong",1)
  end,
})

return jingong