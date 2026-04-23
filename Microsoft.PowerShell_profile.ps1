# --- oh-my-posh---
if (Get-Command oh-my-posh -ErrorAction SilentlyContinue) {
    oh-my-posh init pwsh --config "$HOME\.config\oh-my-posh\gruvbox-slick.omp.json" | Invoke-Expression
}

# --- MODULES ---
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path $ChocolateyProfile) { Import-Module $ChocolateyProfile }
Import-Module Terminal-Icons

# --- TOOLS ---
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    zoxide init powershell | Out-String | Invoke-Expression
}

# --- ENV ---
$env:EDITOR = "nvim"
$env:VISUAL = "nvim"

# --- PSREADLINE ---
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -EditMode Vi
Set-PSReadLineKeyHandler -Chord 'Enter' -ScriptBlock {
    $line = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptSuggestion()
    $newLine = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$newLine, [ref]$cursor)

    if ($newLine -eq $line) {
        # No suggestion was there, just run the command
        [Microsoft.PowerShell.PSConsoleReadLine]::ValidateAndAcceptLine()
    }
    # Otherwise suggestion got accepted, press Enter again to run
}
# Set-PSReadLineKeyHandler -ViMode Insert -Chord 'j,k' -Function ViCommandMode
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler {
    param([Microsoft.PowerShell.ViMode]$mode)
    if ($mode -eq 'Command') { Write-Host -NoNewline "`e[2 q" }
    else { Write-Host -NoNewline "`e[6 q" }
}

# --- FASTFETCH ---
if (Get-Command fastfetch -ErrorAction SilentlyContinue) {
    fastfetch -c "C:/Users/akash/.config/fastfetch/config.jsonc"
}

