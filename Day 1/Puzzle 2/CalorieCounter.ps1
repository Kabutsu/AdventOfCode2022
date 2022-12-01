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

($Inventories | Sort-Object -Descending)[0..2] | ForEach-Object { $Answer += $_ }

Write-Host "Top 3 Calories: $Answer"