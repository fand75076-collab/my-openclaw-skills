#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Fooocus 图像生成 API 客户端 (简化版)
通过 Gradio 接口调用本地 Fooocus
"""

import requests
import json
import time
import sys
from pathlib import Path

class FooocusClient:
    def __init__(self, base_url: str = "http://127.0.0.1:7865"):
        self.base_url = base_url
        self.session = requests.Session()
        self.output_dir = Path("D:/Fooocus/Fooocus/outputs")
        
    def is_running(self) -> bool:
        """检查 Fooocus 是否运行"""
        try:
            r = self.session.get(f"{self.base_url}/", timeout=5)
            return r.status_code == 200
        except:
            return False
    
    def generate(self, prompt: str, negative_prompt: str = "", wait: bool = True, timeout: int = 300) -> dict:
        """
        生成图像 (简化版 - 只需要 prompt)
        
        返回:
            {"success": True, "image": "路径"} 或 {"success": False, "error": "错误信息"}
        """
        if not self.is_running():
            return {"success": False, "error": "Fooocus 未运行"}
        
        # 记录开始时间
        start_time = time.time()
        
        # 通过 Gradio 的 run/predict 接口
        # 组件 11 是 prompt 输入框，组件 14 是 Generate 按钮
        try:
            # 发送 prompt 到文本框
            payload = {
                "data": [prompt],
                "fn_index": 0
            }
            
            response = self.session.post(
                f"{self.base_url}/run/predict",
                json=payload,
                timeout=timeout
            )
            
            if response.status_code == 200:
                result = response.json()
                
                if wait:
                    # 等待生成完成
                    time.sleep(5)
                    
                    # 检查输出目录
                    if self.output_dir.exists():
                        images = sorted(
                            self.output_dir.glob("*.png"),
                            key=lambda x: x.stat().st_mtime,
                            reverse=True
                        )
                        if images:
                            latest = images[0]
                            # 检查是否是新生成的
                            if latest.stat().st_mtime > start_time:
                                return {
                                    "success": True,
                                    "image": str(latest),
                                    "prompt": prompt
                                }
                
                return {"success": True, "data": result}
            else:
                return {"success": False, "error": f"HTTP {response.status_code}"}
                
        except Exception as e:
            return {"success": False, "error": str(e)}
    
    def get_latest_image(self) -> str | None:
        """获取最新的生成图像"""
        if not self.output_dir.exists():
            return None
        
        images = sorted(
            self.output_dir.glob("*.png"),
            key=lambda x: x.stat().st_mtime,
            reverse=True
        )
        
        return str(images[0]) if images else None
    
    def list_recent_images(self, limit: int = 5) -> list:
        """列出最近的图像"""
        if not self.output_dir.exists():
            return []
        
        images = sorted(
            self.output_dir.glob("*.png"),
            key=lambda x: x.stat().st_mtime,
            reverse=True
        )[:limit]
        
        return [{"path": str(img), "time": img.stat().st_mtime} for img in images]


# 命令行入口
if __name__ == "__main__":
    client = FooocusClient()
    
    print("Fooocus 客户端状态检查")
    print("=" * 40)
    
    if client.is_running():
        print("[OK] Fooocus 正在运行")
        print(f"Web UI: {client.base_url}")
        
        # 显示最近的图像
        recent = client.list_recent_images(3)
        if recent:
            print(f"\n最近的图像:")
            for img in recent:
                print(f"  {img['path']}")
    else:
        print("[ERROR] Fooocus 未运行")
        print("启动命令: D:\\Fooocus\\run.bat")
