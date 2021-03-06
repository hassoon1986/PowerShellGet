# Create install locations for scripts if they are not already created
if(-not (Microsoft.PowerShell.Management\Test-Path -Path $script:ProgramFilesInstalledScriptInfosPath) -and (Test-RunningAsElevated))
{
    $ev = $null
    $null = Microsoft.PowerShell.Management\New-Item -Path $script:ProgramFilesInstalledScriptInfosPath `
                                                     -ItemType Directory `
                                                     -Force `
                                                     -ErrorVariable ev `
                                                     -ErrorAction SilentlyContinue `
                                                     -WarningAction SilentlyContinue `
                                                     -Confirm:$false `
                                                     -WhatIf:$false

    if($ev)
    {
        $script:IsRunningAsElevated = $false
    }
}

if(-not (Microsoft.PowerShell.Management\Test-Path -Path $script:MyDocumentsInstalledScriptInfosPath))
{
    $null = Microsoft.PowerShell.Management\New-Item -Path $script:MyDocumentsInstalledScriptInfosPath `
                                                     -ItemType Directory `
                                                     -Force `
                                                     -Confirm:$false `
                                                     -WhatIf:$false
}

# allow -repository params to be tab-completed
$commandsWithRepositoryParameter = @(
    "Find-Command"
    "Find-DscResource"
    "Find-Module"
    "Find-RoleCapability"
    "Find-Script"
    "Install-Module"
    "Install-Script"
    "Publish-Module"
    "Publish-Script"
    "Save-Module"
    "Save-Script")

$commandsWithRepositoryAsName = @(
    "Get-PSRepository",
    "Register-PSRepository"
    "Unregister-PSRepository"
)

Add-ArgumentCompleter -Cmdlets $commandsWithRepositoryParameter -ParameterName "Repository"
Add-ArgumentCompleter -Cmdlets $commandsWithRepositoryAsName -ParameterName "Name"

Set-Alias -Name fimo -Value Find-Module
Set-Alias -Name inmo -Value Install-Module
Set-Alias -Name upmo -Value Update-Module
Set-Alias -Name pumo -Value Publish-Module
Set-Alias -Name uimo -Value Uninstall-Module

Export-ModuleMember -Alias fimo, inmo, upmo, pumo, uimo
