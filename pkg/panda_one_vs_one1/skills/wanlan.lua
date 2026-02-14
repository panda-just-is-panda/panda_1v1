local wanlan = fk.CreateSkill {
  name = "pang__wanlan",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["pang__wanlan"] = "挽澜",
  [":pang__wanlan"] = "锁定技，若你的登场数大于对手的登场数，你造成的伤害+X(X为你和对手的登场数之差)。",


  ["$pang__wanlan1"] = "挽狂澜于既倒，扶大厦于将倾。",
  ["$pang__wanlan2"] = "深受国恩，今日便是报偿之时！",
}

local U = require "packages.klee_fk_B.pkg.gamemode.klee_1v1_util"

wanlan:addEffect(fk.DamageCaused, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(wanlan.name) and target == player 
    and U.getPlayercount(player)[1] > U.getPlayercount(player.next)[1]
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local X = U.getPlayercount(player)[1] - U.getPlayercount(player.next)[1]
    data:changeDamage(X)
  end,
})

return wanlan