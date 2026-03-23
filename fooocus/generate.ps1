# Fooocus 图像生成脚本
# 用法: .\generate.ps1 -Prompt "your prompt" [-NegativePrompt "negative"] [-Style "Fooocus V2"] [-AspectRatio "1024×1024"]

param(
    [Parameter(Mandatory=$true)]
    [string]$Prompt,
    
    [string]$NegativePrompt = "",
    [string]$Style = "Fooocus V2",
    [string]$AspectRatio = "1024×1024",
    [int]$ImageNumber = 1,
    [int]$Seed = -1
)

$FooocusUrl = "http://127.0.0.1:7865"

# 检查 Fooocus 是否运行
Write-Host "检查 Fooocus 服务..." -ForegroundColor Cyan
try {
    $check = Invoke-WebRequest -Uri $FooocusUrl -UseBasicParsing -TimeoutSec 5
    Write-Host "Fooocus 正在运行" -ForegroundColor Green
} catch {
    Write-Host "Fooocus 未运行，正在启动..." -ForegroundColor Yellow
    Start-Process -FilePath "D:\Fooocus\run.bat" -WorkingDirectory "D:\Fooocus"
    Start-Sleep -Seconds 30
}

# 风格映射
$StyleMap = @{
    "default" = "Fooocus V2"
    "photo" = "Fooocus Photograph"
    "anime" = "Fooocus Anime"
    "semi" = "Fooocus Semi Realistic"
    "art" = "Fooocus Art"
    "magic" = "Fooocus Magic"
}

if ($StyleMap.ContainsKey($Style.ToLower())) {
    $Style = $StyleMap[$Style.ToLower()]
}

Write-Host ""
Write-Host "=== 生成参数 ===" -ForegroundColor Cyan
Write-Host "提示词: $Prompt"
Write-Host "负面提示: $NegativePrompt"
Write-Host "风格: $Style"
Write-Host "尺寸: $AspectRatio"
Write-Host "数量: $ImageNumber"
Write-Host "种子: $Seed"
Write-Host ""

# 使用 Gradio 的 text-to-image 接口
# Fooocus 的 Gradio 接口参数顺序可能需要调整
$payload = @{
    fn_index = 0
    data = @(
        $Prompt,           # prompt
        $NegativePrompt,   # negative_prompt
        $Style,            # style
        "Quality",         # performance (Quality/Speed)
        $AspectRatio,      # aspect_ratio
        $Seed,             # image_seed (-1 = random)
        $ImageNumber,      # image_number
        2,                 # sharpness (default 2)
        4                  # guidance_scale (default 4)
    )
    session_hash = "fooocus_$([guid]::NewGuid().ToString())"
} | ConvertTo-Json -Depth 10

Write-Host "正在生成图像..." -ForegroundColor Yellow
Write-Host "请耐心等待（约 15-30 秒）..."

try {
    $response = Invoke-RestMethod -Uri "$FooocusUrl/api/predict" -Method Post -Body $payload -ContentType "application/json" -TimeoutSec 300
    Write-Host ""
    Write-Host "生成完成!" -ForegroundColor Green
    Write-Host ""
    Write-Host "结果:" -ForegroundColor Cyan
    $response | ConvertTo-Json -Depth 10
} catch {
    Write-Host "生成失败: $_" -ForegroundColor Red
    Write-Host ""
    Write-Host "尝试使用备用方法..." -ForegroundColor Yellow
    
    # 备用方法：直接访问 Web UI
    Write-Host "请打开浏览器访问: $FooocusUrl" -ForegroundColor Yellow
    Write-Host "手动输入提示词进行生成" -ForegroundColor Yellow
}
