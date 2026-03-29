local eyao = fk.CreateSkill {
  name = "pang__eyao",
}

Fk:loadTranslationTable{
  ["pang__eyao"] = "扼要",
  [":pang__eyao"] = "你每使用五张牌后，你可以视为使用一张【杀】；若此时不为你的回合，此【杀】伤害+1。",

  ["#eyao_use"] = "扼要：你可以视为使用一张【杀】",
  ["@pang__eyao_count"] = "扼要",


  ["$pang__eyao1"] = "善战者后动，一击而毙敌。",
  ["$pang__eyao2"] = "我所善者，后发制人尔。",
}




eyao:addEffect(fk.CardUseFinished, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    local room = player.room
    if player:hasSkill(eyao.name) and target == player then
      room:addPlayerMark(player,"@pang__eyao_count", 1) 
    end
    return player:hasSkill(eyao.name) and target == player and player:getMark("@pang__eyao_count") >= 5
  end,
  on_cost = function (self, event, target, player, data)
    player.room:setPlayerMark(player,"@pang__eyao_count", 0)
    return player.room:askToSkillInvoke(player,{
      prompt = "#eyao_use",
      skill_name = eyao.name,
    })
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    room:askToUseVirtualCard(player, {name = "slash", skill_name = eyao.name, cancelable = false, skip = false})
  end,
})

eyao:addEffect(fk.DamageCaused, {
  anim_type = "offensive",
  can_refresh = function(self, event, target, player, data)
    return data.from == player and player:hasSkill(eyao.name) 
    and data.card and data.card.trueName == "slash"
    and player.room.current ~= player
    and table.contains(data.card.skillNames, eyao.name)
  end,
  on_refresh = function(self, event, target, player, data)
    data:changeDamage(1)
  end,
})

return eyao