

local xibing = fk.CreateSkill {
  name = "pang__xibing",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["pang__xibing"] = "息兵",
  [":pang__xibing"] = "锁定技，你登场后首名使用【杀】的角色需弃置两张牌，然后另一名角色的手牌上限+2直到你退场。",

  ["$pang__xibing1"] = "千里运粮，非用兵之利。",
  ["$pang__xibing2"] = "宜弘一代之治，绍三王之迹。",
}

local U = require "packages.klee_fk_B.pkg.gamemode.klee_1v1_util"

xibing:addEffect("maxcards", {
  correct_func = function(self, player)
    if player:getMark("xibing__shangxian") == 1 then
        return 2
    end
  end,
})


xibing:addEffect(fk.CardUsing, {
  can_trigger = function(self, event, target, player, data)
    return target == player and data.card and data.card.trueName == "slash" 
    and player.next:getMark("xibing__shangxian") == 0 and player:getMark("xibing__shangxian") == 0
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    room:setPlayerMark(player.next, "xibing__shangxian", 1)
    if not player:isNude() then
        local card = room:askToDiscard(player, {
          skill_name = xibing.name,
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
    return player:hasSkill(xibing.name,true,true)
  end,
  on_refresh = function (self, event, target, player, data)
    player.room:setPlayerMark(target, "xibing__shangxian", 0)
    player.room:setPlayerMark(target.next, "xibing__shangxian", 0)
  end,
})

return xibing