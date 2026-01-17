local juanxia = fk.CreateSkill {
  name = "pang__juanxia",
}

Fk:loadTranslationTable{
  ["pang__juanxia"] = "狷狭",
  [":pang__juanxia"] = "准备阶段，你可以摸一张牌，然后蜀势力角色依次选择弃置一张手牌或变更武将。",

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
    for _, p in ipairs(Fk:currentRoom().alive_players) do
      if p.kingdom == "shu" and room:getBanner(U.getGeneralsBannerName(p)) then
        local listall = U.getGenerals(p)
        local cards
        if not p:isKongcheng() then
            cards = room:askToDiscard(p, {
                skill_name = juanxia.name,
                prompt = "juanxia_discard",
                cancelable = true,
                min_num = 1,
                max_num = 1,
                include_equip = false,
            })
        end
        if (#cards == 0 or p:isKongcheng()) and #listall > 0 then
            local name = p.general
            local selected = room:askToChooseGeneral(p,{
                generals = listall,
                n = 1,
                rule = "klee_1v1_askForGeneralsChosen",
                extra_data = {
                    --prompt = "#kleeb__zhenbian_b",
                    cantchoose = {},
                }
            })
            if type(selected) == "table" then
                selected = selected[1]
            end
            U.removeGeneral(p,selected)
            U.addGeneral(p,name,nil,"dead")
            room:changeHero(p,selected)
        end
      end
    end
  end,
})

return juanxia