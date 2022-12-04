$Sum = 0

(Get-Content -Path '..\data.txt' -Delimiter "\n") -split "\n" | ForEach-Object {
  $half = ($_.Length - 1) / 2
  $a = $_.Substring(0, $half).ToCharArray()
  $b = $_.Substring($half).ToCharArray()

  $intersect = ($a | Where-Object { $b -ccontains $_ })[0]
  $value = [int]([char]$intersect)

  if ($value -lt 96) { $value -= 38 } else { $value -= 96}

  $Sum += $value
}

Write-Host "Total Sum: $Sum"