# This script adds a given folder that is passed as argument to this script,
# to the User Env Variable -- 'PATH'.
# If User Env Variable 'PATH' does not exist it will be created.

Param(
    [Alias('ap')][String]$PathToAdd,
    [Alias('dp')][String]$PathToDelete
)

$UserEnvVarPath = [System.Environment]::GetEnvironmentVariable('PATH', [System.EnvironmentVariableTarget]::User)
If ( (-Not [String]::IsNullOrEmpty( $PathToAdd )) -And (Test-Path $PathToAdd) ) {
    $UserEnvVarPath += $( If ( $UserEnvVarPath[-1] -eq ';') { "$PathToAdd" } Else { ";$PathToAdd" } )
    [System.Environment]::SetEnvironmentVariable('PATH', $UserEnvVarPath, [System.EnvironmentVariableTarget]::User)
    Write-Output ""
    Write-Output "Added Path: '$PathToAdd' to User Env Variable: 'PATH'"
    Write-Output ""
}
ElseIf  ( -Not [String]::IsNullOrEmpty( $PathToDelete ) ) {
    [Bool]$DoDelete = $True
    If ( Test-Path $PathToDelete ) {
        $Ch = Read-Host("`nThe Path to delete exists. Still delete? [Y/N]")
        If ( -Not @('Y', 'y').contains($Ch) ) { $DoDelete = $False }
    }
    If ( $DoDelete ) {
        $EnvWithRemovedPath = ($UserEnvVarPath -split ';') -replace [Regex]::Escape( $PathToDelete ), '' | ?{ $_ -notlike "" }
        [System.Environment]::SetEnvironmentVariable('PATH', [String]::Join( ';', $EnvWithRemovedPath ), [System.EnvironmentVariableTarget]::User)
        Write-Output ""
        Write-Output "Removed Path: '$PathToDelete' from User Env Variable: 'PATH'"
        Write-Output ""
    }
    Else {
        Write-Output ""
        Write-Output "$PathToDelete not deleted from $PATH Env Variable"
        Write-Output ""
    }
}
Else {
    Write-Output ""
    Write-Output "Path not found. Either the path entered is incorrect, if not,"
    Write-Output "try again by entering full path"
    Write-Output ""
}
