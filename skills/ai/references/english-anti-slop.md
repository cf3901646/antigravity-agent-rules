# 纯英文防 Slop 与脱水去味规则 (English Anti-Slop Dictionary)

来源融合：`stop-slop` (hardikpandya) + `humanizer v4.0.0` (blader)

## 一、 核心词汇与句式黑名单 (The Kill List)

### 1. 清嗓子开场 (Throat-Clearing Openers) - 见之即删
- "Here's the thing:"
- "Here's why [X] matters:"
- "The uncomfortable truth is"
- "It turns out that"
- "In today's fast-paced digital world / landscape"
- "Let me be clear"
- "Can we talk about"

### 2. 表演性强调 (Emphasis Crutches) - 纯属废话
- "Full stop." / "Period."
- "Let that sink in."
- "Make no mistake:"
- "This is what [X] actually looks like"

### 3. AI 滥用高危词汇 (Stock AI Vocabulary) - 换用具体朴素词
- `delve / delving into` -> `look at, examine, read`
- `tapestry / intricate tapestry` -> `mix, complexity, network`
- `pivotal beacon / testament to` -> `evidence, sign, example`
- `fundamentally / inherently / deeply / truly` -> 删去副词，由动词和名词表达强度
- `seamless integration` -> `connected tools, work together`
- `unlock synergies` -> `save time, produce results`
- `crucial / multifaceted / vibrant` -> 替换为具体事实描摹

### 4. 机械二元对立 (Binary Contrasts) - 打碎重构
- 杜绝 "Not because X, but because Y." -> 改为分别陈述两个事实。
- 杜绝 "[X] isn't the problem. [Y] is." -> 改为直接指出 Y 的具体表现。

## 二、 句法铁律

- **Active Voice First**：杜绝无主语被动句，由具体的人或模块担任施事者。
- **Kill Adverbs**：删掉 90% 的副词（especially, completely, absolutely, basically）。
