local weizhen = fk.CreateSkill {
  name = "pang__weizhen",
}

Fk:loadTranslationTable{
  ["pang__weizhen"] = "围阵",
  [":pang__weizhen"] = "若你的登场数和对手的登场数：不同，你可以将不为【杀】的基本牌当无次数限制的雷【杀】使用；相同，你的手牌上限+1，对手的手牌上限-1。",

  ["#pang__weizhen_attack"] = "围阵：你可以将一张不为【杀】的基本牌当无次数限制的雷【杀】使用",


  ["$pang__weizhen1"] = "布阵合围，滴水不漏，待敌自溃。",
  ["$pang__weizhen2"] = "乘敌阵未稳，待我斩将刈旗，先奋士气！",
}

local U = require "packages.klee_fk_B.pkg.gamemode.klee_1v1_util"

weizhen:addEffect("viewas", {
  anim_type = "offensive",
  mute = true,
  pattern = "thunder__slash",
  prompt = "#pang__weizhen_attack",
  handly_pile = true,
  filter_pattern = {
    min_num = 1,
    max_num = 1,
    pattern = "jink,peach,analeptic",
  },
  view_as = function(self, player, cards)
    if #cards ~= 1 then return end
    local c = Fk:cloneCard("thunder__slash")
    c.skillName = weizhen.name
    c:addSubcard(cards[1])
    return c
  end,
  before_use = function(self, player, use)
    if player:usedSkillTimes(weizhen.name, Player.HistoryTurn) == 1 then
      player:broadcastSkillInvoke(weizhen.name, 2)
    end
    use.extraUse = true
  end,
  enabled_at_play = function(self, player)
    return U.getPlayercount(player)[1] ~= U.getPlayercount(player.next)[1]
  end,
  enabled_at_response = function(self, player, response)
    return not response and U.getPlayercount(player)[1] ~= U.getPlayercount(player.next)[1]
  end,
})

weizhen:addEffect("targetmod", {
  bypass_times = function(self, player, skill, scope, card)
    return card and table.contains(card.skillNames, weizhen.name)
  end,
})

weizhen:addEffect("maxcards", {
  correct_func = function(self, player)
    if player:hasSkill(weizhen.name)
    and U.getPlayercount(player)[1] == U.getPlayercount(player.next)[1] then
        return 1
    elseif player.next:hasSkill(weizhen.name)
    and U.getPlayercount(player)[1] == U.getPlayercount(player.next)[1] then
        return -1
    end
  end,
})

weizhen:addEffect(U.AfterDebut, {
  can_refresh = function(self, event, target, player, data)
    return player:hasSkill(weizhen.name) and not data.begingame
    and U.getPlayercount(player)[1] == U.getPlayercount(player.next)[1]
    
  end,
  on_refresh = function(self, event, target, player, data)
    player:broadcastSkillInvoke(weizhen.name, 1)
  end,
})



return weizhen