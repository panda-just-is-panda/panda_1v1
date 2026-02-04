local lianji = fk.CreateSkill {
  name = "pang__lianji&",
  tags = {"kSupport"}
}

Fk:loadTranslationTable{
  ["pang__lianji&"] = "连计",
  [":pang__lianji&"] = "备场技，出牌阶段限三次，你可以变更武将；你发动过此技能的回合结束时，你失去此技能。",
  ["#pang__lianji"] = "连计：你可以变更武将",

  ["$pang__lianji&1"] = "计行周密，定无疏失。",
  ["$pang__lianji&2"] = "古有二桃杀三士，今以双计除虎狼。",
}

local U = require "packages.klee_fk_B.pkg.gamemode.klee_1v1_util"

lianji:addEffect("active", {
  anim_type = "control",
  prompt = "#pang__lianji",
  max_phase_use_time = 3,
  card_num = 0,
  target_num = 0,
  can_use = function(self, player)
    return player:usedSkillTimes(lianji.name, Player.HistoryPhase) < 3 
    and Fk:currentRoom():getBanner(U.getGeneralsBannerName(player))
    and #U.getGenerals(player) > 0
  end,
  card_filter = Util.FalseFunc,
  target_filter = Util.FalseFunc,
  on_use = function(self, room, effect)
    local player = effect.from
    local listall = U.getGenerals(player)
    U.AskToChangeGeneral(player,lianji.name,listall)
  end,
})

lianji:addEffect(fk.TurnEnd, { --
  can_refresh = function(self, event, target, player, data)
    return player:hasSkill(lianji.name) and player:usedSkillTimes(lianji.name, Player.HistoryPhase) > 0
  end,
  on_refresh = function(self, event, target, player, data)
    local room = player.room
    room:handleAddLoseSkills(player, "-pang__lianji&", nil, false, true)
    end,
})


return lianji