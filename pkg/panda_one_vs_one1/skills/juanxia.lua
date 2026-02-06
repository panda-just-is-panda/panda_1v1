local juanxia = fk.CreateSkill {
  name = "pang__juanxia",
}

Fk:loadTranslationTable{
  ["pang__juanxia"] = "狷狭",
  [":pang__juanxia"] = "准备阶段，你可以摸一张牌，然后蜀势力角色依次需弃置一张手牌，否则变更武将并将被变更的武将置入流放区。",

  ["#pang__juanxia"] = "狷狭：你可以摸一张牌，然后令蜀势力角色各弃置手牌或变更武将",
  ["juanxia_discard"] = "狷狭：你需弃置一张手牌，否则变更武将",


  ["$pang__juanxia1"] = "放之海内，知我者少、同我者无，可谓高处胜寒。",
  ["$pang__juanxia2"] = "满堂朱紫，能文者不武，为将者少谋，唯吾兼备。",
}

local U = require "packages.klee_fk_B.pkg.gamemode.klee_1v1_util"

juanxia:addEffect(fk.EventPhaseStart, {
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(juanxia.name) and
      player.phase == Player.Start
  end,
  on_cost = function (self, event, target, player, data)
    return player.room:askToSkillInvoke(player,{
      prompt = "#pang__juanxia",
      skill_name = juanxia.name,
    })
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    player:drawCards(1, juanxia.name)
    for _, p in ipairs({player, player.next}) do
      if p.kingdom == "shu" and room:getBanner(U.getGeneralsBannerName(p)) then
        local listall = U.getGenerals(p)
        local cards = room:askToDiscard(p, {
                skill_name = juanxia.name,
                prompt = "juanxia_discard",
                cancelable = #listall > 0 and true or false,
                min_num = 1,
                max_num = 1,
                include_equip = false,
            })
        if #cards == 0 and #listall > 0 then
          local name = p.general
            U.AskToChangeGeneral(p,juanxia.name,listall)
            U.removeGeneral(p,name)
            U.addGeneral(p,name,{state = "dead"})
          end
      end
    end
  end,
})

return juanxia