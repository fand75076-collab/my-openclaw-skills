# FireRed-OCR 技能

使用 FireRed-OCR (Qwen3-VL-2B) 进行文档 OCR 识别，输出结构化 Markdown。

## 触发条件

- 用户发送图片并要求 OCR 识别
- 用户要求识别文档、表格、公式等内容
- 用户提到 FireRed-OCR
- 复杂布局文档需要高精度识别

## 模型信息

| 项目 | 内容 |
|------|------|
| **模型名** | FireRedTeam/FireRed-OCR |
| **骨干模型** | Qwen3-VL-2B-Instruct |
| **参数量** | 2B |
| **许可证** | Apache 2.0 |
| **安装位置** | D:\FireRed-OCR |

## 性能基准

- **OmniDocBench v1.5**: 92.94% (SOTA for end-to-end)
- **FireRedBench**: 74.62%
- **OCRBench (TextRec)**: 93.5%
- **表格识别**: 90.31 TEDs
- **公式识别**: 91.71 CDM

## 使用方法

### 基本调用

```bash
python D:\FireRed-OCR\ocr_infer.py <图片路径>
```

### 指定输出文件

```bash
python D:\FireRed-OCR\ocr_infer.py <图片路径> <输出路径>
```

### Python API

```python
from pathlib import Path
import sys
sys.path.insert(0, r"D:\FireRed-OCR")

from ocr_infer import run_ocr

result = run_ocr("image.png")
print(result)
```

## 输出格式

输出为结构化 Markdown，支持：

1. **文本**: 标题、段落、列表
2. **数学公式**: LaTeX 格式
   - 行内公式: `$E = mc^2$`
   - 块级公式: `$$\frac{a}{b}$$`
3. **表格**: Markdown 表格格式
4. **层级结构**: 保持原文档结构

## 与其他 OCR 工具对比

| 工具 | 优势 | 劣势 | 适用场景 |
|------|------|------|----------|
| **FireRed-OCR** | 表格/公式强，开源本地 | 需 GPU | 复杂文档、学术论文 |
| **GLM-OCR** | 标准文档最强 | API 依赖 | 简单文档、快速识别 |
| **PaddleOCR** | 成熟稳定 | 精度一般 | 简单文本、批量处理 |

## 推荐路由

```
图片 OCR 请求
    ├── 复杂布局（表格/公式/多栏）→ FireRed-OCR
    ├── 标准文档（简单文本）→ GLM-OCR (API)
    └── 批量处理 → PaddleOCR
```

## 硬件需求

- **显存**: ~6-8GB (推理时)
- **模型大小**: ~4GB (BF16)
- **RTX 4070**: ✅ 完全支持

## 注意事项

1. **首次运行**会自动下载模型 (~4GB)，需要网络
2. 模型下载后会缓存到 `~/.cache/huggingface/`
3. 推理时 GPU 显存占用约 6-8GB
4. 如果 Fooocus 正在运行，需要先关闭释放显存

## 示例

### 识别身份证

```bash
python D:\FireRed-OCR\ocr_infer.py id_card.jpg
```

### 识别复杂表格

```bash
python D:\FireRed-OCR\ocr_infer.py table.png table.md
```

### 识别学术论文

```bash
python D:\FireRed-OCR\ocr_infer.py paper_page.png
```

## 相关链接

- 🤗 HuggingFace: https://huggingface.co/FireRedTeam/FireRed-OCR
- 📄 技术报告: https://arxiv.org/abs/2603.01840
- 🐈 GitHub: https://github.com/FireRedTeam/FireRed-OCR
