# Fooocus-API 本地生图技能

通过 Fooocus-API 调用本地模型生成图片。

## 服务状态

- **Fooocus-API 位置**: `D:\Fooocus-API`
- **模型目录**: `D:\Fooocus\Fooocus\models\checkpoints`
- **默认端口**: 8888
- **API 文档**: http://localhost:8888/docs

## 启动服务

```powershell
cd D:\Fooocus-API
python main.py --port 8888
```

## API 调用示例

### 文生图

```powershell
curl -X POST "http://localhost:8888/v1/generation/text-to-image" `
  -H "Content-Type: application/json" `
  -d '{
    "prompt": "a beautiful sunset over mountains",
    "image_number": 1,
    "async_process": false
  }'
```

### 参数说明

| 参数 | 说明 | 默认值 |
|------|------|--------|
| prompt | 提示词 | 必填 |
| image_number | 生成数量 | 1 |
| async_process | 异步处理 | false |
| style_selections | 风格选择 | [] |
| aspect_ratios_selection | 尺寸 | 1152*896 |
| performance_selection | 性能模式 | Speed |

## 可用模型

- `juggernautXL_v8Rundiffusion.safetensors` - SDXL 模型
- `sd-turbo` - 单步快速生成 (下载中)

## 使用 SD-Turbo

SD-Turbo 只需 1 步推理：

```json
{
  "prompt": "your prompt",
  "steps": 1,
  "guidance_scale": 0.0
}
```

## 注意事项

- 确保 Fooocus-API 服务已启动
- VRAM 需求: SD-Turbo 约 6-8 GB
- 生成速度: SD-Turbo 1-2 秒/张
