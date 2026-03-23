---
name: paddleocr
description: Chinese OCR using PaddleOCR (PP-OCRv5). Extract text from images and scanned PDFs.
homepage: https://github.com/PaddlePaddle/PaddleOCR
metadata:
  openclaw:
    emoji: "📝"
    requires:
      python: ">=3.10"
      packages: ["paddleocr", "paddlepaddle==3.2.2"]
---

# PaddleOCR - Chinese OCR

High-quality Chinese OCR using PaddleOCR PP-OCRv5 models.

## Requirements

- PaddlePaddle 3.2.2 (NOT 3.3.0 - has oneDNN bug on Windows)
- PaddleOCR 3.x

## Usage

```bash
python {skillDir}/ocr.py <image_path> [--lang zh|en|ja|ko]
```

## Supported Languages

- `zh` - Chinese (default)
- `en` - English
- `ja` - Japanese
- `ko` - Korean
- `fr` - French
- `de` - German
- And 80+ more languages

## Notes

### Windows oneDNN Bug

PaddlePaddle 3.3.0 has a bug with oneDNN on Windows causing:
```
NotImplementedError: ConvertPirAttribute2RuntimeAttribute not support
```

**Solution**: Use PaddlePaddle 3.2.2
```bash
pip install paddlepaddle==3.2.2 -i https://www.paddlepaddle.org.cn/packages/stable/cpu/
```

### Environment Variables

The script sets these automatically:
- `FLAGS_use_mkldnn=0` - Disable MKL-DNN
- `FLAGS_enable_onednn_backend=0` - Disable oneDNN backend
- `KMP_DUPLICATE_LIB_OK=TRUE` - Allow duplicate OpenMP libs
- `PADDLE_PDX_DISABLE_MODEL_SOURCE_CHECK=True` - Skip model hoster check

## Example Output

```
=== OCR Results ===
关于阶段性通报2-3月违规摆卖行为的通知
各位商户：
为进一步规范市场经营秩序
广汽本田汽车销售有限公司
...

[OK] Found 99 text regions
```
