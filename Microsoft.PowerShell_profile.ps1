
try {
    # --- Oh-My-Posh Initialization ---
    #oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\kushal.omp.json" | Invoke-Expression
    oh-my-posh init pwsh --config "$HOME\.config\oh-my-posh\gruvbox-slick.omp.json" | Invoke-Expression

    # --- Chocolatey Profile Import ---
    # Import the Chocolatey Profile that contains the necessary code to enable
    # tab-completions to function for `choco`.
    # Be aware that if you are missing these lines from your profile, tab completion for `choco` will not function.
    $ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
    if (Test-Path($ChocolateyProfile)) {
        Import-Module "$ChocolateyProfile"
    }
       
    # --- Terminal-Icons Module ---
    Import-Module -Name Terminal-Icons

    Invoke-Expression (& { (zoxide init powershell | Out-String) })

    $env:EDITOR = "nvim"
    $env:VISUAL = "nvim"
    
    # --- Enable PowerShell Autosuggestions (Predictions) ---
    # Make sure to run this command before enabling the prediction source.
    # (Install-Module -Name PSReadLine -Force)

    Set-PSReadLineOption -PredictionSource history

    # Force Fastfetch to use YOUR config every time 
    if (Get-Command fastfetch -ErrorAction SilentlyContinue) {
        fastfetch -c "C:/Users/akash/.config/fastfetch/config.jsonc"
    }

}
catch {
    # This block will safely catch any errors from the commands above.
    # It prevents the terminal from crashing and shows you the error message.
    Write-Warning "An error occurred while loading the PowerShell profile."
    # The $_ variable contains the actual error record.
    Write-Warning $_.Exception.Message
}




