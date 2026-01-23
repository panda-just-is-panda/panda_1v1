

local xibing = fk.CreateSkill {
  name = "pang__xibing",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["pang__xibing"] = "息兵",
  [":pang__xibing"] = "锁定技，你登场后首次有角色使用【杀】时，该角色弃置两张牌，然后另一名角色的手牌上限+2直到你或其退场。",
  ["#xibing_discard"] = "息兵：你需弃置两张牌",

  ["$pang__xibing1"] = "千里运粮，非用兵之利。",
  ["$pang__xibing2"] = "宜弘一代之治，绍三王之迹。",
}

local U = require "packages.klee_fk_B.pkg.gamemode.klee_1v1_util"

xibing:addEffect("maxcards", {
  correct_func = function(self, player)
    if (player:hasSkill(xibing.name) or player.next:hasSkill(xibing.name)) and 
    player:getMark("xibing__shangxian") == 1 then
        return 2
    end
  end,
})


xibing:addEffect(fk.CardUsing, {
  can_trigger = function(self, event, target, player, data)
    return target == player and data.card and data.card.trueName == "slash" 
    and (player:hasSkill(xibing.name) or player.next:hasSkill(xibing.name)) 
    and player:usedSkillTimes(xibing.name, Player.HistoryGame) == 0 and player.next:usedSkillTimes(xibing.name, Player.HistoryGame) == 0
    and player.next:getMark("xibing__shangxian") == 0 and player:getMark("xibing__shangxian") == 0
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    room:setPlayerMark(player.next, "xibing__shangxian", 1)
    if not player:isNude() then
        local card = room:askToDiscard(player, {
          skill_name = xibing.name,
          prompt = "#xibing_discard",
          cancelable = false,
          min_num = 2,
          max_num = 2,
          include_equip = true,
        })
    end
  end,
})

xibing:addEffect(U.Farewell, {
  can_refresh = function (self, event, target, player, data)
    return (target == player or target:getMark("xibing__shangxian") == 1) and player:hasSkill(xibing.name,true,true)
  end,
  on_refresh = function (self, event, target, player, data)
    player.room:setPlayerMark(target, "xibing__shangxian", 0)
    player.room:setPlayerMark(target.next, "xibing__shangxian", 0)
  end,
})

return xibing