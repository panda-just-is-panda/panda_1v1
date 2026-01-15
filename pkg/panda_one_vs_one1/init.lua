local extension = Package:new("panda_one_vs_one1")
extension.extensionName = "panda_one_vs_one"
extension:loadSkillSkelsByPath("./packages/panda_one_vs_one/pkg/panda_one_vs_one1/skills")
extension.game_modes_whitelist = {
  "klee_1v1",
}

Fk:loadTranslationTable{
  ["panda_one_vs_one1"] = "胖胖扩",
  ["pang"] = "胖",
}

local gaoshun = General:new(extension, "pang__gaoshun", "qun", 4, 4, General.Male)
gaoshun:addSkill("pang__xianzhen")
Fk:loadTranslationTable{
  ["pang__gaoshun"] = "高顺",
  ["#pang__gaoshun"] = "攻无不克",
  ["designer:pang__gaoshun"] = "胖即是胖",
  ["illustrator:pang__gaoshun"] = "鄧Sir",

  ["~pang__gaoshun"] = "生死有命……",
}

local weiyan = General:new(extension, "pang__weiyan", "shu", 4, 4, General.Male)
weiyan:addSkill("pang__qimou")
Fk:loadTranslationTable{
  ["pang__weiyan"] = "魏延",
  ["#pang__weiyan"] = "嗜血的独狼",
  ["designer:pang__weiyan"] = "胖即是胖",
  ["illustrator:pang__weiyan"] = "瞌瞌一休",

  ["~pang__weiyan"] = "汝，且勿为杨仪奸计所蔽……呃啊！",
}

local sunshangxiang = General:new(extension, "pang__sunshangxiang", "wu", 3, 3, General.Female)
sunshangxiang:addSkill("pang__xiaoji")
sunshangxiang:addSkill("pang__saying")
Fk:loadTranslationTable{
  ["pang__sunshangxiang"] = "孙尚香",
  ["#pang__sunshangxiang"] = "弓腰姬",
  ["designer:pang__sunshangxiang"] = "胖即是胖",
  ["illustrator:pang__sunshangxiang"] = "Thinking",

  ["~pang__sunshangxiang"] = "哎呀，这次弓箭射歪了。",
}

local yujin = General:new(extension, "pang__yujin", "wei", 4, 4, General.Male)
yujin:addSkill("pang__zhenjun")
yujin:addSkill("pang__yizhong")
Fk:loadTranslationTable{
  ["pang__yujin"] = "于禁",
  ["#pang__yujin"] = "讨暴坚垒",
  ["designer:pang__yujin"] = "胖即是胖",
  ["illustrator:pang__yujin"] = "biou09",

  ["~pang__yujin"] = "如今临危处难，却负丞相三十年之赏识，唉……",
}



return extension