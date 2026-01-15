local duodao = fk.CreateSkill {
  name = "pang__duodao",
}

Fk:loadTranslationTable{
  ["pang__duodao"] = "夺刀",
  [":pang__duodao"] = "当你登场时，你可以获得对手一张牌；若为武器牌，其不能响应你使用的【杀】直到你或其退场。",
  ["#pang__duodao"] = "夺刀：你可以获得对手一张牌，若为武器牌则其不能响应你使用的【杀】",
  ["#pang__duodao_select"] = "选择其中任意张牌",
  ["@@pang__duodao"] = "被夺刀",

  ["$pang__duodao1"] = "避其锋芒，夺其兵刃！",
  ["$pang__duodao2"] = "好兵器啊！哈哈哈！",
}

local U = require "packages.klee_fk_B.pkg.gamemode.klee_1v1_util"

duodao:addEffect(U.AfterDebut,{
  can_trigger = function (self, event, target, player, data)
    return player:hasSkill(duodao.name) and target == player
      and not data.begingame and not player.next:isNude()
  end,
  on_cost = function (self, event, target, player, data)
    return player.room:askToSkillInvoke(player,{
      prompt = "#pang__duodao",
      skill_name = duodao.name,
    })
  end,
  on_use = function (self, event, target, player, data)
    local room = player.room
    local to = player.next
    local id = room:askToChooseCard(player, {
          target = to,
          flag = "he",
          skill_name = duodao.name,
        })
    room:obtainCard(player, id, false, fk.ReasonPrey, player, duodao.name)
    if Fk:getCardById(id).sub_type == Card.SubtypeWeapon then
        room:addPlayerMark(to, "@@pang__duodao", 1)
    end
  end,
})

duodao:addEffect(U.Farewell, {
  can_refresh = function (self, event, target, player, data)
    return player:hasSkill(duodao.name,true,true)
  end,
  on_refresh = function (self, event, target, player, data)
    player.room:setPlayerMark(target, "@@pang__duodao", 0)
  end,
})

duodao:addEffect(fk.CardUsing, {
  anim_type = "offensive",
  can_refresh = function(self, event, target, player, data)
    return target == player and player:hasSkill(duodao.name) and
      data.card.trueName == "slash" and player.next:getMark("@@pang__duodao") > 0
  end,
  on_refresh = function(self, event, target, player, data)
    data.disresponsiveList = {player.next}
  end,
})

return duodao