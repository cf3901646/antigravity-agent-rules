---
trigger: model_decision
description: Cloudflare 边缘分发、跨平台 CI 构建防污染与微信生态访问保障规约。在配置海外域名、Cloudflare Pages 部署及排查微信内访问受阻时强制遵守。
---

# Cloudflare 边缘分发与微信生态访问保障规约

## 一、 跨平台 CI 构建依赖防污染红线
1. **严禁生产硬依赖本地平台专有原生绑定**：
   - 在 Windows/macOS 本地开发环境执行包管理安装时，严禁将平台专有的 native binary（如 `@rolldown/binding-win32-x64-msvc`）直接作为生产 `dependencies` 写入 `package.json`；
   - 提交至 GitHub / GitLab 并由 Linux CI 容器（如 Cloudflare Pages、Vercel、Docker）构建时，必须确保其依赖能跨平台平滑解析，杜绝 `npm clean-install` 报 `EBADPLATFORM` 阻断发布。

## 二、 域名注册商与 Cloudflare NS 切换规范
1. **切换 NS 前必须先行停用 DNSSEC**：
   - 在第三方注册商（如 Spaceship、Namecheap 等）将域名 Nameservers 切换为 Cloudflare 之前，必须显式在注册商控制台关闭 DNSSEC；
   - 切换完成后，必须通过 RDAP 或 `dig DS +trace` 核验父域已清除旧 DS 记录（`delegationSigned: false`），彻底避免出现 `DNSSEC validation failure / EDE(9): DNSKEY Missing` 导致全球递归解析瘫痪。

## 三、 Cloudflare 面向微信客户端的放行配置
1. **彻底关闭针对微信 WebView 的安全质询**：
   - 面向国内用户的海外域名，在 Cloudflare Zone 设置中必须将 `browser_check`（浏览器完整性检查）置为 `off`；
   - 将 `security_level` 调至 `essentially_off`，彻底规避因微信内置浏览器（MicroMessenger）缺少桌面指纹而触发 5 秒盾或 JS 验证码导致在微信内卡死白屏。
2. **开启抗丢包边缘特性**：
   - 强制开启 `http3: on`（QUIC 协议抗跨国公网丢包）与 `brotli: on` 高倍率压缩；
   - 配置页面规则启用全量边缘缓存（Cache Everything）以减少海外回源开销。
3. **微信聊天框纯数字域名格式规约**：
   - 纯数字开头的域名（如 `476537381.xyz`）在微信中发送时，必须附带完整协议头（`https://...`），防止被微信误判为电话号码或走不安全的明文 HTTP 80 端口遭运营商网关劫持。
