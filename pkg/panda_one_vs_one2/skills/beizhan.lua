local beizhan = fk.CreateSkill{
  name = "pang__beizhan",
  tags = {},
}

Fk:loadTranslationTable{
  ["pang__beizhan"] = "备战",
  [":pang__beizhan"] = "结束阶段，你可以展示一张手牌；准备阶段，你将因此展示的牌作为【万箭齐发】使用。",

  ["#pang__beizhan"] = "备战：你可以展示一张手牌，下个准备阶段将此牌作为【万箭齐发】使用",
  ["@@pang__beizhan-inhand"] = "备战",
  ["$pang__wangping_lve"] = "略",


  ["$pang__beizhan1"] = "敌军攻势渐怠，还望诸位依策坚守。",
  ["$pang__beizhan2"] = "袁幽州不日便至，当行策建功以报之。",
}

beizhan:addEffect(fk.EventPhaseStart, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(beizhan.name)
    and player.phase == Player.Finish
    or target == player and player:hasSkill(beizhan.name)
    and player.phase == Player.Start and #table.filter(player:getCardIds("h"), function(id)
      local card_id = Fk:getCardById(id)
      return card_id and card_id:getMark("@@pang__beizhan-inhand") > 0
    end) > 0
  end,
  on_cost = function(self, event, target, player, data)
    if player.phase == Player.Start then return true end
    local cards = player.room:askToCards(player, {
      min_num = 1,
      max_num = 1,
      include_equip = false,
      skill_name = beizhan.name,
      prompt = "#pang__beizhan",
      cancelable = true,
    })
    if #cards > 0 then
      event:setCostData(self, { cards = cards })
      return true
    end
  end,
  on_use = function (self, event, target, player, data)
    local room = player.room
    if player.phase == Player.Finish then
      for _, c in ipairs(event:getCostData(self).cards) do
        room:setCardMark(Fk:getCardById(c), "@@pang__beizhan-inhand", 1)
      end
    elseif player.phase == Player.Start then
      local subcard = table.filter(player:getCardIds("h"), function(id)
        local card_id = Fk:getCardById(id)
        return card_id and card_id:getMark("@@pang__beizhan-inhand") > 0
      end) > 0
      if #subcard > 0 then
        local archery_attack = Fk:cloneCard("archery_attack")
        archery_attack:addSubcards(subcard)
        room:useVirtualCard("archery_attack", archery_attack, player, player.next, beizhan.name, true)
      end
    end
  end,
})


return beizhan
