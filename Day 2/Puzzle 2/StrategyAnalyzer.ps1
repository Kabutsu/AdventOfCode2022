$Sum = 0

(Get-Content -Path '.\data.txt' -Delimiter "\n") -split "\n" | ForEach-Object {
  $moves = -Split $_

  if ($moves[1] -eq "X") {
    switch ($moves[0]) {
      "A" { $Sum += 3; Break }
      "B" { $Sum += 1; Break }
      "C" { $Sum += 2; Break }
      Default {}
    }
  } elseif ($moves[1] -eq "Y") {
    switch ($moves[0]) {
      "A" { $Sum += 4; Break }
      "B" { $Sum += 5; Break }
      "C" { $Sum += 6; Break }
      Default {}
    }
  } elseif ($moves[1] -eq "Z") {
    switch ($moves[0]) {
      "A" { $Sum += 8; Break }
      "B" { $Sum += 9; Break }
      "C" { $Sum += 7; Break }
      Default {}
    }
  }
}

Write-Host "Total Score: $Sum"