

local xibing = fk.CreateSkill {
  name = "pang__xibing",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["pang__xibing"] = "息兵",
  [":pang__xibing"] = "锁定技，你登场后首名使用【杀】的角色的手牌上限-2，未使用过【杀】的角色的手牌上限+2。",
  ["#xibing_discard"] = "息兵：你需弃置两张牌",

  ["$pang__xibing1"] = "千里运粮，非用兵之利。",
  ["$pang__xibing2"] = "宜弘一代之治，绍三王之迹。",
}

local U = require "packages.klee_fk_B.pkg.gamemode.klee_1v1_util"

xibing:addEffect("maxcards", {
  correct_func = function(self, player)
    if (player:hasSkill(xibing.name) or player.next:hasSkill(xibing.name))
    and player:getMark("xibing__shangxian") == 1 then
        return 2
    end
  end,
})


xibing:addEffect(fk.CardUsing, {
  can_trigger = function(self, event, target, player, data)
    return target and data.card and data.card.trueName == "slash" 
    and player:hasSkill(xibing.name) 
    and target:getMark("xibing__shangxian") == 0
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local to = target
    room:setPlayerMark(to, "xibing__shangxian", 0)
    if player.next:getMark("xibing__shangxian") == 1 then
      room:addPlayerMark(to, MarkEnum.MinusMaxCards, 2)
    end
  end,
})

xibing:addEffect(U.Debut, {
  can_trigger = function (self, event, target, player, data)
    return target == player and player:hasSkill(xibing.name)
  end,
  on_cost = Util.TrueFunc,
  on_use = function (self, event, target, player, data)
    local room = player.room
    room:setPlayerMark(player, "xibing__shangxian", 1)
    room:setPlayerMark(player.next, "xibing__shangxian", 1)
  end,
})


return xibing