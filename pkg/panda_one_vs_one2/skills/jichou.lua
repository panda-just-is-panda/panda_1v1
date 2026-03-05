local jichou = fk.CreateSkill({
  name = "pang__jichou",
  tags = {},
})

Fk:loadTranslationTable {["pang__jichou"] = "急筹",
[":pang__jichou"] = "准备阶段，或当你受到伤害后，你可以摸三张牌；若你于此时机发动过此技能，改为你需弃置一张牌。",
["#pang__jichou1"] = "急筹：（受到伤害）你可以摸三张牌",
["#pang__jichou2"] = "急筹：（准备阶段）你可以摸三张牌",
["#pang__jichou_discard"] = "急筹：你需弃置一张牌",
["@@jichou_damage"] = "急筹：受到伤害",
["@@jichou_start"] = "急筹：准备阶段",



  ["$pang__jichou1"] = "此危亡之时，当出此急谋。",
  ["$pang__jichou2"] = "急筹布画，运策捭阖。",
}

jichou:addEffect(fk.Damaged, {
  anim_type = "control",
  can_trigger = function (self, event, target, player, data)
    return target == player and player:hasSkill(jichou.name) and player:isAlive()
  end,
  on_cost = function (self, event, target, player, data)
    if player:getMark("@@jichou_damage") == 0 then
        return player.room:askToSkillInvoke(player,{
            prompt = "#pang__jichou1",
            skill_name = jichou.name,
        })
    elseif not player:isNude() then
        return true
    end
  end,
  on_use = function (self, event, target, player, data)
    local room = player.room
    if player:getMark("@@jichou_damage") == 0 then
        player:drawCards(3, jichou.name)
        room:setPlayerMark(player,"@@jichou_damage",1)
        room:setPlayerMark(player,"pang__jichou_damage",1)
    else
        local card = room:askToDiscard(player, {
          skill_name = jichou.name,
          prompt = "#pang__jichou_discard",
          cancelable = false,
          min_num = 1,
          max_num = 1,
          include_equip = true,
        })
    end
  end,
})

jichou:addEffect(fk.EventPhaseStart, {
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(jichou.name) and
      player.phase == Player.Start
  end,
  on_cost = function (self, event, target, player, data)
    if player:getMark("@@jichou_start") == 0 then
        return player.room:askToSkillInvoke(player,{
            prompt = "#pang__jichou2",
            skill_name = jichou.name,
        })
    elseif not player:isNude() then
        return true
    end
  end,
  on_use = function (self, event, target, player, data)
    local room = player.room
    if player:getMark("@@jichou_start") == 0 then
        player:drawCards(3, jichou.name)
        room:setPlayerMark(player,"@@jichou_start",1)
        room:setPlayerMark(player,"pang__jichou_start",1)
    else
        local card = room:askToDiscard(player, {
          skill_name = jichou.name,
          prompt = "#pang__jichou_discard",
          cancelable = false,
          min_num = 1,
          max_num = 1,
          include_equip = true,
        })
    end
  end,
})

jichou:addLoseEffect(function (self, player, is_death)
  local room = player.room
  room:setPlayerMark(player,"@@jichou_damage",0)
  room:setPlayerMark(player,"@@jichou_start",0)
end)

jichou:addAcquireEffect(function (self, player)
  local room = player.room
  if player:getMark("pang__jichou_start") == 1 then
    room:setPlayerMark(player,"@@jichou_start",1)
  end
  if player:getMark("pang__jichou_damage") == 1 then
    room:setPlayerMark(player,"@@jichou_damage",1)
  end
end)

local U = require "packages.klee_fk_B.pkg.gamemode.klee_1v1_util"

jichou:addEffect(U.Farewell, {
  priority = 0,
  can_refresh = function (self, event, target, player, data)
    return target == player and player:usedSkillTimes("pang__jichou", Player.HistoryGame) > 0
  end,
  on_refresh = function (self, event, target, player, data)
    data.extra_data = data.extra_data or {}
    if player:getMark("pang__jichou_start") == 1 then
      data.extra_data.pang__jichou_start = 1
    end
    if player:getMark("pang__jichou_damage") == 1 then
      data.extra_data.pang__jichou_damage = 1
    end
  end,
})

jichou:addEffect(U.BeforeV11DrawInitial,{
  can_refresh = function (self, event, target, player, data)
    return target == player and data.debutinfo and data.debutinfo.extra_data and player:usedSkillTimes("pang__jichou", Player.HistoryGame) > 0
  end,
  on_refresh = function (self, event, target, player, data)
    if data.debutinfo.extra_data.pang__jichou_damage == 1 then
      player.room:setPlayerMark(player,"pang__jichou_damage",1)
    end
    if data.debutinfo.extra_data.pang__jichou_start == 1 then
      player.room:setPlayerMark(player,"pang__jichou_start",1)
    end
  end,
})

return jichou