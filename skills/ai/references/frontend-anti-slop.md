# 前端 UI 与网页设计防 AI 模板化审美准则 (Frontend Anti-Slop Guidelines)

来源融合：`taste-skill` (Leonxlnx)

## 一、 核心定位

当用户要求对“前端代码、网页页面、Tailwind CSS、Landing Page”进行去 AI 味与审美升级时激活。彻底杜绝大模型在写代码时泛滥的廉价 Bootstrap / 渐变紫 / 浮夸发光球风，向 Figma、x.ai、Vercel 级工业审美看齐。

## 二、 六大审美门禁 (Design Invariants)

1. **单屏专注，一屏一业务 (One Section Per Screen)**：
   - 杜绝 AI 式的密集卡片轰炸；每一屏视口只讲透一个核心价值或交互场景，留白充分。
2. **拒绝廉价渐变与无意义发光 (No Purple Gradients & Fake Glows)**：
   - 严禁背景全是大面积无意义的紫色、青色渐变发光模糊大圆球；
   - 采用纯净的中性底色（Slate / Zinc / Charcoal），仅在核心操作按钮（Primary CTA）使用克制的重点色。
3. **真实摄影与产品实拍优先 (Real Photographs & Clean UI)**：
   - 拒绝 AI 虚构的卡通 3D 小人插画；采用高清晰度的真实产品截图、代码编辑器高亮窗口或有版权的实景摄影。
4. **克制且优雅的微交互 (Quiet Micro-Interactions)**：
   - 交互反馈应该是轻量且迅速的（如 150-200ms 的平滑色阶过渡、细腻边框悬浮），严禁夸张晃动、3D 翻转等视觉污染。
5. **严谨的字阶系统 (Strict Typographic Scale)**：
   - 建立 3 至 4 级清晰的字阶与字重层次，标题直击要害，副标题克制说明，行距呼吸感舒适（`leading-relaxed`）。
