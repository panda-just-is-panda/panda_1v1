local miyun = fk.CreateSkill {
  name = "pang__miyun",
}

Fk:loadTranslationTable{
  ["pang__miyun"] = "密运",
  [":pang__miyun"] = "当你登场后，你可以摸一张牌并展示之；六轮结束后，你可以展示此牌并令登场数-1，然后你退场。",

  ["#pang__miyun"] = "密运：你可以摸一张牌并展示之",
  ["#pang__miyun-leave"] = "密运：你可以令登场数-1并退场",
  ["@@pang__miyun"] = "密运",
  ["@pang__miyun_count"] = "密运",


  ["$pang__miyun1"] = "不要大张旗鼓，要神不知鬼不觉。",
  ["$pang__miyun2"] = "小阿斗，跟本将军走一趟吧。",
}

local U = require "packages.klee_fk_B.pkg.gamemode.klee_1v1_util"

miyun:addEffect(U.AfterDebut,{
  can_trigger = function (self, event, target, player, data)
    return player:hasSkill(miyun.name) and target == player
      and not data.begingame
  end,
  on_cost = function (self, event, target, player, data)
    return player.room:askToSkillInvoke(player,{
      prompt = "#pang__miyun",
      skill_name = miyun.name,
    })
  end,
  on_use = function (self, event, target, player, data)
    local room = player.room
    local card = player:drawCards(1, miyun.name, nil, "@@pang__miyun")
    player:showCards(card)
  end,
})

miyun:addEffect(fk.RoundEnd,{
  can_trigger = function (self, event, target, player, data)
    return player:hasSkill(miyun.name,true)
  end,
  on_cost = function (self, event, target, player, data)
    if player:getMark("@pang__miyun_count") < 6 then player.room:addPlayerMark(player,"@pang__miyun_count", 1) end
    if player:getMark("@pang__miyun_count") > 5 and player:hasSkill(miyun.name) then
        if table.find(player:getCardIds("h"), function (id)
        return Fk:getCardById(id):getMark("@@pang__miyun") > 0
      end) and player.room:askToSkillInvoke(player,{
            prompt = "#pang__miyun-leave:".. player.id,
            skill_name = miyun.name,
        }) then
            player.room:setPlayerMark(player,"@pang__miyun_count", 0)
            return true
        end
    end
  end,
  on_use = function (self, event, target, player, data)
    local room = player.room
    U.addPlayercount(player,-1,0)
    U.PlayerDebut(player,miyun.name,false)
  end,
})

miyun:addLoseEffect(function (self, player, is_death)
  for _, id in ipairs(player:getCardIds("h")) do
    player.room:setCardMark(Fk:getCardById(id), "@@pang__miyun", 0)
  end
  for _, id in ipairs(player.room.discard_pile) do
    player.room:setCardMark(Fk:getCardById(id), "@@pang__miyun", 0)
  end
  for _, id in ipairs(player.room.draw_pile) do
    player.room:setCardMark(Fk:getCardById(id), "@@pang__miyun", 0)
  end
end)

return miyun