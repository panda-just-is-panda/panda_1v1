local jianshi = fk.CreateSkill {
  name = "pang__jianshi",
}

Fk:loadTranslationTable{
  ["pang__jianshi"] = "舰势",
  [":pang__jianshi"] = "准备阶段，你可以依次重铸至多两张牌，然后你可以依次使用至多X张【杀】（X为你装备区内的牌数）。",

  ["#jianshi_recast1"] = "舰势：你可以依次重铸至多两张牌（第1张）",
  ["#jianshi_recast2"] = "舰势：你可以依次重铸至多两张牌（第2张）",
  ["@@jianshi_slash-phase"] = "舰势",
  ["#jianshi_use1"] = "舰势：你可以使用至多两张【杀】（第1张）",
  ["#jianshi_use2"] = "舰势：你可以使用至多两张【杀】（第2张）",


  ["$pang__jianshi1"] =  "修橹筑楼舫，伺时补金瓯。",
  ["$pang__jianshi2"] = "连舫披金甲，王气自可收。",
}

local U = require "packages.klee_fk_B.pkg.gamemode.klee_1v1_util"

jianshi:addEffect(fk.EventPhaseStart, {
  mute = true,
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(jianshi.name) and
      player.phase == Player.Start
  end,
  on_cost = function (self, event, target, player, data)
    local id = player.room:askToCards(player, {
          skill_name = jianshi.name,
          prompt = "#jianshi_recast1",
          cancelable = true,
          min_num = 1,
          max_num = 1,
          include_equip = true,
        })
    if #id > 0 then
        event:setCostData(self, {cards = {id}})
        return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local card1 = event:getCostData(self).cards[1]
    room:recastCard(card1, player, jianshi.name,nil)
    player:broadcastSkillInvoke(jianshi.name, 1)
    local card2 = player.room:askToCards(player, {
          skill_name = jianshi.name,
          prompt = "#jianshi_recast2",
          cancelable = true,
          min_num = 1,
          max_num = 1,
          include_equip = true,
    })
    if #card2 > 0 then
        room:recastCard(card2, player, jianshi.name)
    end
    if #player:getCardIds("e") > 0 then
        player:broadcastSkillInvoke(jianshi.name, 2)
        local use = room:askToUseCard(player, {
            skill_name = jianshi.name,
            pattern = "slash",
            prompt = "#jianshi_use1",
            extra_data = {
                bypass_times = true,
            }
        })
        if use and #player:getCardIds("e") > 0 then
            local use = room:askToUseCard(player, {
                skill_name = jianshi.name,
                pattern = "slash",
                prompt = "#jianshi_use2",
                extra_data = {
                    bypass_times = true,
                }
            })
        end
    end
  end,
})

return jianshi