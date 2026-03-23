#!/usr/bin/env pwsh
# Felo X Search - PowerShell version

param(
    [Parameter(Position=0)]
    [string]$Query,
    
    [switch]$User,
    [string]$Id,
    [switch]$Tweets
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

# Build query based on parameters
$finalQuery = $Query

if ($User) {
    $finalQuery = "search users: $Query"
} elseif ($Id -and $User) {
    $finalQuery = "get user info: $Id"
} elseif ($Id -and $Tweets) {
    $finalQuery = "get user tweets: $Id"
} elseif ($Id) {
    $finalQuery = "get tweet replies: $Id"
}

$body = @{
    query = $finalQuery
} | ConvertTo-Json -Compress

try {
    $bodyBytes = [System.Text.Encoding]::UTF8.GetBytes($body)
    $response = Invoke-RestMethod -Uri "https://openapi.felo.ai/v2/chat" -Method POST -Headers $headers -Body $bodyBytes
    $response | ConvertTo-Json -Depth 10
} catch {
    Write-Host "ERROR: $($_.Exception.Message)"
    exit 1
}
