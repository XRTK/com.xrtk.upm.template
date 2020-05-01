$NewPlatformName = Read-Host "Enter a name for your new platform or project"
$PlatformTemplate = "PlatformName"

Write-Host "Your new $NewPlatformName project is being updated..."

$excludes = @('*com.xrtk.core*', '*Library*', '*Obj*','*InitializeTemplate*')

# Rename any directories before we crawl the folders
Rename-Item -Path ".\XRTK.PlatformName" -NewName ".\XRTK.$NewPlatformName"
Rename-Item -Path ".\XRTK.$NewPlatformName\Packages\com.xrtk.platformname" -NewName "com.xrtk.$($NewPlatformName.ToLower())"

Get-ChildItem -Path "*"-File -Recurse -Exclude $excludes | ForEach-Object -Process {
  $isValid = $true

  foreach ($exclude in $excludes) {
    if ((Split-Path -Path $_.FullName -Parent) -ilike $exclude) {
      $isValid = $false
      break
    }
  }

  if ($isValid) {
    Get-ChildItem -Path $_ -File | ForEach-Object -Process {
      $updated = $false;

      $fileContent = Get-Content $($_.FullName) -Raw

      if ($fileContent -cmatch $PlatformTemplate) {
        $fileContent -creplace $PlatformTemplate, $NewPlatformName | Set-Content $($_.FullName)
        $updated = $true
      }

      $fileContent = Get-Content $($_.FullName) -Raw

      if ($fileContent -cmatch $PlatformTemplate.ToLower()) {
        $fileContent -creplace $PlatformTemplate.ToLower(), $NewPlatformName.ToLower() | Set-Content $($_.FullName)
        $updated = $true
      }

      if ($updated) {
        Write-Host $_.Name
      }
    }
  }
}

