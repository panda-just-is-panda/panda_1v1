local changqu = fk.CreateSkill {
  name = "pang__changqu",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["pang__changqu"] = "长驱",
  [":pang__changqu"] = "锁定技，一名角色首次受到你造成的伤害时，其需选择一项：此伤害+1；交给你两张牌并退场，然后最大登场数+1。",
  ["#changqu-give"] = "长驱：交给%dest两张牌，否则此伤害+1",


  ["$pang__changqu1"] = "白首全金瓯，著风流于春秋。",
  ["$pang__changqu2"] = "长戈斩王气，统大业于四海。",
}

local U = require "packages.klee_fk_B.pkg.gamemode.klee_1v1_util"

changqu:addEffect(fk.DamageCaused, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(changqu.name) and target == player
    and data.to:getMark("changqu_damage") == 0
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local to = data.to
    room:setPlayerMark(to, "changqu_damage", 1)
    local cards = room:askToCards(to, {
      skill_name = changqu.name,
      include_equip = true,
      min_num = 2,
      max_num = 2,
      prompt = "#changqu-give::"..player.id,
      cancelable = true,
    })
    if #cards > 1 and data.to ~= player then
        room:moveCardTo(cards, Player.Hand, player, fk.ReasonGive, changqu.name, nil, false, to)
        data:preventDamage()
        U.addPlayercount(to,0,1)
        U.PlayerDebut(to,changqu.name,false)
    else
        data:changeDamage(1)
    end
  end,
})

return changqu