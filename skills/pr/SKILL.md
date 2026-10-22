---
name: pr
description: 全自动开源 Issue 修复与 Pull Request 端到端交付模式。当用户输入 /pr 或要求“开源修Bug”、“帮他们修Issue”、“提PR”时激活。无需人工繁琐干预，一键全自动自主闭环：自动抢修存量 PR 红灯 CI -> 筛选 1000+ Star 真实无争议 Bug -> uv 轻量秒级隔离复现 -> 根因修复与回归单测 -> 本地 Linter 零报错门禁 -> 规范保真交付上游 PR -> 自主连续推进下一个。内嵌非交互防卡死、换行符防漂移、引号防崩溃及上游频控智能换道等全部工业级防御。
---

# 全自动开源 Bug 修复与 PR 交付模式 (/pr)

本模式是一套**全自动、流水线式、零假死、规范保真**的工业级开源项目贡献作业程序。
触发后智能体自主贯通全流程，以闭环产出真实合并级 PR 为导向，严禁中途频繁中断。

---

## 一、 触发指令与环境变量防线

- **触发词**：`/pr`、自然语言（“去修开源Bug”、“帮GitHub修Issue提PR”）
- **全局非交互防御（强制首行执行）**：
  ```powershell
  $env:GIT_TERMINAL_PROMPT='0'; $env:GH_NO_PROMPT='1'; $env:CI='true'; $env:PIP_NO_INPUT='1'
  ```

---

## 二、 全自动六阶段执行流水线 (Autonomous Pipeline)

### 阶段 1：存量 PR 门禁自动巡检与自愈 (Self-Healing Existing PRs)
1. 执行 `gh pr list --state open` 扫描当前账号全部 open PR；
2. 逐一提取各 PR 的 GitHub Actions Checks（`gh pr checks <id>`）；
3. 若发现代码风格、Lint（Ruff/oxlint/ESLint/Biome）、格式化或单测失败：
   - 立即切出对应分支；
   - 针对 CI 日志定位病灶，实施原子修正；
   - 本地跑通校验后推送到该 PR 分支，彻底使存量成果变绿。

### 阶段 2：目标项目与高价值 Issue 探测 (Scouting & Ghost Check)
1. 聚焦于 ⭐ 1000+ 知名开源项目（如 AI Infra、分布式编排、开发者工具）；
2. 检索 `is:issue is:open label:bug`，筛选具备：
   - 明确的复现步骤与错误堆栈；
   - 属于代码逻辑错误，而非主观产品需求/UI 审美偏好；
   - 尚未被其他贡献者提交有效 PR 认领。
3. **幽灵 Issue 前置防线**：在目标仓库中执行 `git log --grep="<issue-id>"`，并在代码中实测病灶是否已被暗中修复，杜绝无效返工；
4. **两击即停与频控自愈**：若遭遇上游仓库 Interaction Limits 或短时提交频控，立即转向下一个目标仓库，严禁无谓盲目重试。

### 阶段 3：轻量隔离沙箱秒级装配 (Lightweight Isolation)
1. **严禁全量 monorepo 构建**：绝对禁止盲目在仓库根目录执行整包拉取，防止触发数十分钟无声假死；
2. **秒级轻量沙箱构建**：
   ```powershell
   uv venv <sandbox-dir> --no-project
   uv pip install pytest httpx <minimal-core-deps> --python <sandbox-dir>\Scripts\python.exe
   ```
3. **平台安全规约**：
   - 严禁使用 PowerShell 的 `>` 重定向写入二进制或代码；
   - 严格感知目标文件的换行格式（LF vs CRLF），编辑时保持逐行对齐，严禁全文件换行漂移。

### 阶段 4：根因定位与原子修复 (Root Cause & Regression Testing)
1. **结构化修复原则**：涉及网络协议、URL 路径、AST 解析时，严禁使用粗暴脆弱的全局正则表达式打补丁；必须使用严格规范处理（如 URL 动态路径段强制 `encodeURIComponent` / `urllib.parse.quote(..., safe="")`）；
2. **拒绝死代码**：新增类型与逻辑必须具备真实业务调用链；
3. **单测覆盖与本地门禁**：
   - 编写针对该 Bug 的最小回归单测（Regression Test），确保 100% 通过；
   - 本地运行项目指定的 Linter（如 `ruff check`、`biome check`、`eslint`），实现 0 错误 0 告警方准进入交付。

### 阶段 5：规范保真 PR 自动创建 (PR Delivery & Body-File Invariant)
1. 确保 Fork 存在并对齐 Remote：
   ```powershell
   gh repo fork <upstream-org/repo> --clone=false 2>$null
   git remote add origin https://github.com/cf3901646/<repo>.git 2>$null
   ```
2. 严格遵循目标仓库 `.github/pull_request_template.md` 模板；
3. **反 AI 八股正文**：PR 正文严禁机械浮夸的 AI 模板语言，直击技术事实：
   - **Problem**：复现路径与错误堆栈（贴出具体行号与调用链路）；
   - **Solution**：核心改动机理与代码逻辑；
   - **Tests / Verification**：单测通过数据、测试项数与格式化全绿证据；
4. **防转义写入**：将 PR 正文写入独立 Markdown 临时文件，使用 `gh pr create --body-file <temp-file>` 提交；提交完成后立即销毁临时文件。

### 阶段 6：连续推进与规则自动同步 (Continuous Delivery & Auto-Sync)
1. 成功交付当前 PR 后，无缝接单并自动检索推进下一个目标项目；
2. 执行闭环终点，自动将沉淀与改动同步至专属规则仓库 `cf3901646/antigravity-agent-rules` 并完成 `git push origin main`。
