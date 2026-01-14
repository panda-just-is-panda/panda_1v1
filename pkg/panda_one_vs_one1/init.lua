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




return extension