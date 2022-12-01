[System.Collections.ArrayList]$Inventories = @(0)
$i = 0

(Get-Content -Path '.\data.txt') | ForEach-Object {
  if (0 -eq $_) {
    $i++
    $Inventories.Add(0)
  } else {
    $Inventories[$i] += $_
  }
}

Write-Host "Top Calories:"($Inventories | Sort-Object -Descending)[0]