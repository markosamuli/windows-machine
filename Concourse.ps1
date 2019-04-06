
$ConcourseRepository = "concourse/concourse"
$LatestReleaseURL = "https://api.github.com/repos/$ConcourseRepository/releases/latest"
$ConcourseRelease = Invoke-RestMethod -Method Get -Uri $LatestReleaseURL -ContentType 'application/json' | 
Select-Object -Property tag_name, assets, created_at, published_at
$ConcourseVersion = $ConcourseRelease.tag_name

$ConcourseURL = "https://github.com/$ConcourseRepository/releases/download/$ConcourseVersion"
$ConcoursePath = "$Home\opt\concourse"
$ConcourseBinaryURL = "$ConcourseURL/concourse_windows_amd64.exe"
$ConcourseBinaryPath = "$ConcoursePath\concourse.exe"
$FlyBinaryURL = "$ConcourseURL/fly_windows_amd64.exe"
$FlyBinaryPath = "$ConcoursePath\fly.exe"

If (!(test-path $ConcoursePath)) 
{
    New-Item -ItemType directory -Path $ConcoursePath
    [Environment]::SetEnvironmentVariable("ConcoursePath", "$ConcoursePath", "User")
    $CurrentPath = [Environment]::GetEnvironmentVariable("PATH", "User")
    $NewPath = $CurrentPath + ";$ConcoursePath"
    $CurrentPath = [Environment]::SetEnvironmentVariable("PATH", "$NewPath", "User")
}

Invoke-WebRequest -Uri $FlyBinaryURL -OutFile $FlyBinaryPath
Invoke-WebRequest -Uri $ConcourseBinaryURL -OutFile $ConcourseBinaryPath