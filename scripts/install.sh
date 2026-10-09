#!/usr/bin/env bash
# 一键将规则与技能部署至当前用户的 Antigravity / Gemini 配置目录 (~/.gemini)

set -e

GEMINI_DIR="$HOME/.gemini"
CONFIG_RULES_DIR="$GEMINI_DIR/config/rules"
CONFIG_SKILLS_DIR="$GEMINI_DIR/config/skills"
SOURCE_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "==> 开始安装 Antigravity 规则与技能套件..."

mkdir -p "$CONFIG_RULES_DIR"
mkdir -p "$CONFIG_SKILLS_DIR"

# 1. 安装全局硬性基线规则 GEMINI.md
if [ -f "$SOURCE_ROOT/rules/GEMINI.md" ]; then
    cp -f "$SOURCE_ROOT/rules/GEMINI.md" "$GEMINI_DIR/GEMINI.md"
    echo "[OK] 已部署全局基线规则 -> $GEMINI_DIR/GEMINI.md"
fi

# 2. 安装场景化规约 (rules/*.md)
for rule in "$SOURCE_ROOT/rules"/*.md; do
    base=$(basename "$rule")
    if [ "$base" != "GEMINI.md" ]; then
        cp -f "$rule" "$CONFIG_RULES_DIR/$base"
        echo "[OK] 已部署规范规则 -> $CONFIG_RULES_DIR/$base"
    fi
done

# 3. 安装技能 (skills/*)
for sDir in "$SOURCE_ROOT/skills"/*; do
    if [ -d "$sDir" ]; then
        base=$(basename "$sDir")
        cp -rf "$sDir" "$CONFIG_SKILLS_DIR/"
        echo "[OK] 已部署技能插件 -> $CONFIG_SKILLS_DIR/$base"
    fi
done

echo ""
echo "==> 全部规则与技能部署完成！重启或新建 Antigravity / Gemini 会话即可生效。"
