local lvecheng = fk.CreateSkill {
  name = "pang__lvecheng",
}

Fk:loadTranslationTable{
  ["pang__lvecheng"] = "掠城",
  [":pang__lvecheng"] = "你使用【杀】无次数限制，对手造成伤害时摸一张牌；出牌阶段开始时，你可以交换此技能中的“你”和“对手”。",

  ["#pang__lvecheng1"] = "掠城：你可以交换你（杀无次数限制）和对手（造成伤害摸牌）执行的效果",
  ["#pang__lvecheng2"] = "掠城：你可以交换你（造成伤害摸牌）和对手（杀无次数限制）执行的效果",
  ["@@lvecheng_times"] = "杀无次数限制",
  ["@@lvecheng_draw"] = "造成伤害摸牌",


  ["$pang__lvecheng1"] = "我等一无所有，普天又有何惧？",
  ["$pang__lvecheng2"] = "我视百城为饵，皆可食之果腹。",
}



lvecheng:addEffect(fk.EventPhaseStart, {
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(lvecheng.name) and
      player.phase == Player.Play
  end,
  on_cost = function (self, event, target, player, data)
    return player.room:askToSkillInvoke(player,{
      prompt = player:getMark("@@lvecheng_times") == 1 and "#pang__lvecheng1" or "#pang__lvecheng2", 
      skill_name = lvecheng.name,
    })
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    if player:getMark("@@lvecheng_times") == 1 then
      room:setPlayerMark(player,"@@lvecheng_times",0)
      room:setPlayerMark(player,"@@lvecheng_draw",1)
      room:setPlayerMark(player.next,"@@lvecheng_draw",0)
      room:setPlayerMark(player.next,"@@lvecheng_times",1)
    else
      room:setPlayerMark(player,"@@lvecheng_times",1)
      room:setPlayerMark(player,"@@lvecheng_draw",0)
      room:setPlayerMark(player.next,"@@lvecheng_draw",1)
      room:setPlayerMark(player.next,"@@lvecheng_times",0)
    end
  end,
})

lvecheng:addEffect(fk.DamageCaused, {
  anim_type = "offensive",
  mute = true,
  can_refresh = function(self, event, target, player, data)
    return target == player and player:getMark("@@lvecheng_draw") == 1
  end,
  on_refresh = function(self, event, target, player, data)
    player:drawCards(1, lvecheng.name)
  end,
})

lvecheng:addEffect("targetmod", {
  mute = true,
  bypass_times = function(self, player, skill, scope, card)
    if player:getMark("@@lvecheng_times") == 1 and card and card.trueName == "slash" then
      return true
    end
  end,
})

lvecheng:addAcquireEffect(function (self, player)
  local room = player.room
  room:setPlayerMark(player,"@@lvecheng_times",1)
  room:setPlayerMark(player.next,"@@lvecheng_draw",1)
end)

lvecheng:addLoseEffect(function (self, player, is_death)
  local room = player.room
  room:setPlayerMark(player,"@@lvecheng_times",0)
  room:setPlayerMark(player,"@@lvecheng_draw",0)
  room:setPlayerMark(player.next,"@@lvecheng_times",0)
  room:setPlayerMark(player.next,"@@lvecheng_draw",0)
end)

local U = require "packages.klee_fk_B.pkg.gamemode.klee_1v1_util"

lvecheng:addEffect(U.AfterDebut, {
  can_refresh = function (self, event, target, player, data)
    return player:hasSkill(lvecheng.name) and target == player.next
  end,
  on_refresh = function (self, event, target, player, data)
    local room = player.room
    if player:getMark("@@lvecheng_times") == 1 then
      room:setPlayerMark(player.next,"@@lvecheng_draw",1)
    else
      room:setPlayerMark(player.next,"@@lvecheng_times",1)
    end
  end,
})

return lvecheng