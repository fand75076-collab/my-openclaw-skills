#!/usr/bin/env pwsh
# Felo YouTube Subtitling - PowerShell version

param(
    [Parameter(Mandatory=$true)]
    [string]$Video,
    
    [string]$Language = "en",
    [switch]$WithTime
)

$ErrorActionPreference = "Stop"
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

if (-not $env:FELO_API_KEY) {
    Write-Host "ERROR: FELO_API_KEY not set"
    exit 1
}

$headers = @{
    "Authorization" = "Bearer $env:FELO_API_KEY"
    "Content-Type" = "application/json; charset=utf-8"
}

# Extract video ID from URL if needed
$videoId = $Video
if ($Video -match "v=([a-zA-Z0-9_-]+)") {
    $videoId = $matches[1]
} elseif ($Video -match "youtu\.be/([a-zA-Z0-9_-]+)") {
    $videoId = $matches[1]
}

$body = @{
    video_id = $videoId
    language = $Language
    with_time = $WithTime.IsPresent
} | ConvertTo-Json -Compress

try {
    $bodyBytes = [System.Text.Encoding]::UTF8.GetBytes($body)
    $response = Invoke-RestMethod -Uri "https://openapi.felo.ai/v1/youtube" -Method POST -Headers $headers -Body $bodyBytes
    $response | ConvertTo-Json -Depth 10
} catch {
    Write-Host "ERROR: $($_.Exception.Message)"
    exit 1
}
