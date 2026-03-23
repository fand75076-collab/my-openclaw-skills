# GLM-OCR 图片文字识别

使用本地 Ollama 的 GLM-OCR 模型识别图片中的文字内容。

## 触发条件

- 需要识别图片中的文字、文档、证件、截图等内容
- 用户发送图片要求"识别文字"、"OCR"、"读取内容"等

## 使用方法

### 方式一：Python 脚本（推荐）

```bash
python ~/.openclaw/skills/glm-ocr/glm_ocr.py "<图片路径>" --prompt "识别所有文字"
```

### 方式二：Ollama CLI

```bash
ollama run glm-ocr "请识别图片中的所有文字内容" "<图片路径>"
```

## 参数说明

| 参数 | 说明 | 默认值 |
|------|------|--------|
| 图片路径 | 图片文件的绝对路径 | 必填 |
| --prompt | 自定义提示词 | "请识别这张图片中的所有文字，保持原有格式。" |

## 常用 Prompt 示例

```bash
# 基础 OCR
python glm_ocr.py image.png

# 证件识别
python glm_ocr.py id_card.jpg --prompt "识别证件上的所有字段信息，包括姓名、证件号等"

# 表格识别
python glm_ocr.py table.png --prompt "识别表格内容，保持行列结构"

# 手写文字
python glm_ocr.py handwriting.jpg --prompt "识别手写文字，尽量保持原有格式"
```

## 注意事项

- 模型名称：`glm-ocr` (已安装，约 2.2 GB)
- 需要本地 Ollama 服务运行中
- 支持常见图片格式：jpg, png, bmp, webp
- 首次调用约 2-3 秒，后续热启动约 0.5 秒

## 错误处理

- **模型未找到**：先运行 `ollama pull glm-ocr`
- **图片路径错误**：检查文件是否存在
- **Ollama 未运行**：启动 Ollama 服务
