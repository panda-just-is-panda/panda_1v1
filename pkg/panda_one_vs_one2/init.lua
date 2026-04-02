local extension = Package:new("panda_one_vs_one2")
extension.extensionName = "panda_one_vs_one"
extension:loadSkillSkelsByPath("./packages/panda_one_vs_one/pkg/panda_one_vs_one2/skills")
extension.game_modes_whitelist = {
  "klee_1v1",
}

Fk:loadTranslationTable{
  ["panda_one_vs_one2"] = "胖胖扩",
  ["pang"] = "胖",
}


local zhouqun = General:new(extension, "pang__zhouqun", "shu", 3, 3, General.Male)
zhouqun:addSkill("pang__tiansuan")
zhouqun:addSkill("pang__chenshuo")
Fk:loadTranslationTable{
  ["pang__zhouqun"] = "周群",
  ["#pang__zhouqun"] = "占天明徵",
  ["designer:pang__zhouqun"] = "胖即是胖",
  ["illustrator:pang__zhouqun"] = "官方",

  ["~pang__zhouqun"] = "知万物而不知己命，大谬也。",
}

local zhangyi = General:new(extension, "pang__zhangyi", "shu", 4, 4, General.Male)
zhangyi:addSkill("pang__aorui")
Fk:loadTranslationTable{
  ["pang__zhangyi"] = "张翼",
  ["#pang__zhangyi"] = "执忠守义",
  ["designer:pang__zhangyi"] = "胖即是胖",
  ["illustrator:pang__zhangyi"] = "官方",

  ["~pang__zhangyi"] = "大汉，万胜！",
}

local lvfan = General:new(extension, "pang__lvfan", "wu", 3, 3, General.Male)
lvfan:addSkill("pang__diaodu")
lvfan:addSkill("pang__diancai")
Fk:loadTranslationTable{
  ["pang__lvfan"] = "吕范",
  ["#pang__lvfan"] = "持筹廉悍",
  ["designer:pang__lvfan"] = "胖即是胖",
  ["illustrator:pang__lvfan"] = "官方",

  ["~pang__lvfan"] = "闻主公欲授大司马之职，容臣不能……谢恩了。",
}
local sunhuan = General:new(extension, "pang__sunhuan", "wu", 4, 4, General.Male)
sunhuan:addSkill("pang__eyao")
Fk:loadTranslationTable{
  ["pang__sunhuan"] = "孙桓",
  ["#pang__sunhuan"] = "扼龙决险",
  ["designer:pang__sunhuan"] = "胖即是胖",
  ["illustrator:pang__sunhuan"] = "官方",

  ["~pang__sunhuan"] = "此建功立业之时，奈何。",
}

local jiangji = General:new(extension, "pang__jiangji", "wei", 3, 3, General.Male)
jiangji:addSkill("pang__jichou")
jiangji:addSkill("pang__jilun")
Fk:loadTranslationTable{
  ["pang__jiangji"] = "蒋济",
  ["#pang__jiangji"] = "盛魏昌杰",
  ["designer:pang__jiangji"] = "胖即是胖",
  ["illustrator:pang__jiangji"] = "官方",

  ["~pang__jiangji"] = "洛水之誓，言犹在耳……咳咳咳……",
}

local zhuling = General:new(extension, "pang__zhuling", "wei", 4, 4, General.Male)
zhuling:addSkill("pang__weizhen")
Fk:loadTranslationTable{
  ["pang__zhuling"] = "朱灵",
  ["#pang__zhuling"] = "良将之亚",
  ["designer:pang__zhuling"] = "胖即是胖",
  ["illustrator:pang__zhuling"] = "官方",

  ["~pang__zhuling"] = "母亲，弟弟，我来了……",
}

local shenpei = General:new(extension, "pang__shenpei", "qun", 3, 3, General.Male)
shenpei:addSkill("pang__beizhan")
shenpei:addSkill("pang__liezhi")
Fk:loadTranslationTable{
  ["pang__shenpei"] = "审配",
  ["#pang__shenpei"] = "正南义北",
  ["designer:pang__shenpei"] = "胖即是胖",
  ["illustrator:pang__shenpei"] = "官方",

  ["~pang__shenpei"] = "吾君在北，但求面北而亡！",
}

local zhangmancheng = General:new(extension, "pang__zhangmancheng", "qun", 4, 4, General.Male)
zhangmancheng:addSkill("pang__zhongji")
zhangmancheng:addSkill("pang__lvecheng")
Fk:loadTranslationTable{
  ["pang__zhangmancheng"] = "张曼成",
  ["#pang__zhangmancheng"] = "蚁萃宛洛",
  ["designer:pang__zhangmancheng"] = "胖即是胖",
  ["illustrator:pang__zhangmancheng"] = "官方",

  ["~pang__zhangmancheng"] = "逡巡不前，坐以待毙。",
}


return extension