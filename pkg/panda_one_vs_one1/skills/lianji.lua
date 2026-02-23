local lianji = fk.CreateSkill {
  name = "pang__lianji&",
  tags = {"kSupport"}
}

Fk:loadTranslationTable{
  ["pang__lianji&"] = "连计",
  [":pang__lianji&"] = "备场技，出牌阶段限两次，你可以变更武将；回合结束时，若你发动过此技能，你失去此技能并变更至你回合开始时的武将。",
  ["#pang__lianji"] = "连计：你可以变更武将",

  ["$pang__lianji&1"] = "计行周密，定无疏失。",
  ["$pang__lianji&2"] = "古有二桃杀三士，今以双计除虎狼。",
}

local U = require "packages.klee_fk_B.pkg.gamemode.klee_1v1_util"

lianji:addEffect("active", {
  anim_type = "control",
  prompt = "#pang__lianji",
  max_phase_use_time = 2,
  card_num = 0,
  target_num = 0,
  can_use = function(self, player)
    return player:usedSkillTimes(lianji.name, Player.HistoryPhase) < 2 
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

lianji:addEffect(fk.TurnStart, { --
  can_refresh = function(self, event, target, player, data)
    return player:hasSkill(lianji.name)
  end,
  on_refresh = function(self, event, target, player, data)
    local room = player.room
    room:setPlayerMark(player, "lianji-turn", {player.general})
    end,
})

lianji:addEffect(fk.TurnEnd, { --
  can_refresh = function(self, event, target, player, data)
    return player:hasSkill(lianji.name) and player:usedSkillTimes(lianji.name, Player.HistoryTurn) > 0
  end,
  on_refresh = function(self, event, target, player, data)
    local room = player.room
    local name = player:getTableMark("lianji-turn")[1]
    local listall = U.getGenerals(player)
    local not_available = table.filter(listall,function (element, index, array)
      return Fk.generals[element].name ~= name
    end)
    room:handleAddLoseSkills(player, "-pang__lianji&", nil, false, true)
    if #listall > #not_available then
      U.AskToChangeGeneral(player,lianji.name,listall,not_available)
    end
    end,
})

lianji:addAcquireEffect(function (self, player)
  local room = player.room
  if room.current ~= player and player:usedSkillTimes(lianji.name, Player.HistoryGame) > 0 then
    room:handleAddLoseSkills(player, "-pang__lianji&", nil, false, true)
  end
end)


return lianji