local xiaoji = fk.CreateSkill {
  name = "pang__xiaoji",
}

Fk:loadTranslationTable{
  ["pang__xiaoji"] = "枭姬",
  [":pang__xiaoji"] = "当你登场时，你可以获得弃牌堆中的所有装备牌。",
  ["#pang__xiaoji"] = "枭姬：你可以获得弃牌堆中的所有装备牌",


  ["$pang__xiaoji1"] = "剑利弓急，你可打不过我的。",
  ["$pang__xiaoji2"] = "我会的武器，可多着呢。",
}

local U = require "packages.klee_fk_B.pkg.gamemode.klee_1v1_util"

xiaoji:addEffect(U.AfterDebut, {
  can_trigger = function (self, event, target, player, data)
    return target == player and player:hasSkill(xiaoji.name)
  end,
  on_cost = function (self, event, target, player, data)
    return player.room:askToSkillInvoke(player,{
      prompt = "#pang__xiaoji",
      skill_name = xiaoji.name,
    })
  end,
  on_use = function (self, event, target, player, data)
    local room = player.room
    local cards = table.filter(room.discard_pile, function (id)
        local card = Fk:getCardById(id)
        return card.type == Card.TypeEquip
    end)
    if #cards > 0 then
        room:obtainCard(player, cards, false, fk.ReasonJustMove, player, xiaoji.name)
    end
  end,
})

return xiaoji