local zhenjun = fk.CreateSkill {
  name = "pang__zhenjun&",
  tags = {"kSupport"}
}

Fk:loadTranslationTable{
  ["pang__zhenjun&"] = "镇军",
  [":pang__zhenjun&"] = "备场技，一名角色登场后，你可以观看其手牌并弃置其中任意张，然后其摸等量张牌。",
  ["#pang__zhenjun&"] = "镇军：你可以观看 %src 手牌并弃置其中任意张，然后 %src 摸等量张牌",

  ["$pang__zhenjun&1"] = "按丞相之命，此部今由余统摄！",
  ["$pang__zhenjun&2"] = "奉法行令，事上之节，岂有宽宥之理？",
}

local U = require "packages.klee_fk_B.pkg.gamemode.klee_1v1_util"

zhenjun:addEffect(U.AfterDebut,{
  can_trigger = function (self, event, target, player, data)
    return player:hasSkill(zhenjun.name) and player.room:getBanner(U.getGeneralsBannerName(player))
      and not data.begingame
  end,
  on_cost = function (self, event, target, player, data)
    return player.room:askToSkillInvoke(player,{
      prompt = "#pang__zhenjun&::"..target.id,
      skill_name = zhenjun.name,
    })
  end,
  on_use = function (self, event, target, player, data)
    local room = player.room
    local cards = room:askToChooseCards(player, {
      target = target,
      min = 0,
      max = 999,
      flag = { card_data = { { "$Hand", target.player_cards[Player.Hand] } } },
      skill_name = zhenjun.name,
    })
    room:throwCard(cards, zhenjun.name, target, player)
    target:drawCards(#cards, zhenjun.name)
  end,
})

return zhenjun