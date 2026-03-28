local jugu = fk.CreateSkill {
  name = "pang__jugu",
}

Fk:loadTranslationTable{
  ["pang__jugu"] = "巨贾",
  [":pang__jugu"] = "你的初始手牌不计入手牌上限且可以作为【无中生有】使用。",
  ["#pang__jugu"] = "巨贾：你可以将一张因“巨贾”获得的牌作为【无中生有】使用",
  ["@@jugu-inhand"] = "巨贾",

  ["$pang__jugu1"] = "钱！？要多少有多少！",
  ["$pang__jugu2"] = "君子爱财，取之有道。",
}

local U = require "packages.klee_fk_B.pkg.gamemode.klee_1v1_util"

jugu:addEffect(U.AfterV11DrawInitial,{
  mute = true,
  can_trigger = function (self, event, target, player, data)
    return player:hasSkill(jugu.name) and target == player and #data.cards > 0
  end,
  on_cost = Util.TrueFunc,
  on_use = function (self, event, target, player, data)
    local room = player.room
    local cards = data.cards
    for _, id in ipairs(cards) do
      room:setCardMark(Fk:getCardById(id), "@@jugu-inhand", 1)
    end
    player:broadcastSkillInvoke(jugu.name, 1)
  end,
})

jugu:addEffect("maxcards", {
  exclude_from = function(self, player, card)
    return player:hasSkill(jugu.name) and player.phase == Player.Discard and card:getMark("@@jugu-inhand") > 0
  end,
})

jugu:addEffect("viewas", {
    mute_card = true,
    mute = true,
  anim_type = "drawcard",
  pattern = "ex_nihilo",
  prompt = "#pang__jugu",
  filter_pattern = {
    min_num = 1,
    max_num = 1,
    pattern = ".",
  },
  card_filter = function(self, player, to_select, selected)
    if #selected ~= 0 then return end
    local card = Fk:getCardById(to_select)
    return card:getMark("@@jugu-inhand") > 0
  end,
  view_as = function(self, player, cards)
    if #cards ~= 1 then return nil end
    local c = Fk:cloneCard("ex_nihilo")
    c.skillName = jugu.name
    c:addSubcard(cards[1])
    return c
  end,
  before_use = function(self, player)
    player:broadcastSkillInvoke(jugu.name, 2)
  end,
  enabled_at_response = function(self, player, response)
    return not response
  end,
})


return jugu