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

local zhoushan = General:new(extension, "pang__zhoushan", "wu", 4, 4, General.Male)
zhoushan:addSkill("pang__miyun")
zhoushan:addSkill("pang__danying")
Fk:loadTranslationTable{
  ["pang__zhoushan"] = "周善",
  ["#pang__zhoushan"] = "荆吴刑天",
  ["designer:pang__zhoushan"] = "胖即是胖",
  ["illustrator:pang__zhoushan"] = "游漫美绘",

  ["~pang__zhoushan"] = "夫人救我！夫人救我！",
}

local jiakui = General:new(extension, "pang__jiakui", "wei", 3, 3, General.Male)
jiakui:addSkill("pang__tongqu")
jiakui:addSkill("pang__wanlan")
Fk:loadTranslationTable{
  ["pang__jiakui"] = "贾逵",
  ["#pang__jiakui"] = "肃齐万里",
  ["designer:pang__jiakui"] = "胖即是胖",
  ["illustrator:pang__jiakui"] = "monkey",

  ["~pang__jiakui"] = "不斩孙权，九泉之下羞见先帝啊。",
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

local wangyun = General:new(extension, "pang__wangyun", "qun", 3, 3, General.Male)
wangyun:addSkill("pang__lianji&")
wangyun:addSkill("pang__jingong")
Fk:loadTranslationTable{
  ["pang__wangyun"] = "王允",
  ["#pang__wangyun"] = "恃功自傲",
  ["designer:pang__wangyun"] = "胖即是胖",
  ["illustrator:pang__wangyun"] = "官方",

  ["~pang__wangyun"] = "逆贼何必多言，今日有死而已！",
}

local zhurong = General:new(extension, "pang__zhurong", "qun", 4, 4, General.Female)
zhurong:addSkill("pang__lieren")
zhurong:addSkill("pang__manyi")
Fk:loadTranslationTable{
  ["pang__zhurong"] = "祝融",
  ["#pang__zhurong"] = "野性的女王",
  ["designer:pang__zhurong"] = "胖即是胖",
  ["illustrator:pang__zhurong"] = "官方",

  ["~pang__zhurong"] = "大王，这诸葛亮，果然厉害……",
}

local wangyuanji = General:new(extension, "pang__wangyuanji", "jin", 3, 3, General.Female)
wangyuanji:addSkill("pang__qianchong")
wangyuanji:addSkill("pang__shangjian")
Fk:loadTranslationTable{
  ["pang__wangyuanji"] = "王元姬",
  ["#pang__wangyuanji"] = "清雅抑华",
  ["designer:pang__wangyuanji"] = "胖即是胖",
  ["illustrator:pang__wangyuanji"] = "官方",

  ["~pang__wangyuanji"] = "世事沉浮，非是一人可逆啊。",
}

local wangjun = General:new(extension, "pang__wangjun", "jin", 4, 4, General.Male)
wangjun:addSkill("pang__jianshi")
wangjun:addSkill("pang__changqu")
Fk:loadTranslationTable{
  ["pang__wangjun"] = "王濬",
  ["#pang__wangjun"] = "遏浪飞艨",
  ["designer:pang__wangjun"] = "胖即是胖",
  ["illustrator:pang__wangjun"] = "官方",

  ["~pang__wangjun"] = "未蹈曹刘之辙，险遭士载之厄。",
}



return extension