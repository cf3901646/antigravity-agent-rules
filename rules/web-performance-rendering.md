---
trigger: model_decision
description: 极速 Web 渲染性能、移动端触控交互与全端排版防崩硬性规约。在开发前端页面、富交互画廊、移动端展示或排查卡顿/闪烁/字体错位时强制遵守。
---

# 极速 Web 渲染性能与跨端防崩硬性规约

在构建任何前端页面或移动端 Web 应用时，严守以下防卡顿、防闪烁、跨网极速交付与防排版变形红线：

## 一、 动效与 GPU 渲染红线（杜绝卡顿与背景闪烁）
1. **严禁在全屏/大面积使用 CPU 杀手滤镜**：
   - 严禁在全屏固定图层使用 SVG `feTurbulence` 动态分形滤镜或带高频重绘的动态滤镜；
   - 严禁在视口大面积（>50vw）元素上应用超过 60px 的 CSS `filter: blur()` 并伴随 infinite 动画。
2. **渐变替代模糊原则 (Gradients Over Blur)**：
   - 大面积氛围柔光、光晕漂移必须优先采用纯 CSS **径向渐变（`radial-gradient`）** 实现边缘自然羽化（0 像素卷积开销，零掉帧稳上 120fps）。
3. **复合图层轻量化**：
   - 页面已具有高不透明度背景（>90%）的卡片，严禁滥用 `backdrop-blur`，彻底阻断由于底层运动光晕引起的双重模糊性能雪崩；
   - 动画元素强制配置 `will-change: transform` 或 `transform: translate3d(0,0,0)` 隔离为独立合成层。
4. **色彩过渡防抖与收敛时长**：
   - 滚动联动色彩切换必须基于“视口中心就近判定”并附带 `activeId` 记忆防抖锁，严禁在临界点频繁抖动触发重绘；
   - 全局背景颜色过渡时长严格控制在 **600ms 至 800ms**，严禁使用超过 1.5 秒的拖沓过渡导致状态插值冲突闪烁。

## 二、 跨网与国内网络极速交付红线（杜绝海外资源阻塞）
1. **海外字体非阻塞原则**：
   - 严禁以阻塞式 `<link rel="stylesheet">` 同步加载 Google Fonts 等海外外部字体；
   - 外部字体必须采用非阻塞异步加载（`media="print" onload="this.media='all'"`），并声明系统原生字体备用栈（如思源宋体、Songti SC、STSong 等），确保首屏 0 毫秒直出。
2. **静态图像现代 WebP/AVIF 瘦身**：
   - 生产环境展示大图严禁直接裸传数兆以上的原始 PNG/JPG；
   - 必须通过 Lanczos 算法重采样并转码为高质量 WebP，单张控制在 100KB-500KB 内，整站流量压缩 80% 以上；
   - 关键首屏大图设置 `fetchpriority="high"`，非首屏图片声明 `loading="lazy"` 与 `decoding="async"`。
3. **不可变长效强缓存与 PWA 离线引擎**：
   - 静态资源必须配置 `Cache-Control: public, max-age=31536000, immutable`，确保二次访问零延迟本地秒开；
   - 生产工程推荐标配 Service Worker 离线全量缓存，实现弱网/断网环境 0ms 秒开。

## 三、 全端排版抗挤压与字体缩放防崩红线
1. **移动端单行防折断**：
   - 顶部导航栏、关键标题、行动按钮等单行排版元素，必须强制声明 `whitespace-nowrap` 与 `shrink-0`，杜绝文字在小屏被纵向拆字折行。
2. **全平台文本缩放硬锁定**：
   - `html` 与 `body` 必须声明 `-webkit-text-size-adjust: 100% !important;` 及 `text-size-adjust: 100% !important;`，阻断 iOS/Android 系统辅助功能和老年机模式的 Font Boosting 文本膨胀破坏版式。
3. **微信内置浏览器字体防劫持**：
   - 针对国内移动端，页面必须在 `<head>` 中注入微信 JSBridge 事件监听，拦截 `setFontSizeCallback` 与 `menu:setfont`，锁定标准字号比例。
4. **触控 0 延迟即时吸附**：
   - 移动端微距、放大镜、拖拽等交互元素，必须同时监听 `onTouchStart` 与 `onTouchMove`，消除 300ms 触控延迟；容器外层配置 `overscroll-contain` 防止误触下拉刷新。
