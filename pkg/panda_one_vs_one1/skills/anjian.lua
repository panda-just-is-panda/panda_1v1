local anjian = fk.CreateSkill {
  name = "pang__anjian&",
  tags = {"kSupport"}
}

Fk:loadTranslationTable{
  ["pang__anjian&"] = "暗箭",
  [":pang__anjian&"] = "备场技，对手的结束阶段，若其没有手牌，你可以对其造成1点伤害，然后移出此武将。",
  ["#pang__anjian"] = "暗箭：你可以对对手造成1点伤害",

  ["$pang__anjian&1"] = "看我一箭索命！",
  ["$pang__anjian&2"] = "明枪易躲，暗箭难防！",
}

local U = require "packages.klee_fk_B.pkg.gamemode.klee_1v1_util"

anjian:addEffect(fk.EventPhaseStart, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(anjian.name) and target.phase == Player.Finish and target == player.next and target:isKongcheng()
  end,
  on_cost = function (self, event, target, player, data)
    return player.room:askToSkillInvoke(player,{
      prompt = "#pang__anjian",
      skill_name = anjian.name,
    })
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    room:damage{
        from = player,
        to = target,
        damage = 1,
        skillName = anjian.name,
    }
    U.removeGeneral(player,"pang__panzhangmazhong")
    U.addGeneral(player,"pang__panzhangmazhong",{state = "dead"})
  end,
})

return anjian