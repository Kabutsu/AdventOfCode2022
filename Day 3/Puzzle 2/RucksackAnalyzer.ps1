$Sum = 0
$Data = (Get-Content -Path '..\data.txt' -Delimiter "\n") -split "\n"

for ($i = 0; $i -lt $Data.Length; $i += 3) {
  $a = $Data[$i].ToCharArray()
  $b = $Data[$i + 1].ToCharArray()
  $c = $Data[$i + 2].ToCharArray()

  $abIntersect = ($a | Where-Object { $b -ccontains $_ })
  $intersect = ($abIntersect | Where-Object { $c -ccontains $_ })[0]

  $value = [int]([char]$intersect)

  if ($value -lt 96) { $value -= 38 } else { $value -= 96}

  $Sum += $value
}

Write-Host "Total Sum: $Sum"