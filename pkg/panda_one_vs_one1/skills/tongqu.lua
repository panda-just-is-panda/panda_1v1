local tongqu = fk.CreateSkill {
  name = "pang__tongqu",
}

Fk:loadTranslationTable{
  ["pang__tongqu"] = "通渠",
  [":pang__tongqu"] = "摸牌阶段结束时，你可以将手牌摸至三张，或弃置一张牌并于本回合的下个阶段结束时发动此技能。",
  ["#pang__tongqu"] = "通渠：你可以选择将手牌摸至三张或弃牌",

  ["@@pang__tongqu-turn"] = "可通渠",
  ["#pang__tongqu_discard"] = "通渠：点取消将手牌摸至三张，或选择一张牌弃置并于本回合的下个阶段结束时发动此技能",

  ["$pang__tongqu1"] = "兴凿修渠，依水屯军！",
  ["$pang__tongqu2"] = "开渠疏道，以备军实！",
}

tongqu:addEffect(fk.EventPhaseEnd, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(tongqu.name) and (player.phase == Player.Draw or player:getMark("@@pang__tongqu-turn") > 0)
  end,
  on_cost = function(self, event, target, player, data)
    player.room:setPlayerMark(player, "@@pang__tongqu-turn", 0)
    return player.room:askToSkillInvoke(player, {
      skill_name = tongqu.name,
      prompt = "#pang__tongqu",
    })
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local card = room:askToDiscard(player, {
      skill_name = tongqu.name,
      prompt = "#pang__tongqu_discard",
      cancelable = true,
      min_num = 1,
      max_num = 1,
      include_equip = true,
    })
    if #card > 0 then
      room:setPlayerMark(player, "@@pang__tongqu-turn", 1)
    else
      local X = 3 - player:getHandcardNum()
      if X > 0 then
        player:drawCards(X, tongqu.name)
      end
    end
  end,
})


return tongqu