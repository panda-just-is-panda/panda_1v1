local skel = fk.CreateSkill {
  name = "pang__manyi",
}

Fk:loadTranslationTable{
  ["pang__manyi"] = "蛮裔",
  [":pang__manyi"] = "当你登场时，你可以视为使用【南蛮入侵】。",
  ["#pang__manyi"] = "蛮裔：你可以视为使用【南蛮入侵】",

  ["$pang__manyi1"] = "哼！何须我亲自出马！",
  ["$pang__manyi2"] = "都给我留下吧！",
}

local U = require "packages.klee_fk_B.pkg.gamemode.klee_1v1_util"

skel:addEffect(U.AfterDebut, {
  can_trigger = function (self, event, target, player, data)
    return target == player and player:hasSkill(skel.name) and #Fk:cloneCard("savage_assault"):getDefaultTarget(player) > 0
  end,
  on_cost = function (self, event, target, player, data)
    return player.room:askToSkillInvoke(player,{
      prompt = "#kleeb__manyi",
      skill_name = skel.name,
    })
  end,
  on_use = function (self, event, target, player, data)
    local to = Fk:cloneCard("savage_assault"):getDefaultTarget(player)
    player.room:useVirtualCard("savage_assault",nil,player,to,skel.name)
  end,
})

return skel