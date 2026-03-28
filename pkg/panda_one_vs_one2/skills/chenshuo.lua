local chenshuo = fk.CreateSkill{
  name = "pang__chenshuo",
}

Fk:loadTranslationTable{
  ["pang__chenshuo"] = "谶说",
  [":pang__chenshuo"] = "一名角色的判定牌生效前，你可以重铸一张类型相同的牌并修改判定结果的花色。",

  ["#pang__chenshuo-ask1"] = "谶说：你可以重铸一张基本牌，修改 %dest 的 %arg 判定花色",
  ["#pang__chenshuo-ask2"] = "谶说：你可以重铸一张锦囊牌，修改 %dest 的 %arg 判定花色",
  ["#pang__chenshuo-ask3"] = "谶说：你可以重铸一张装备牌，修改 %dest 的 %arg 判定花色",
  ["#pang__chenshuo-choice"] = "谶说：修改 %dest 进行 %arg 判定结果的花色",

  ["$pang__chenshuo1"] = "命数玄奥，然吾可言之。",
  ["$pang__chenshuo2"] = "天地神鬼之辩，在吾唇舌之间。",
}


chenshuo:addEffect(fk.AskForRetrial, {
  guicai = "control",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(chenshuo.name) and not player:isNude()
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local cards 
    if data.card.type == Card.TypeBasic then
        cards = room:askToCards(player, {
            min_num = 1,
            max_num = 1,
            skill_name = chenshuo.name,
            include_equip = true,
            pattern = ".|.|.|.|.|basic",
            prompt = "#pang__chenshuo-ask1::"..target.id..":"..data.reason,
            cancelable = true,
        })
    elseif data.card.type == Card.TypeTrick then
        cards = room:askToCards(player, {
            min_num = 1,
            max_num = 1,
            skill_name = chenshuo.name,
            include_equip = true,
            pattern = ".|.|.|.|.|trick",
            prompt = "#pang__chenshuo-ask2::"..target.id..":"..data.reason,
            cancelable = true,
        })
    elseif data.card.type == Card.TypeEquip then
        cards = room:askToCards(player, {
            min_num = 1,
            max_num = 1,
            skill_name = chenshuo.name,
            include_equip = true,
            pattern = ".|.|.|.|.|equip",
            prompt = "#pang__chenshuo-ask3::"..target.id..":"..data.reason,
            cancelable = true,
        })
    end
    if #cards > 0 then
      room:recastCard(cards, player, chenshuo.name)
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local suits = { "log_spade", "log_club", "log_heart", "log_diamond" }
    local choice = room:askToChoice(
      player,
      {
        choices = suits,
        skill_name = chenshuo.name,
        prompt = "#pang__chenshuo-choice::" .. target.id .. ":" .. data.reason
      }
    )
    local new_card = Fk:cloneCard(data.card.name, table.indexOf(suits, choice), data.card.number)
    new_card.skillName = chenshuo.name
    new_card.id = data.card.id
    data.card = new_card
    room:sendLog{
      type = "#ChangedJudge",
      from = player.id,
      to = { data.who.id },
      arg2 = new_card:toLogString(),
      arg = chenshuo.name,
    }
  end,
})

return chenshuo