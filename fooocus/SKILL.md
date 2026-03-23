# Fooocus - 本地 AI 图像生成技能

本地安装的 Fooocus AI 图像生成工具。RTX 4070 GPU 加速。

## 快速使用

### 1. 确保 Fooocus 运行

```powershell
# 启动 Fooocus
D:\Fooocus\run.bat

# 检查状态
# 访问 http://127.0.0.1:7865
```

### 2. Web UI 生成 (推荐)

直接打开浏览器访问: **http://127.0.0.1:7865**

1. 在文本框输入 prompt (提示词)
2. 点击 Generate 按钮
3. 等待生成完成，图像显示在右侧

### 3. Python API

```python
from fooocus_client import FooocusClient

client = FooocusClient()

# 检查状态
if client.is_running():
    print("Fooocus 正在运行")

# 获取最新图像
latest = client.get_latest_image()
print(f"最新图像: {latest}")
```

## 参数说明

### Prompt 示例

```
# 写实风格
a red Australian Shepherd dog, highly detailed, beautiful photography, 8k quality

# 动漫风格 (需切换 run_anime.bat)
anime girl, detailed face, studio ghibli style

# 风景
beautiful sunset over the ocean, dramatic clouds, golden hour
```

### 常用设置 (Web UI)

| 设置 | 选项 | 说明 |
|------|------|------|
| Performance | Quality / Speed | 质量/速度 |
| Aspect Ratio | 1024×1024, 1152×896 等 | 图像尺寸 |
| Styles | Fooocus V2, Cinematic 等 | 预设风格 |

## 文件位置

- **安装目录**: `D:\Fooocus`
- **输出目录**: `D:\Fooocus\Fooocus\outputs\`
- **模型目录**: `D:\Fooocus\Fooocus\models\checkpoints\`
- **默认模型**: juggernautXL_v8Rundiffusion.safetensors

## 性能

| 模式 | 时间 | 显存 |
|------|------|------|
| Quality | 20-40秒 | 8GB+ |
| Speed | 5-15秒 | 4GB+ |

## 故障排除

### Fooocus 无法启动

```powershell
# 检查端口
netstat -ano | Select-String ":7865"

# 检查 Python
D:\Fooocus\python_embeded\python.exe --version

# 检查模型
Get-ChildItem D:\Fooocus\Fooocus\models\checkpoints\*.safetensors
```

### 显存不足

- 使用 Speed 模式
- 减小图像尺寸
- 关闭其他 GPU 应用

### API 无法连接

确保 Fooocus 已启动并访问 http://127.0.0.1:7865 确认正常。

## 注意事项

1. **先启动 Fooocus** - 需要先运行 `D:\Fooocus\run.bat`
2. **生成时间** - 1024x1024 Quality 模式约需 20-40 秒
3. **输出位置** - 生成的图像自动保存到 outputs 目录
