#!/usr/bin/env pwsh
# Felo Web Fetch - PowerShell version

param(
    [Parameter(Mandatory=$true)]
    [string]$Url,
    
    [ValidateSet("markdown", "text", "html")]
    [string]$Format = "markdown",
    
    [switch]$Readability
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

$body = @{
    url = $Url
    format = $Format
    readability = $Readability.IsPresent
} | ConvertTo-Json -Compress

try {
    $bodyBytes = [System.Text.Encoding]::UTF8.GetBytes($body)
    $response = Invoke-RestMethod -Uri "https://openapi.felo.ai/v1/fetch" -Method POST -Headers $headers -Body $bodyBytes
    $response | ConvertTo-Json -Depth 10
} catch {
    Write-Host "ERROR: $($_.Exception.Message)"
    exit 1
}
