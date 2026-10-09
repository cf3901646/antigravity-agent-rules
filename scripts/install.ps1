<#
.SYNOPSIS
    将规则与技能一键部署安装至当前用户的 Antigravity / Gemini 配置目录 (~/.gemini)
#>

$ErrorActionPreference = "Stop"

$GeminiDir = Join-Path $HOME ".gemini"
$ConfigRulesDir = Join-Path $GeminiDir "config\rules"
$ConfigSkillsDir = Join-Path $GeminiDir "config\skills"
$SourceRoot = Split-Path -Parent $PSScriptRoot

Write-Host "==> 开始安装 Antigravity 规则与技能套件..." -ForegroundColor Cyan

# 确保目标目录存在
New-Item -ItemType Directory -Force -Path $ConfigRulesDir | Out-Null
New-Item -ItemType Directory -Force -Path $ConfigSkillsDir | Out-Null

# 1. 安装全局硬性基线规则 GEMINI.md
$SourceGeminiMd = Join-Path $SourceRoot "rules\GEMINI.md"
$DestGeminiMd = Join-Path $GeminiDir "GEMINI.md"
if (Test-Path $SourceGeminiMd) {
    Copy-Item -Path $SourceGeminiMd -Destination $DestGeminiMd -Force
    Write-Host "[OK] 已部署全局基线规则 -> $DestGeminiMd" -ForegroundColor Green
}

# 2. 安装场景化规约 (rules/*.md)
$RuleFiles = Get-ChildItem -Path (Join-Path $SourceRoot "rules") -Filter "*.md"
foreach ($rule in $RuleFiles) {
    if ($rule.Name -ne "GEMINI.md") {
        $dest = Join-Path $ConfigRulesDir $rule.Name
        Copy-Item -Path $rule.FullName -Destination $dest -Force
        Write-Host "[OK] 已部署规范规则 -> $dest" -ForegroundColor Green
    }
}

# 3. 安装技能 (skills/*)
$SkillDirs = Get-ChildItem -Path (Join-Path $SourceRoot "skills") -Directory
foreach ($sDir in $SkillDirs) {
    $dest = Join-Path $ConfigSkillsDir $sDir.Name
    Copy-Item -Path $sDir.FullName -Destination $dest -Recurse -Force
    Write-Host "[OK] 已部署技能插件 -> $dest" -ForegroundColor Green
}

Write-Host "`n==> 全部规则与技能部署完成！重启或新建 Antigravity / Gemini 会话即可生效。" -ForegroundColor Cyan
