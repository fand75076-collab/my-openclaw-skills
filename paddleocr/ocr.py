#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
PaddleOCR Client for OpenClaw
Usage: python ocr.py <image_path> [--lang zh|en|ja|ko]
"""

import os
os.environ['FLAGS_use_mkldnn'] = '0'
os.environ['FLAGS_enable_onednn_backend'] = '0'
os.environ['KMP_DUPLICATE_LIB_OK'] = 'TRUE'
os.environ['PADDLE_PDX_DISABLE_MODEL_SOURCE_CHECK'] = 'True'

import sys
import argparse

# Force UTF-8 output
if sys.stdout.encoding != 'utf-8':
    sys.stdout.reconfigure(encoding='utf-8')

def ocr_image(image_path, lang='ch'):
    """Perform OCR on an image"""
    from paddleocr import PaddleOCR
    
    print(f'Loading OCR model (lang={lang})...', file=sys.stderr)
    ocr = PaddleOCR(use_textline_orientation=True, lang=lang)
    
    print(f'Processing: {image_path}', file=sys.stderr)
    result = ocr.ocr(image_path)
    
    if result and len(result) > 0:
        page_result = result[0]
        
        if isinstance(page_result, dict) and 'rec_texts' in page_result:
            texts = page_result['rec_texts']
            scores = page_result.get('rec_scores', [])
            
            # Output as JSON-like format
            print('\n=== OCR Results ===')
            for i, text in enumerate(texts):
                score = scores[i] if i < len(scores) else 0
                print(f'{text}')
            
            return texts
    
    return []

def main():
    parser = argparse.ArgumentParser(description='PaddleOCR Client')
    parser.add_argument('image', help='Path to image file')
    parser.add_argument('--lang', '-l', default='ch', help='Language (zh, en, ja, ko, etc.)')
    
    args = parser.parse_args()
    
    if not os.path.exists(args.image):
        print(f'Error: File not found: {args.image}', file=sys.stderr)
        sys.exit(1)
    
    texts = ocr_image(args.image, args.lang)
    
    if texts:
        print(f'\n[OK] Found {len(texts)} text regions', file=sys.stderr)

if __name__ == '__main__':
    main()
