$Sum = 0

(Get-Content -Path '..\data.txt' -Delimiter "\n") -split "\n" | ForEach-Object {
  $assignments = $_ -split ","

  $a = $assignments[0].ToString() -split "-"
  [System.Collections.ArrayList]$aArray = @()

  for ($i = [int]$a[0]; $i -le [int]$a[1]; $i++) {
    $aArray.Add($i) >$null
  }

  $b = $assignments[1].ToString() -split "-"
  [System.Collections.ArrayList]$bArray = @()

  for ($i = [int]$b[0]; $i -le [int]$b[1]; $i++) {
    $bArray.Add($i) >$null
  }

  $overlap = @($aArray | Where-Object { $bArray -contains $_ }).Count

  if ($overlap) {
    $Sum++
  }
}

Write-Host "Total Overlaps: $Sum"