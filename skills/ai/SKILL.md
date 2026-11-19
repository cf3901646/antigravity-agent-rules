---
name: ai
description: 全场景智能去 AI 味、降低 AI 率与拟人化写作调度技能 (/ai)。【强语义自动意图监听】：当用户输入以 /ai、/humanize、/unslop 开头，或在对话中出现“去AI味”、“降低AI率”、“改得像人写的”、“降重”、“去机器感”、“消除套话”时强制自动激活。内置六维场景自动路由器，智能分流调度：学术技术（严谨保真）、自媒体推文（生活烟火气）、深度专栏（学者质感）、人物蒸馏（心智灵魂注入）、纯英文（Stop-Slop 脱水）与前端 UI（拒绝廉价模板），并基于 HC3 数据集执行特征量化自检。
metadata:
  trigger: "/ai, /humanize, /unslop, 去AI味, 降低AI率, 消除AI痕迹, 改得像人写的, 降重"
  version: "1.0.0"
---

# 全场景智能去 AI 味与拟人化写作调度引擎 (/ai)

本技能聚合了业界顶尖去 AI 味开源生态（Humanizer-zh、shuorenhua、stop-slop、nuwa-skill、ai-flavor-remover、De-AI-Prompt 等）的核心精髓，建立“意图识别 -> 场景路由 -> 精准手术刀改写 -> HC3 指标自检”的端到端去味闭环。

---

## 一、 场景自动路由器 (Auto-Routing Engine)

当接收到待处理文本、大纲或改写请求时，智能体首先识别输入特征并自动分流至最适引擎（可根据用户显式指定的风格强制覆盖）：

| 识别特征 / 触发场景 | 目标引擎与参考文件 | 核心指导原则与杀手锏 |
| :--- | :--- | :--- |
| **学术论文、技术文档、架构方案、公文汇报、代码注释** | [technical-guardrail.md](references/technical-guardrail.md) | **零造假、保留事实与确定性**。不增删数据与否定逻辑，保护接口/代码，切除假大空空话与“不仅……而且” |
| **微信公众号、小红书、经验分享、科普推文** | [pop-life-injection.md](references/pop-life-injection.md) | **注入生活细节与人情味**。长短句错落，引入感官细节与具象场景，打碎均匀死板的 AI 韵律 |
| **深度书评、行业专栏、严肃随笔、独立思考** | [intellectual-prose.md](references/intellectual-prose.md) | **学者风骨与绵密厚段**。半文半白、事实先行、冷面热心，情绪压在判断里，拒绝浮夸感叹与网梗 |
| **指定人物或口吻**（如“用老罗口吻”、“鲁迅风”、“乔布斯式”） | [nuwa-distillation.md](references/nuwa-distillation.md) | **女娲心智蒸馏**。激活目标人物心智模型、口癖与典型招式，以强烈人格降维击碎机器模板感 |
| **纯英文文本、英文邮件、英文出海文案** | [english-anti-slop.md](references/english-anti-slop.md) | **斩断 Throat-clearing 与 Emphasis Crutches**。严打 "Here's the thing"、"Not X. But Y."、"delve" |
| **前端代码、Vue/React 页面、Landing Page、UI 样式** | [frontend-anti-slop.md](references/frontend-anti-slop.md) | **工业级商业审美**。单屏一业务块、拒绝廉价渐变紫与无意义发光、采用真实摄影与严格字阶 |

---

## 二、 通用“去 AI 味”四大手术刀铁律 (Universal Invariants)

无论处于何种细分场景，改写时必须严格遵守以下四大硬性底线：

1. **斩断报幕式清嗓子开场 (Throat-Clearing Openers)**：
   - 彻底删除“在当今瞬息万变的数字化时代”、“毋庸置疑的是”、“值得注意的是”、“众所周知”、“随着科技的飞速发展”；
   - 英文彻底删除 "In today's fast-paced digital landscape"、"Here's the thing:"、"It turns out that"；
   - **执行**：第一句直接切入具体事实或核心论点。
2. **切除虚假二元对立结构 (Binary Contrasts)**：
   - 严禁“不是……而是……”、“不仅……而且……”、“并非非黑即白，而是机遇与挑战并存”；
   - 英文严禁 "Not because X. But because Y."、"It's not this. It's that."、"isn't the problem, Y is"；
   - **执行**：拆解为两个平实的独立判断，或保留实质信息，删去机械对抗词。
3. **消除口号式总结与表演性强调 (Performative Closers)**：
   - 彻底删除“总而言之”、“让我们携手共进”、“让我们拭目以待”、“综上所述”、“书写壮丽篇章”；
   - 英文彻底删除 "Let that sink in."、"Make no mistake"、"Full stop."、"At the end of the day"；
   - **执行**：文章自然收束于事实落点或推导结论，严禁无意义的情感升华。
4. **打碎均匀单调的“机器人脉搏” (Rhythm Shattering)**：
   - AI 文本最致命的破绽是**句长方差极小**（每一句字数几乎相等，形成催眠节奏）；
   - **执行**：必须强制使用长短句穿插——单字/极短句换气定性（“事实并非如此。”、“很难。”），中长句展开严密论证，形成自然的人类心跳节奏。

---

## 三、 工作流与交付规约 (Standard Operating Procedure)

1. **第 1 步：场景判定**
   - 快速审视用户输入的文本类型与语气偏好，命中对应的子策略引擎；若用户明确指明人物或文风，优先以用户指定为准。
2. **第 2 步：精细手术刀改写**
   - 对照四大铁律与子策略手册，清洗套路句式、调整句长方差、注入匹配场景的生活细节或学者论证。
3. **第 3 步：指标自检与双交付**
   - 对改写成稿进行快速自检，对照 [hc3-indicators-gate.md](references/hc3-indicators-gate.md) 特征词库；
   - 交付格式规范：
     - **【去 AI 味终稿】**：改写后的纯文本，排版干净，供用户直接复制使用；
     - **【改写简报与自查】**：用 1 至 2 句话标明所选场景、核心剔除项与 AI 痕迹密度预估变化。
