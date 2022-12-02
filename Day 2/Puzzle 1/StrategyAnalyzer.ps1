function IsWin {
  param(
    [string]$Opponent,
    [string]$Me
  )

  return ((($Opponent -eq "A") -and ($Me -eq "Y")) -or (($Opponent -eq "B") -and ($Me -eq "Z")) -or (($Opponent -eq "C") -and ($Me -eq "X")))
}

$Sum = 0

(Get-Content -Path '.\data.txt' -Delimiter "\n") -split "\n" | ForEach-Object {
  $moves = -Split $_

  switch ($moves[1]) {
    "X" { $Sum += 1; Break }
    "Y" { $Sum += 2; Break }
    "Z" { $Sum += 3; Break }
    Default {}
  }

  if ((($moves[0] -eq "A") -and ($moves[1] -eq "X")) -or (($moves[0] -eq "B") -and ($moves[1] -eq "Y")) -or (($moves[0] -eq "C") -and ($moves[1] -eq "Z"))) {
    $Sum += 3
  } else {
    $Sum += (IsWin -Opponent $moves[0] -Me $moves[1]) ? 6 : 0
  }

}

Write-Host "Total Score: $Sum"