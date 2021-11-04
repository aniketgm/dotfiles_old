#              __________________ 
#          /\  \   __           /  /\    /\           Author      : Aniket Meshram [AniGMe]
#         /  \  \  \         __/  /  \  /  \          Description : This is a powershell configuration file
#        /    \  \       _____   /    \/    \                       similar to .bashrc for bash, which run before
#       /  /\  \  \     /    /  /            \                      the powershell prmpt appears. It contains
#      /        \  \        /  /      \/      \                     configurations such as Aliases, Functions, etc...
#     /          \  \      /  /                \
#    /            \  \    /  /                  \     Github Repo : https://github.com/aniketgm/dotfiles
#   /              \  \  /  /                    \
#  /__            __\  \/  /__                  __\
#

# Set Theme
# ---------
If ( (Get-Module -ListAvailable -Name 'posh-git') -And (Get-Module -ListAvailable -Name 'oh-my-posh') ) {
    Import-Module 'posh-git'
    Import-Module 'oh-my-posh'
    Set-Theme Emodipt
}
Else {
    Write-Output "Modules 'posh-git' and 'oh-my-posh' not found. Attempting installation of these modules..."
    Write-Output "If problem occurs, run powershell as Admin."
    Install-Module 'posh-git'
    Install-Module 'oh-my-posh'
    Write-Output "Done. Restart powershell."
}

# Check chocolatey profile and load
# ---------------------------------
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
If (Test-Path($ChocolateyProfile)) { Import-Module "$ChocolateyProfile" }
Else { Write-Output "Chocolatey is not installed ..." }

# Functions
# ---------
function .. { Set-Location .. }
function assoc { CMD /C "assoc $args" }
function ftype { CMD /C "ftype $args" }
function cmdr  { Set-Location $Env:CMDER_ROOT }
function gca($CmdName) { (Get-Command $CmdName).Parameters.Values | Select Name, Aliases }
function hist  { cat (Get-PSReadLineOption).HistorySavePath }
function phead([Int]$Lines=10){ $Input | Select -First $Lines }
function ptail([Int]$Lines=10){ $Input | Select -Last $Lines }
function q     { exit }
function rmr   { Remove-Item -Recurse -Verbose -Force $Args }
function view($file) { vim -R $file $Args }
function vimrc { vim ~/.vimrc }
function wtpro { vim C:\Users\eo5ayt\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json }

# Activate Virtual Env of a Python Project
function activate([String]$ProjFolder=(Get-Location)) {
    If (Test-Path $ProjFolder\"$((gi *env*).Name)") { & $ProjFolder\"$((gi *env*).Name)\Scripts\Activate.ps1" }
    Else { Write-Output "Goto the python project root folder and then run this command ..." }
}
# Open pdf file in Acrobat Reader
function pdf( [String]$PDFFile ) {
    If ($PDFFile -contains ' ') { $PDFFile = $PDFFile -replace ' ', '`` ' }
    Start AcroRd32.exe `"$PDFFile`"
}

# Google search
function gglSrchStr( [String]$SrchFor ) {
    $SrchFor = $SrchFor.Trim()
    $SrchFor = $SrchFor -Replace "\s+", " "
    $SrchFor = $SrchFor -Replace " ", "+"
    Return "https://www.google.com/search?q=$SrchFor"
}

# Search the web Or Goto a given URL
function web( [String]$SiteURL, [Switch]$Firefox, [Switch]$Brave, [Switch]$InCog, [Switch]$GoogleSrch ) {
    Filter IsFirefox { If ($Firefox.IsPresent) { Return $True } Else { Return $False } }
    Filter IsBrave   { If ($Brave.IsPresent)   { Return $True } Else { Return $False } }
    Filter BrowserArg { If (IsFirefox) { Return "-private-window" } Else { Return "-incognito" } }

    # Default is Chrome Browser
    $BrowserExePath = 'C:\Program Files (x86)\Google\Chrome\Application\chrome.exe'
    If (IsFirefox) { $BrowserExePath = 'C:\Program Files\Mozilla Firefox\firefox.exe' }
    If (IsBrave)   { $BrowserExePath = 'C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe' }
    If ($GoogleSrch.IsPresent) { $SiteURL = (gglSrchStr $SiteURL) }
    If ($InCog.IsPresent) {
        Start -FilePath $BrowserExePath -ArgumentList (BrowserArg), $(

                If (Test-Path $SiteURL) { 'file:///' + (ls $SiteURL).FullName }
                Else { $SiteURL }
        )
    }
    Else { Start -FilePath $BrowserExePath -ArgumentList $SiteURL }
}

# UTF conversion
function U {
    Param([Int]$Code)
    If ((0 -le $Code) -and ($Code -le 0xFFFF)) { return [char] $Code }
    If ((0x10000 -le $Code) -and ($Code -le 0x10FFFF)) { return [char]::ConvertFromUtf32($Code) }
    throw "Invalid character code $Code"
}

# Upload file(s) to Github Repo
function upload {
    Param(
        [Parameter(Position=0)][String]$file,
        [Parameter(Mandatory=$True, Position=1)][String]$msg,
        [Parameter(Position=2)][String]$branch="master"
    )
    Write-Output "Adding to source control ...`n"
    If ( [String]::IsNullOrEmpty($file) ) { git add . }
    Else { git add $file }
    Write-Output "Commiting change(s) ...`n"
    git commit -m $msg
    Write-Output "Pushing to remote Github branch: $branch ..."
    git push origin $branch
}

# Open cmder powershell profile in vim
function vipro( [Switch]$vp ) {
    If ($vp.IsPresent) { vim $Env:CMDER_ROOT\vendor\profile.ps1 }
    Else { vim $Env:CMDER_ROOT\config\user_profile.ps1 }
}

# File Size formatter
function ffs( [System.UInt64]$size ) {
    If     ($size -gt 1TB) {[string]::Format("{0:0.0}T", $size / 1TB)}
    ElseIf ($size -gt 1GB) {[string]::Format("{0:0.0}G", $size / 1GB)}
    ElseIf ($size -gt 1MB) {[string]::Format("{0:0.0}M", $size / 1MB)}
    ElseIf ($size -gt 1KB) {[string]::Format("{0:0.0}K", $size / 1KB)}
    ElseIf ($size -ge 0)   {[string]::Format("{0:0}",    $size)}
    Else                   {""}
}

# Powershell Disk Usage
function pdu( [String]$FoldName ) {
    Write-Output ""
    $DUScriptBlk = {
        Param ( $FoldNameIn )
        $AllOutput = $DirOutput = $FilOutput = @()
        $TotalSize = 0
        Get-ChildItem $FoldNameIn -Directory | %{
            $Output = [PSCustomObject]@{
                ContentName = "$($_.Name)/"
                SizeOnDisk  = $(
                    $Tmp = (ls -LiteralPath $_.FullName -Recurse -EA SilentlyContinue | Measure-Object -Property Length -Sum -EA SilentlyContinue).Sum
                    If ([String]::IsNullOrEmpty($Tmp)) { 0 } Else { $Tmp }
                )
             }
            $DirOutput += $Output
            $TotalSize += $Output.SizeOnDisk
        }
        $AllOutput += ($DirOutput | Sort-Object -Property SizeOnDisk -Descending)
        Get-ChildItem $FoldNameIn -File | %{
            $Output = [PSCustomObject]@{
                ContentName = $_.Name
                SizeOnDisk  = (ls $_.FullName -EA SilentlyContinue | Measure-Object -Property Length -Sum -EA SilentlyContinue).Sum
             }
            $FilOutput += $Output
            $TotalSize += $Output.SizeOnDisk
        }
        $AllOutput += ($FilOutput | Sort-Object -Property SizeOnDisk -Descending)

        Write-Output ""
        Write-Output "`n## Total Size : $( ffs $TotalSize )"
        $AllOutput |
        Format-Table @{Label="Size";     Expression={ ffs $_.SizeOnDisk }},
                     @{Label="Contents"; Expression={ $_.ContentName }}
    }
    spinner -ScriptToExec $DUScriptBlk -Label "Calculating size ..." -OtherArgs (gi $FoldName).FullName
}

# Spinner. Cyles through -- [ '|',  '/', '-', '\' ]
function spinner( [Scriptblock]$ScriptToExec, [String]$Label, [String]$OtherArgs ) {
    $job = Start-Job -ScriptBlock $ScriptToExec -ArgumentList $OtherArgs
    $symbols = @("[|]", "[/]", "[-]", "[\]")
    $TimerWatch = [System.Diagnostics.Stopwatch]::StartNew()
    $WaitMessage = "[may take some time ...]"
    $i = 0
    while ( $job.State -eq "Running" ) {
        $symbol =  $symbols[$i]
        Write-Host -NoNewLine "`r$symbol $Label $(If ($TimerWatch.Elapsed.Seconds -gt 30) { $WaitMessage } )" -ForegroundColor Green
        Start-Sleep -Milliseconds 100
        $i += 1
        if ($i -eq $symbols.Count) { $i = 0 }
    }
    Write-Host -NoNewLine "`r"
    If ($job.State -eq 'Failed') { Write-Output ($job.ChildJobs[0].JobStateInfo.Reason.Message) }
    Else {
        $JobOutput = Receive-Job -Job $job 6>&1
        Write-Output $JobOutput
    }
}

# Convert file from DOS to Unix format
function ps_dos2unx([String]$FileToConvert) {
    If (Test-Path -Type Leaf $FileToConvert) {
        $FilePath = (ls $FileToConvert).FullName
        $AllTxt = Get-Content -Raw $FilePath | %{ $_ -replace "`r`n", "`n" }
        [IO.File]::WriteAllText('.\wntx64\log\libmfg_all_err', $AllTxt)
    }
}

# Timed Out Choice, returns default choice if no choice is entered with 10 secs
function timedOutChoice {
    Param (
        [Parameter( Mandatory = $True )][Alias('m')][String]$PromptMsg,
        [Parameter( Mandatory = $True )][Alias('d')][String]$DefChoice,
        [Alias('t')][Int]$TimeoutSec = 10
    )

    $TimeOut = New-TimeSpan -Seconds $TimeoutSec
    $StopWatch = [System.Diagnostics.StopWatch]::StartNew()

    If (-Not [String]::IsNullOrEmpty($PromptMsg)) { Write-Output -NoNewline ($PromptMsg + "[y/n]: ") }
    While ( $StopWatch.Elapsed.Seconds -lt $TimeOut.Seconds ) {
        If ( $Host.UI.RawUI.KeyAvailable ) {
            $KeyPressed = $Host.UI.RawUI.ReadKey("NoEcho, IncludeKeyUp, IncludeKeyDown")
            If ($KeyPressed.KeyDown -eq "True") {
                Return [System.Char]::ToUpper($KeyPressed.Character)
            }
        }
    }
    Return $DefChoice
}

# Aliases
# -------
If ( Get-Command Get-ChildItemColor -ErrorAction SilentlyContinue ) {
    New-Alias -Name lsc Get-ChildItemColor
    New-Alias -Name lsw Get-ChildItemColorFormatWide
}
If ( Test-Path "${Env:ProgramFiles(x86)}\Notepad++" ) {
    New-Alias -Name np -Value "${Env:ProgramFiles(x86)}\Notepad++\notepad++.exe"
}
ElseIf ( Test-Path "$Env:ProgramFiles\Notepad++" ) {
    New-Alias -Name np -Value "$Env:ProgramFiles\Notepad++\notepad++.exe"
}
If ( (Test-Path "C:\cygwin64") -Or (Test-Path "C:\cygwin") ) {
    $CYGWIN_ROOT = "C:\cygwin64"
    If ( ! Test-Path $CYGWIN_ROOT ) { $CYGWIN_ROOT = "C:\cygwin" }
    New-Alias -Name 'lfind' -Value $CYGWIN_ROOT\bin\find.exe -Scope 'Global'
    New-Alias -Name 'ltree' -Value $CYGWIN_ROOT\bin\tree.exe -Scope 'Global'
}
New-Alias -Name 'reboot' -Value Restart-Computer

# Other Stuff
# -----------
Register-ArgumentCompleter -CommandName pdf -ScriptBlock {
    Param($WrdToCmp)
    Get-ChildItem $WrdToCmp*.pdf
}
