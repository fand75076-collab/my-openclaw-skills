#!/usr/bin/env pwsh
# Felo Search - PowerShell version (UTF-8)

param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$Query
)

$ErrorActionPreference = "Stop"
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Check API key
if (-not $env:FELO_API_KEY) {
    Write-Host "ERROR: FELO_API_KEY not set"
    Write-Host "Get your API key from https://felo.ai (Settings -> API Keys)"
    exit 1
}

# Call Felo API
$headers = @{
    "Authorization" = "Bearer $env:FELO_API_KEY"
    "Content-Type" = "application/json; charset=utf-8"
}

$body = @{
    query = $Query
} | ConvertTo-Json -Compress

try {
    $bodyBytes = [System.Text.Encoding]::UTF8.GetBytes($body)
    $response = Invoke-RestMethod -Uri "https://openapi.felo.ai/v2/chat" -Method POST -Headers $headers -Body $bodyBytes
    
    # Output answer
    if ($response.data.answer) {
        Write-Host "`n=== Felo Answer ===`n" -ForegroundColor Cyan
        Write-Host $response.data.answer
    }
    
    # Output resources if any
    if ($response.data.resources -and $response.data.resources.Count -gt 0) {
        Write-Host "`n=== Sources ===" -ForegroundColor Yellow
        foreach ($r in $response.data.resources) {
            Write-Host "- $($r.title)"
            Write-Host "  $($r.link)"
        }
    }
    
    # Output JSON for programmatic use
    Write-Host "`n=== JSON ===" -ForegroundColor DarkGray
    $response | ConvertTo-Json -Depth 10
    
} catch {
    Write-Host "ERROR: $($_.Exception.Message)"
    exit 1
}
