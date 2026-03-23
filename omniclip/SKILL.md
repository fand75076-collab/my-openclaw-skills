# Omniclip - 开源视频编辑器

## 简介

Omniclip 是一个完全在浏览器中运行的开源视频编辑器，无需服务器，无需账户，所有数据存储在本地。

## 部署信息

- **位置**: `D:\Omniclip`
- **访问地址**: http://localhost:3001
- **局域网地址**: http://192.168.50.186:3001
- **启动脚本**: `D:\Omniclip\start.bat`

## 启动命令

### 方式 1: 使用启动脚本
```bash
D:\Omniclip\start.bat
```

### 方式 2: 直接命令
```bash
cd D:\Omniclip
npx http-server x -p 3001 -c-1 --cors
```

### 方式 3: 后台启动（PowerShell）
```powershell
Start-Process -FilePath "cmd.exe" -ArgumentList "/c", "cd /d D:\Omniclip && npx http-server x -p 3001 -c-1 --cors" -WindowStyle Hidden
```

## 停止服务

```powershell
# 查找并停止端口 3001 的进程
Get-NetTCPConnection -LocalPort 3001 -ErrorAction SilentlyContinue | ForEach-Object { Stop-Process -Id $_.OwningProcess -Force }
```

## 检查服务状态

```powershell
# 检查端口是否在监听
Get-NetTCPConnection -LocalPort 3001 -ErrorAction SilentlyContinue

# 或通过 HTTP 请求
try {
    Invoke-WebRequest -Uri "http://localhost:3001" -TimeoutSec 5 -UseBasicParsing
    Write-Host "服务运行中"
} catch {
    Write-Host "服务未运行"
}
```

## 功能特性

- 🎬 时间线编辑
- 🎵 多轨道支持
- 📝 文字/图片/视频/音频编辑
- 🎨 转场效果和滤镜
- 📤 导出最高 4K
- 🔒 本地处理（隐私安全）

## 使用场景

- 快速视频剪辑
- 无需安装桌面软件时
- 隐私敏感的视频处理

## 注意事项

1. 浏览器需要支持 WebCodecs API（Chrome 94+）
2. 服务需要在运行状态才能访问
3. 所有视频处理在浏览器本地完成，不占用服务器资源

## 调用示例

当用户需要视频编辑功能时：
1. 检查服务是否运行
2. 如未运行，启动服务
3. 提供访问链接给用户
