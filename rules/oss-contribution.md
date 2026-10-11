---
trigger: model_decision
description: 开源项目代码贡献与 Pull Request 交付硬性准则。在探索开源 Issue、编写补丁、提交 PR 或排查审查意见时强制遵守，彻底杜绝死代码、Windows 路径偏见、正则修补与反 AI 红线。
---

# 开源项目代码贡献与 Pull Request 交付硬性红线

在为第三方或开源项目编写补丁、测试与提交 Pull Request (PR) 时，必须无条件遵循以下六大红线：

---

### 一、 绝不提交不可达的“架子代码”（Zero Dead Code & Zero Reachability Gaps）
1. **拒绝无消费者的纯模型**：严禁为了“显得功能完备”而新增仅在测试中被调用的结构体、枚举变体、配置项或接口。
2. **完整可达调用链**：任何新增代码必须有真实的业务上下文和生产消费者。若仅完成了数据层而未打通业务链路，严禁提交到 upstream。

---

### 二、 严防 Windows 宿主环境假象（Host OS Bias & Cross-Platform Invariants）
1. **跨平台路径语义隔离**：在 Windows 本地开发时，严禁使用依赖本地平台特性的路径或文件系统 API（如 Rust 中的 `Component::Prefix`、盲目依赖反斜杠 `\` 或驱动器号 `C:`）去校验面向全平台的逻辑。
2. **Linux/macOS 行为对齐**：路径校验、换行符处理及环境探测逻辑，必须显式在 POSIX / Linux / macOS 规范下进行边界测试，确保 CI 一次性全绿。

---

### 三、 凭据安全防御（Credential Redaction & Zero Plaintext Secrets）
1. **禁止默认打印凭据**：凡包含 `token`、`secret`、`password` 等认证凭据的结构体，严禁直接派生裸 `Debug`。必须显式重写 Debug，将敏感信息打印为 `<redacted>`。
2. **禁止持久化外泄**：结构体若支持序列化（如 `Serialize`），敏感凭据字段必须配置跳过序列化（如 `#[serde(skip)]`），杜绝因持久化或日志导致明文上盘。

---

### 四、 拒绝脆弱的正则修补（No Fragile Regex Patching for Syntactic Structures）
1. **禁止用正则对抗复杂语法**：对于 Shell 命令、cURL 选项、嵌套引号、URL 结构及 JSON/XML 字符串，严禁使用粗暴的全局正则表达式进行“打补丁式替换”。
2. **采用状态机或 AST**：解析类缺陷必须基于词法状态机、逐字符 Scanner 或官方 AST 树进行精确边界识别，杜绝“修好一个特例却引入三个常规回归”的震荡改动。

---

### 五、 规范保真与标准兼容（Standards Round-Trip & Benchmark Defense）
1. **标准规范不可妥协**：网络、协议与 URL 处理必须严格对照 RFC 或 WHATWG 规范（例如：必须转义多余开首斜杠以阻断浏览器折叠引发的 Open Redirect；反斜杠必须按 `%5C` 独立转义以保证与 `unquote()` 100% 还原一致）。
2. **防性能劣化**：在包含微基准（如 CodSpeed）的成熟项目中，提交前必须评估改动的时间与空间复杂度，严禁在关键路径上引入性能回退。

---

### 六、 开源生态准入与反 AI 垃圾红线（Community Pre-Flight & Anti-Spam Gate）
1. **严格阅读 CONTRIBUTING.md**：提交前必须核实上游仓库贡献政策。明确要求“必须先开 Issue 讨论并达成设计共识”的仓库，严禁不打招呼直接提交 PR。
2. **规避明确反 AI 的保守组织**：对带有强烈反 AI 提交倾向、曾将自动化补丁列为 `rejected AI` 的组织（如 Pallets），严禁发起冷启动 PR。
3. **剔除公式化八股**：PR 标题与正文严禁使用机械浮夸的 AI 模板语言，直击要害陈述：复现路径、根因定位、修复原理、测试验证结果。
