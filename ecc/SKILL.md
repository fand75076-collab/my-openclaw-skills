---
name: ecc
description: ECC (Everything Claude Code) 性能优化系统 CLI。用于调用 ECC 的安装、诊断、修复、状态查询等功能。当用户要求安装 ECC、检查 ECC 状态、诊断配置问题、修复文件、查看会话时使用。命令: install, plan, list-installed, doctor, repair, status, sessions, session-inspect, uninstall。
---

# ECC CLI Skill

ECC 是 AI Agent Harness 性能优化系统。通过 `npx ecc` 调用。

## 安装位置

```
D:\everything-claude-code
```

## 命令速查

| 命令 | 用途 |
|------|------|
| `ecc install` | 安装配置到目标 (claude/codex/cursor) |
| `ecc plan` | 查看安装计划 |
| `ecc list-installed` | 查看已安装内容 |
| `ecc doctor` | 诊断缺失/漂移文件 |
| `ecc repair` | 修复问题文件 |
| `ecc status` | 查询 SQLite 状态 |
| `ecc sessions` | 列出会话 |
| `ecc session-inspect` | 检查会话快照 |
| `ecc uninstall` | 卸载 ECC 管理的文件 |

## 调用方式

```powershell
cd D:\everything-claude-code
npx ecc <command> [args...]
```

## 常用示例

```powershell
# 安装 TypeScript 配置到 Claude
npx ecc typescript

# 安装 developer profile 到 Claude
npx ecc install --profile developer --target claude

# 诊断 Cursor 配置
npx ecc doctor --target cursor

# 查看状态 (JSON 格式)
npx ecc status --json

# 查看活跃会话
npx ecc sessions session-active --json

# 修复文件 (先预览)
npx ecc repair --dry-run
```

## Profile 选项

- `core` - 核心配置
- `developer` - 开发者配置
- `minimal` - 最小配置

## Target 选项

- `claude` - Claude Code
- `codex` - OpenAI Codex
- `cursor` - Cursor IDE
- `antigravity` - Antigravity

## 注意事项

- 运行前先 `cd D:\everything-claude-code`
- 危险操作 (uninstall) 先用 `--dry-run` 预览
- `doctor` 用于诊断，`repair` 用于修复
