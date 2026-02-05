local danying = fk.CreateSkill {
  name = "pang__danying",
}

Fk:loadTranslationTable{
  ["pang__danying"] = "胆迎",
  [":pang__danying"] = "你可以将一张牌作为【杀】或【闪】使用，然后下次有角色使用另一牌名的牌时，其可以对你造成2点伤害。",

  ["#pang__danying"] = "胆迎：你可以视为使用【杀】或【闪】",
  ["#pang__danying_damage"] = "胆迎：你可以对 %src 造成2点伤害",
  ["@@pang_danding_jink"] = "胆迎 闪",
  ["@@pang_danding_slash"] = "胆迎 杀",


  ["$pang__danying1"] = "早就想会会你常山赵子龙了。",
  ["$pang__danying2"] = "赵子龙是吧？兜鍪给你打掉。",
}

danying:addEffect("viewas", {
  pattern = "slash,jink",
  prompt = "#pang__danying",
  interaction = function(self, player)
    local all_names = {"slash", "jink"}
    local names = player:getViewAsCardNames(danying.name, all_names)
    if #names > 0 then
      return UI.CardNameBox {choices = names, all_choices = all_names}
    end
  end,
  filter_pattern = {
    min_num = 1,
    max_num = 1,
    pattern = "",
  },
  view_as = function(self, player, cards)
    if self.interaction.data == nil then return end
    if #cards ~= 1 then return end
    local card = Fk:cloneCard(self.interaction.data)
    card.skillName = danying.name
    card:addSubcard(cards[1])
    return card
  end,
  before_use = function(self, player, use)
    local name = self.interaction.data
    if name == "slash" then
        player.room:setPlayerMark(player,"@@pang_danding_jink",1)
    else
        player.room:setPlayerMark(player,"@@pang_danding_slash",1)
    end
  end,
  enabled_at_play = function(self, player)
    return true
  end,
  enabled_at_response = function(self, player, response)
    return not response
  end,
})

danying:addEffect(fk.CardUsing, {
  can_refresh = function(self, event, target, player, data)
    return target and data.card and player:hasSkill(danying.name) 
    and (data.card.trueName == "slash" and player:getMark("@@pang_danding_slash") > 0 
    or player:getMark("@@pang_danding_jink") > 0 and data.card.trueName == "jink")
  end,
  on_refresh = function(self, event, target, player, data)
    local room = player.room
    local to = target
    room:setPlayerMark(player,"@@pang_danding_jink",0)
    room:setPlayerMark(player,"@@pang_danding_slash",0)
    if player.room:askToSkillInvoke(to,{
      prompt = "#pang__danying_damage:".. player.id,
      skill_name = danying.name,
    })
    then
        room:damage{
        from = to,
        to = player,
        damage = 2,
        skillName = danying.name,
    }
    end
  end,
})

return danying