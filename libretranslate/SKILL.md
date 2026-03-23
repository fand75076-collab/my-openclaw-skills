# LibreTranslate 本地翻译技能

本地部署的 LibreTranslate 翻译服务，无需 API Key，完全离线运行。

## 服务信息

| 项目 | 值 |
|------|-----|
| **服务地址** | http://localhost:5500 |
| **已加载语言** | en (英文), zh-Hans (中文简体) |
| **启动命令** | `libretranslate --load-only en,zh --port 5500` |

## 支持的语言代码

| 语言 | 代码 |
|------|------|
| English | en |
| Chinese (Simplified) | zh-Hans |
| Japanese | ja |
| Korean | ko |
| French | fr |
| German | de |
| Spanish | es |
| Russian | ru |

## API 端点

### 获取支持的语言列表

```bash
GET http://localhost:5500/languages
```

### 翻译文本

```bash
POST http://localhost:5500/translate
Content-Type: application/json

{
  "q": "要翻译的文本",
  "source": "en",
  "target": "zh-Hans",
  "format": "text"
}
```

### 批量翻译

```bash
POST http://localhost:5500/translate
Content-Type: application/json

{
  "q": ["文本1", "文本2"],
  "source": "en",
  "target": "zh-Hans",
  "format": "text"
}
```

## PowerShell 调用示例

```powershell
# 翻译英文到中文
$body = @{
    q = "Hello, how are you?"
    source = "en"
    target = "zh-Hans"
    format = "text"
} | ConvertTo-Json

Invoke-RestMethod -Uri "http://localhost:5500/translate" `
    -Method Post `
    -Body $body `
    -ContentType "application/json"
```

## 使用场景

1. **翻译文本** - 用户请求翻译时调用
2. **批量翻译** - 处理多段文本
3. **实时翻译** - 对话中的即时翻译需求

## 注意事项

- LibreTranslate 需要保持运行状态
- 首次翻译可能较慢（模型加载）
- 支持 `--load-only` 参数限制加载的语言模型
- 如需更多语言，修改启动命令：`libretranslate --load-only en,zh,ja,ko,fr,de,es,ru --port 5500`

## 启动服务

如果服务未运行，执行：

```powershell
Start-Process -FilePath "libretranslate" -ArgumentList "--load-only", "en,zh", "--port", "5500" -WindowStyle Hidden
```

## 检查服务状态

```powershell
Invoke-RestMethod -Uri "http://localhost:5500/languages" -Method Get
```
