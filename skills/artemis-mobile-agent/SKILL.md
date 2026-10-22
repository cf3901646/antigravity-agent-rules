---
name: artemis-mobile-agent
description: Google Artemis 多模态 Android 自动化测试与跨 App 操作 Agent。支持通过自然语言执行手机/模拟器端到端任务、启动 8000 端口 Web 控制台、MCP 挂载与 CLI 任务下发。
---

# Google Artemis 移动端多模态自动化技能 (Artemis Mobile Agent)

本技能记录本地已配置好的 Google Artemis 移动端 Agent 运行环境、CLI 参数与协同控制台规范。

---

## 一、 本地部署环境与路径

* **安装根目录**：`C:\Users\Administrator\artemis`
* **Python 运行时**：虚拟环境位于 `C:\Users\Administrator\artemis\.venv`
* **全局命令行工具**：`artemis`（执行路径已加入用户 PATH `C:\Users\Administrator\.local\bin`）
* **ADB 端点**：自动挂载本地 ADB 服务（`127.0.0.1:5037`）

---

## 二、 核心命令与使用规范

### 1. Web 可视化控制台与回放看板
如需启动图形化控制面板进行设备连线、实时投屏或流程回放：
```powershell
artemis ui --no-open
```
> [!IMPORTANT]
> 遵循沙箱防抢锁规约，必须附带 `--no-open` 参数，启动后在物理宿主机浏览器中手动打开：`http://localhost:8000`。

### 2. 命令行单次自动化任务 (CLI)
通过自然语言直接向连接的设备下发任务：
```powershell
# 极速 Flash 模式（推荐，单步约 3-5 秒）
artemis run "打开系统设置，找到电池选项并告诉我当前剩余电量" --profile flash

# 深度 Pro 探索模式（支持多步自检与复杂容错）
artemis run "打开应用商城搜索最新版应用并安装" --profile pro
```

### 3. 环境与真机就绪自检
```powershell
artemis doctor
```

---

## 三、 使用前置依赖与配置

1. **硬件连接**：
   * 确保真实 Android 手机通过 USB 连接电脑且开启 **开发者选项 -> USB 调试**（或已启动本地 Android 模拟器）。
   * 终端运行 `adb devices` 应能列出设备序列号。
2. **大模型 API 密钥**：
   * 在 `C:\Users\Administrator\artemis\.env` 或当前环境变量中配置模型密钥：
     ```bash
     GEMINI_API_KEY="your-api-key"
     ```

---

## 四、 IDE 与 MCP 服务联动

Artemis 已经适配原生 MCP 协议，若需在 AI 智能体中直接调用 Artemis 测试工具：
```powershell
cd C:\Users\Administrator\artemis
uv run artemis mcp --install antigravity
```
MCP 核心定义：
* **Command**: `C:\Users\Administrator\artemis\.venv\Scripts\python.exe`
* **Args**: `["-m", "mcp_server"]`
* **Cwd**: `C:\Users\Administrator\artemis`
