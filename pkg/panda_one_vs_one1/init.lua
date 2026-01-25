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


local yangyi = General:new(extension, "pang__yangyi", "shu", 3, 3, General.Male)
yangyi:addSkill("pang__duoduan")
yangyi:addSkill("pang__juanxia")
Fk:loadTranslationTable{
  ["pang__yangyi"] = "杨仪",
  ["#pang__yangyi"] = "武侯长史",
  ["designer:pang__yangyi"] = "胖即是胖",
  ["illustrator:pang__yangyi"] = "官方",

  ["~pang__yangyi"] = "魏延庸奴，吾誓杀汝！",
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

local panzhangmazhong = General:new(extension, "pang__panzhangmazhong", "wu", 4, 4, General.Male)
panzhangmazhong:addSkill("pang__anjian&")
panzhangmazhong:addSkill("pang__duodao")
Fk:loadTranslationTable{
  ["pang__panzhangmazhong"] = "潘璋马忠",
  ["#pang__panzhangmazhong"] = "擒龙伏虎",
  ["designer:pang__panzhangmazhong"] = "胖即是胖",
  ["illustrator:pang__panzhangmazhong"] = "凝聚永恒",

  ["~pang__panzhangmazhong"] = "埋伏得这么好，怎会……",
}

local huayun = General:new(extension, "pang__huayun", "wei", 3, 3, General.Male)
huayun:addSkill("pang__yuanqing")
huayun:addSkill("pang__xibing")
huayun.endnote = "<font color=\"#E0DB2F\">注：通过变更上场的武将不触发登场，所以如果此武将通过变更上场会直接变成白板！</font>"
Fk:loadTranslationTable{
  ["pang__huayun"] = "华歆",
  ["#pang__huayun"] = "清素拂浊",
  ["designer:pang__huayun"] = "胖即是胖",
  ["illustrator:pang__huayun"] = "秋呆呆",

  ["~pang__huayun"] = "大举发兵，劳民伤国。",
}

local zangba = General:new(extension, "pang__zangba", "wei", 4, 4, General.Male)
zangba:addSkill("pang__hengjiang")
Fk:loadTranslationTable{
  ["pang__zangba"] = "臧霸",
  ["#pang__zangba"] = "节度青徐",
  ["designer:pang__zangba"] = "胖即是胖",
  ["illustrator:pang__zangba"] = "HOOO",

  ["~pang__zangba"] = "断刃沉江，负主重托……",
}

local shenpei = General:new(extension, "pang__shenpei", "qun", 3, 3, General.Male)
shenpei:addSkill("pang__gangshou")
shenpei:addSkill("pang__liezhi")
Fk:loadTranslationTable{
  ["pang__shenpei"] = "审配",
  ["#pang__shenpei"] = "正南义北",
  ["designer:pang__shenpei"] = "胖即是胖",
  ["illustrator:pang__shenpei"] = "官方",

  ["~pang__shenpei"] = "吾君在北，但求面北而亡！",
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



return extension