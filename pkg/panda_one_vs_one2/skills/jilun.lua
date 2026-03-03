local jilun = fk.CreateSkill {
  name = "pang__jilun",
}

Fk:loadTranslationTable{
  ["pang__jilun"] = "机论",
  [":pang__jilun"] = "当你登场后，你令以下一项数值+1：手牌上限；出牌阶段使用【杀】次数。当你造成伤害后，你可以改为另一项。",
  ["#pang__jilun1"] = "机论：你可以改为令出牌阶段使用【杀】次数+1",
  ["#pang__jilun2"] = "机论：你可以改为手牌上限+1",
  ["jilun_maxcard"] = "增加手牌上限",
  ["jilun_slash"] = "增加出杀次数",

  ["$pang__jilun1"] = "时移不移，违天之祥也。",
  ["$pang__jilun2"] = "民望不因，违人之咎也。",
}

local U = require "packages.klee_fk_B.pkg.gamemode.klee_1v1_util"

jilun:addEffect(U.AfterDebut,{
  can_trigger = function (self, event, target, player, data)
    return player:hasSkill(jilun.name) and target == player
      and not data.begingame
  end,
  on_cost = Util.TrueFunc,
  on_use = function (self, event, target, player, data)
    local room = player.room
    local choices = {"jilun_maxcard", "jilun_slash"}
    local choice = room:askToChoice(player, {
      choices = choices,
      skill_name = jilun.name,
    })
    if choice == "jilun_maxcard" then
        room:setPlayerMark(player,"jilun_add_maxcard",1)
    else
        room:setPlayerMark(player,"jilun_add_slash",1)
    end
  end,
})

jilun:addEffect(fk.Damage, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(jilun.name) 
    and (player:getMark("jilun_add_slash") == 1 or player:getMark("jilun_add_maxcard") == 1)
  end,
  on_cost = function (self, event, target, player, data)
    return player.room:askToSkillInvoke(player,{
        prompt = player:getMark("jilun_add_maxcard") == 1 and "#pang__jilun1" or "#pang__jilun2",
        skill_name = jilun.name,
    })
  end,
  on_use = function (self, event, target, player, data)
    local room = player.room
    if player:getMark("jilun_add_maxcard") == 1 then
        room:setPlayerMark(player,"jilun_add_maxcard",0)
        room:setPlayerMark(player,"jilun_add_slash",1)
    else
        room:setPlayerMark(player,"jilun_add_maxcard",1)
        room:setPlayerMark(player,"jilun_add_slash",0)
    end
  end,
})

jilun:addEffect("maxcards", {
  correct_func = function(self, player)
    if player:hasSkill(jilun.name)
    and player:getMark("jilun_add_maxcard") == 1 then
        return 1
    end
  end,
})

jilun:addEffect("targetmod", {
  residue_func = function(self, player, skill, scope)
    if skill.trueName == "slash_skill" and player:getMark("jilun_add_slash") == 1 
    and scope == Player.HistoryPhase then
      return 1
    end
  end,
})

jilun:addLoseEffect(function (self, player, is_death)
  local room = player.room
  room:setPlayerMark(player,"jilun_add_maxcard",0)
  room:setPlayerMark(player,"jilun_add_slash",0)
end)

return jilun