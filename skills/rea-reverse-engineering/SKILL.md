---
name: rea-reverse-engineering
description: REA (Reverse Engineer Anything) 逆向工程与软件分析 Agent 工具链。支持 APK 结构审计、JS/Electron 代码还原、二进制分析及 stdio MCP 协议调用。
---

# REA 软件逆向分析技能 (Reverse Engineer Anything)

本技能记录本地已全局部署的 REA (Reverse Engineer Anything) 逆向分析工具链、核心审计指令与 MCP 集成调用规范。

---

## 一、 环境与基础命令

* **安装包**：`rea-agents@6.7.0`（NPM 全局安装）
* **全局命令**：`rea`
* **环境自检**：
  ```bash
  rea doctor
  ```

---

## 二、 常用逆向审计工作流

### 1. 快速应用概览与静态审计
针对 APK、Electron 应用或本地二进制可执行文件进行快速结构推导：
```bash
rea analyze <目标文件或目录路径>
```

### 2. Android 应用与 APK 逆向分析
* **资源解析**（解码 Manifest 与字符串表）：
  ```bash
  rea decode-android-resources --apk <path-to-apk>
  ```
* **检索类定义与方法签名**：
  ```bash
  rea search-android-classes --apk <path-to-apk> --query "<keyword>"
  ```
* **拉取已连接设备的应用安装包**：
  ```bash
  rea pull-adb-package --package <package-name>
  ```

### 3. Web & JavaScript / Electron 还原分析
* **提取与还原 JS 打包资产**：
  ```bash
  rea analyze-javascript-application --path <electron-app-path>
  ```
* **捕获并静态分析网页 Bundle**：
  ```bash
  rea analyze-web-bundle --url <target-url>
  ```

---

## 三、 MCP 智能体调度模式

当需要让 AI 智能体自主调用 REA 工具进行深层代码审查或逆向解构时：
```bash
rea --mcp
```
* **协议**：Standard IO (stdio)
* **适用客户端**：Antigravity、Cursor、Claude Code、Windsurf 等支持 MCP 标准的智能体宿主。

---

## 四、 高级反编译引擎集成（按需）

基础静态解析已完全可用；若需调用底层反编译引擎（如 Ghidra、Jadx、IDA），可通过设置环境变量接入：
* `GHIDRA_INSTALL_DIR`：指向 Ghidra 12.1+ 安装目录
* `REA_JADX_MCP_JAR`：指向 `jadx-headless-mcp` 的绝对路径
