local diancai = fk.CreateSkill {
  name = "pang__diancai",
}

Fk:loadTranslationTable{
  ["pang__diancai"] = "典财",
  [":pang__diancai"] = "弃牌阶段开始时，你可以摸X张牌（X为你的手牌数），然后弃置等量张牌。",

  ["#pang__diancai"] = "典财：你可以摸%arg张牌，然后弃置%arg张牌",
  ["#pang__diancai_discard"] = "典财：弃置%arg张牌",


  ["$pang__diancai1"] = "军资之用，不可擅做主张。",
  ["$pang__diancai2"] = "善用资财，乃为政上法。",
}



diancai:addEffect(fk.EventPhaseStart, {
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(diancai.name) and
      player.phase == Player.Discard and not player:isKongcheng()
  end,
  on_cost = function (self, event, target, player, data)
    return player.room:askToSkillInvoke(player,{
      prompt ="#pang__diancai:::"..#player:getCardIds("h"), 
      skill_name = diancai.name,
    })
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local X = #player:getCardIds("h")
    player:drawCards(X, diancai.name)
    local nerf = 1
    if nerf == 1 then
    local card = room:askToDiscard(player, {
        skill_name = diancai.name,
        prompt = "#pang__diancai_discard:::"..X,
        cancelable = false,
        min_num = X,
        max_num = X,
        include_equip = true,
    })
    end 
  end,
})


return diancai