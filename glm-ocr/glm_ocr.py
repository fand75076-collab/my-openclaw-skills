#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
GLM-OCR Client for OpenClaw
Usage: python glm_ocr.py <image_path> [--prompt "custom prompt"]
"""

import sys
import os
sys.stdout.reconfigure(encoding='utf-8')

import requests
import base64
import json
import argparse

def ocr_image(image_path, prompt="请识别这张图片中的所有文字，保持原有格式。"):
    """Perform OCR using GLM-OCR via Ollama"""
    
    # 读取图片
    with open(image_path, "rb") as f:
        image_data = base64.b64encode(f.read()).decode("utf-8")
    
    # 调用 Ollama API
    url = "http://localhost:11434/api/generate"
    payload = {
        "model": "glm-ocr",
        "prompt": prompt,
        "images": [image_data],
        "stream": False
    }
    
    response = requests.post(url, json=payload)
    
    if response.status_code == 200:
        result = response.json()
        return result.get("response", "")
    else:
        return f"Error: {response.status_code} - {response.text}"

def main():
    parser = argparse.ArgumentParser(description="GLM-OCR Client")
    parser.add_argument("image", help="Path to image file")
    parser.add_argument("--prompt", "-p", default="请识别这张图片中的所有文字，保持原有格式。", help="Custom prompt")
    
    args = parser.parse_args()
    
    if not os.path.exists(args.image):
        print(f"Error: File not found: {args.image}")
        sys.exit(1)
    
    print("正在识别...", file=sys.stderr)
    result = ocr_image(args.image, args.prompt)
    print(result)

if __name__ == "__main__":
    main()
