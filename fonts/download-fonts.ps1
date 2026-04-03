# Self-host Google Fonts for GDPR compliance
# Run from the MIDTIDE WEBSITE/fonts/ folder:
#   cd "MIDTIDE WEBSITE/fonts"
#   powershell -ExecutionPolicy Bypass -File download-fonts.ps1
#
# Downloads variable font woff2 files (one file per family+style covers all weights).

$ErrorActionPreference = "Stop"

$fonts = @(
    @{
        file = "dm-sans-latin.woff2"
        # DM Sans variable font: weight 100-1000, optical size 9-40
        url  = "https://fonts.gstatic.com/s/dmsans/v15/rP2tp2ywxg089UriI5-g4vlH9VoD8CmcqZG40F9JadbnoEwAop-hSA.woff2"
    }
    @{
        file = "dm-sans-latin-italic.woff2"
        url  = "https://fonts.gstatic.com/s/dmsans/v15/rP2rp2ywxg089UriCZaSExd86J3t9jz86Mvy4qCRAL19DQ.woff2"
    }
    @{
        file = "fraunces-latin.woff2"
        # Fraunces variable font: weight 100-900, optical size 9-144
        url  = "https://fonts.gstatic.com/s/fraunces/v31/6NUh8FyLNQOQZAnv9bYEvDiIdE9Ea92uemAk_WBq8U_9v0c2Wa0K7iN7hzFUPJH58nk.woff2"
    }
    @{
        file = "fraunces-latin-italic.woff2"
        url  = "https://fonts.gstatic.com/s/fraunces/v31/6NVf8FyLNQOQZAnv9ZwNjucMHVn85Ni7emAe9lKqZTnbB-gzTK0K1ChJdt9vIVYX9G37lvQ.woff2"
    }
)

Write-Host "`nDownloading fonts for self-hosting..." -ForegroundColor Cyan
foreach ($f in $fonts) {
    Write-Host "  $($f.file)..." -NoNewline
    try {
        Invoke-WebRequest -Uri $f.url -OutFile $f.file -UseBasicParsing
        $size = [math]::Round((Get-Item $f.file).Length / 1KB)
        Write-Host " ${size}KB" -ForegroundColor Green
    } catch {
        Write-Host " FAILED: $_" -ForegroundColor Red
    }
}

$count = (Get-ChildItem *.woff2 -ErrorAction SilentlyContinue).Count
Write-Host "`nDone! $count woff2 files downloaded to $(Get-Location)" -ForegroundColor Green
Write-Host "Now commit and push the website repo to deploy.`n" -ForegroundColor Yellow
