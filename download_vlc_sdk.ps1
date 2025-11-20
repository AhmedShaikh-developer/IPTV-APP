# PowerShell script to download and extract VLC SDK
# Run this script as Administrator

Write-Host "=== VLC SDK Downloader ===" -ForegroundColor Cyan
Write-Host ""

# VLC version (update if needed)
$VLC_VERSION = "3.0.21"
$VLC_SDK_URL = "https://download.videolan.org/pub/videolan/vlc/$VLC_VERSION/win64/vlc-$VLC_VERSION-win64.7z"

# VLC installation directory
$VLC_DIR = "C:\Program Files\VideoLAN\VLC"

# Check if VLC is installed
if (-not (Test-Path $VLC_DIR)) {
    Write-Host "ERROR: VLC not found at $VLC_DIR" -ForegroundColor Red
    Write-Host "Please install VLC first from https://www.videolan.org/vlc/" -ForegroundColor Yellow
    exit 1
}

Write-Host "VLC found at: $VLC_DIR" -ForegroundColor Green
Write-Host ""

# Check if SDK already exists
if (Test-Path "$VLC_DIR\sdk") {
    Write-Host "SDK folder already exists at: $VLC_DIR\sdk" -ForegroundColor Yellow
    $response = Read-Host "Do you want to overwrite it? (y/n)"
    if ($response -ne "y") {
        Write-Host "Aborted." -ForegroundColor Yellow
        exit 0
    }
}

Write-Host "Attempting to download VLC SDK..." -ForegroundColor Cyan
Write-Host "URL: $VLC_SDK_URL" -ForegroundColor Gray
Write-Host ""

# Check if 7-Zip is available
$7zipPath = $null
$possiblePaths = @(
    "C:\Program Files\7-Zip\7z.exe",
    "C:\Program Files (x86)\7-Zip\7z.exe",
    "$env:ProgramFiles\7-Zip\7z.exe",
    "$env:ProgramFiles(x86)\7-Zip\7z.exe"
)

foreach ($path in $possiblePaths) {
    if (Test-Path $path) {
        $7zipPath = $path
        break
    }
}

if (-not $7zipPath) {
    Write-Host "ERROR: 7-Zip not found!" -ForegroundColor Red
    Write-Host "Please install 7-Zip from https://www.7-zip.org/" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Alternative: Download VLC SDK manually:" -ForegroundColor Yellow
    Write-Host "1. Visit: https://download.videolan.org/pub/videolan/vlc/" -ForegroundColor Cyan
    Write-Host "2. Navigate to version folder (e.g., $VLC_VERSION/win64/)" -ForegroundColor Cyan
    Write-Host "3. Download vlc-sdk-*.7z or vlc-*-win64.7z" -ForegroundColor Cyan
    Write-Host "4. Extract and copy 'sdk' folder to: $VLC_DIR\" -ForegroundColor Cyan
    exit 1
}

Write-Host "7-Zip found at: $7zipPath" -ForegroundColor Green
Write-Host ""

# Create temp directory
$tempDir = "$env:TEMP\vlc_sdk_download"
if (Test-Path $tempDir) {
    Remove-Item $tempDir -Recurse -Force
}
New-Item -ItemType Directory -Path $tempDir | Out-Null

$downloadFile = "$tempDir\vlc-sdk.7z"

try {
    # Download VLC SDK
    Write-Host "Downloading VLC SDK (this may take a few minutes)..." -ForegroundColor Cyan
    Invoke-WebRequest -Uri $VLC_SDK_URL -OutFile $downloadFile -UseBasicParsing
    
    if (-not (Test-Path $downloadFile)) {
        throw "Download failed"
    }
    
    Write-Host "Download complete!" -ForegroundColor Green
    Write-Host ""
    
    # Extract SDK
    Write-Host "Extracting SDK..." -ForegroundColor Cyan
    & $7zipPath x "$downloadFile" -o"$tempDir\extracted" -y | Out-Null
    
    # Find SDK folder in extracted files
    $sdkPath = Get-ChildItem -Path "$tempDir\extracted" -Recurse -Directory -Filter "sdk" | Select-Object -First 1
    
    if (-not $sdkPath) {
        # Try alternative: look for include/vlc/vlc.h
        $vlcHeader = Get-ChildItem -Path "$tempDir\extracted" -Recurse -Filter "vlc.h" | Select-Object -First 1
        if ($vlcHeader) {
            $sdkPath = $vlcHeader.Directory.Parent.Parent
            Write-Host "Found SDK structure at: $sdkPath" -ForegroundColor Green
        }
    }
    
    if (-not $sdkPath) {
        throw "SDK folder not found in downloaded archive"
    }
    
    # Copy SDK to VLC directory
    Write-Host "Copying SDK to VLC directory..." -ForegroundColor Cyan
    $targetSdk = "$VLC_DIR\sdk"
    
    if (Test-Path $targetSdk) {
        Remove-Item $targetSdk -Recurse -Force
    }
    
    Copy-Item -Path "$sdkPath\*" -Destination $targetSdk -Recurse -Force
    
    Write-Host ""
    Write-Host "SUCCESS! SDK installed to: $targetSdk" -ForegroundColor Green
    Write-Host ""
    Write-Host "Verifying installation..." -ForegroundColor Cyan
    
    if (Test-Path "$targetSdk\include\vlc\vlc.h") {
        Write-Host "✓ Header files found" -ForegroundColor Green
    } else {
        Write-Host "✗ Header files missing" -ForegroundColor Red
    }
    
    if (Test-Path "$targetSdk\lib") {
        Write-Host "✓ Library directory found" -ForegroundColor Green
    } else {
        Write-Host "✗ Library directory missing" -ForegroundColor Red
    }
    
} catch {
    Write-Host ""
    Write-Host "ERROR: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host ""
    Write-Host "Manual installation steps:" -ForegroundColor Yellow
    Write-Host "1. Visit: https://download.videolan.org/pub/videolan/vlc/" -ForegroundColor Cyan
    Write-Host "2. Download VLC SDK package for Windows" -ForegroundColor Cyan
    Write-Host "3. Extract and copy 'sdk' folder to: $VLC_DIR\" -ForegroundColor Cyan
} finally {
    # Cleanup
    if (Test-Path $tempDir) {
        Remove-Item $tempDir -Recurse -Force
    }
}

Write-Host ""
Write-Host "Done!" -ForegroundColor Green

