local xianzhen = fk.CreateSkill {
  name = "pang__xianzhen"
}

Fk:loadTranslationTable{
  ["pang__xianzhen"] = "陷阵",
  [":pang__xianzhen"] = "当你使用牌指定对手为目标后，你可以令其选择一项：摸一张牌，你本回合下次对其使用牌时弃置其两张牌；弃置一张牌，你本回合下次对其使用牌时其摸一张牌。",
  ["#pang__xianzhen"] = "陷阵：你可以令对手选择摸牌或弃牌",
  ["xianzhen_ask"] = "陷阵：你需弃置一张牌且下次被使用牌时摸一张牌，或点取消摸一张牌且下次被使用牌时弃置两张牌",
  ["#xianzhen_discard"] = "陷阵：弃置对手两张牌",



  ["$xianzhen1"] = "攻无不克，战无不胜！",
  ["$xianzhen2"] = "破阵斩将，易如反掌！",
}

xianzhen:addEffect(fk.TargetSpecified, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(xianzhen.name) and target ~= player
  end,
  on_cost = function (self, event, target, player, data)
    return player.room:askToSkillInvoke(player,{
      prompt = "#pang__xianzhen",
      skill_name = xianzhen.name,
    })
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local to = data.to
    local cards = room:askToDiscard(to, {
        skill_name = xianzhen.name,
        prompt = "xianzhen_ask",
        cancelable = true,
        min_num = 1,
        max_num = 1,
        include_equip = true,
    })
    if #cards > 0 then
        room:addPlayerMark(to, "xianzhen_draw-turn", 1)
    else
        room:addPlayerMark(to, "xianzhen_discard-turn", 1)
        to:drawCards(1, xianzhen.name)
    end
  end,
})

xianzhen:addEffect(fk.TargetSpecifying, {
  anim_type = "offensive",
  can_refresh = function (self, event, target, player, data)
    return target == player and player:hasSkill(xianzhen.name) and not table.contains(data.use.tos, player)
    and (target:getMark("xianzhen_draw-turn") > 0 or target:getMark("xianzhen_discard-turn") > 0)
  end,
  on_refresh = function(self, event, target, player, data)
    local room = player.room
    local to = data.use.tos[1]
    if to:getMark("xianzhen_draw-turn") > 0 then
        to:drawCards(1, xianzhen.name)
        room:setPlayerMark(to, "xianzhen_draw-turn", 0)
    elseif to:getMark("xianzhen_discard-turn") > 0 then
        room:setPlayerMark(to, "xianzhen_draw-turn", 0)
        local discarding
        discarding = room:askToChooseCards(player, {
          target = to,
          min = 2,
          max = 2,
          flag = "he",
          skill_name = xianzhen.name,
          prompt = "#xianzhen_discard",
        })
        if #discarding > 0 then
            local cards = discarding
            room:throwCard(cards, xianzhen.name, to, player) 
        end
    end
  end,
})

return xianzhen