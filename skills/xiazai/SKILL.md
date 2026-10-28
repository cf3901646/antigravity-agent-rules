---
name: xiazai
description: 网盘与网络资源极速下载与智能路由闭环模式 (/xiazai)。【强语义自动意图监听】：即便用户未显式输入 /xiazai，凡是在对话中出现“帮我下载”、“下载这个链接/文件/网盘”、发送网盘分享链接（包含 pan.quark.cn、pan.baidu.com、yun.baidu.com、alipan.com、123pan.com、anxia.com、xunlei.com、115.com 等）或直链/磁力时，必须强制自动激活本技能。自动探测本地下载引擎与已装网盘客户端，实现智能双轨分流：直链/小中型文件直接提取并推送到后台常驻 Aria2 RPC 跑满带宽保存至 D:\Downloads；超大文件(>1GB)或服务端风控拦截文件自动引导至本地已安装官方客户端，拒绝盲目死磕油猴或网页端重定向，实现确定性满速交付。
---

# 网盘与网络资源极速下载模式 (/xiazai)

本模式是一套面向网盘资源（夸克、百度网盘、阿里云盘、115、迅雷、123网盘等）与直链资源的高信噪比自动化下载作业流。
具备**全天候自然语言意图无感自动激活能力**。

---

## 一、 意图自动识别规则 (Intent Triggers)

当用户输入满足以下任一条件时，**必须强制自主激活本工作流**，无需等待用户显式调用 `/xiazai`：
1. **显式指令**：以 `/xiazai` 开头；
2. **下载意向短语**：“帮我下载……”、“把这个下到电脑里”、“下载网盘里的东西”、“帮忙离线这个文件”；
3. **网盘特征链接**：消息中包含 `pan.quark.cn`、`pan.baidu.com`、`yun.baidu.com`、`alipan.com`、`123pan.com`、`anxia.com`、`xunlei.com`、`115.com` 等网盘链接。

---

## 二、 后台下载引擎自动自愈 (Engine Health Check)

在执行任何下载前，首先执行环境自检与静默拉起：
1. 探测本地 Aria2 端口（`127.0.0.1:6800`）：
   ```powershell
   curl.exe -s http://127.0.0.1:6800/jsonrpc -d '{\"jsonrpc\":\"2.0\",\"id\":\"ping\",\"method\":\"aria2.getVersion\"}'
   ```
2. 若未处于运行状态，自动通过 WMI 脱离沙箱在后台拉起常驻服务：
   ```powershell
   wmic process call create "D:\LinkSwift\Aria2\aria2c.exe --conf-path=D:\LinkSwift\Aria2\aria2.conf"
   ```
3. 默认落盘目录锁定为：`D:\Downloads`。

---

## 三、 智能双轨分流执行流水线 (Dual-Track Routing)

### 轨道 A：直链极速直推（体积 <= 1GB 或 具备直接提取 API）
1. 调用对应网盘的公开分享 API 或直链算法，获取真实 CDN 临时直链与请求头；
2. 构建 JSON-RPC 请求，推送到本地 Aria2 服务：
   ```json
   {
     "jsonrpc": "2.0",
     "id": "xiazai",
     "method": "aria2.addUri",
     "params": [
       ["<DOWNLOAD_URL>"],
       {
         "out": "<FILE_NAME>",
         "dir": "D:\\Downloads",
         "header": ["User-Agent: <OPTIMIZED_UA>", "Referer: <REFERER>"]
       }
     ]
   }
   ```
3. 输出简洁任务汇报，提供 AriaNg 图形监控入口：`file:///D:/LinkSwift/AriaNg/index.html`。

### 轨道 B：本地客户端智能直通（体积 > 1GB 或 命中云端硬拦截）
1. **一针见血点明病灶**：明确说明云端限制原因（如夸克 23018 限制网页端大文件下载），阻断用户陷入网页重定向；
2. **自动检测本地客户端**：检索注册表与常见路径（如 `D:\Quark\quark.exe`、百度网盘客户端等）；
3. **极速唤起或指引**：直接唤起或指引用户在已打开的官方客户端中一键极速下载，利用客户端原生断点续传与多线程协议完成大文件交付。

---

## 四、 智能体纪律红线
1. **两击即停**：若直链解析尝试 2 次失败，严禁连续盲目重试，必须立即转向轨道 B 或请示用户；
2. **杜绝脆弱网页死锁**：严禁在未确认扩展启用的情况下反复强求用户刷新网页或尝试网页端跳转按钮；
3. **交付透明**：所有下载任务必须明确告知最终保存目录（`D:\Downloads`）。
