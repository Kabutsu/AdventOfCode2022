$path = 'Day 5\data.txt'
$stream_reader = [System.IO.StreamReader]::new($path)

# Initialize the "crates"
# They will be an array of stacks, so they can be popped and pushed to other "towers"
[System.Collections.ArrayList]$StackBuilder = @()
[System.Collections.ArrayList]$Stacks = @()
$NumberOfStacks = 9

for ($i = 0; $i -lt $NumberOfStacks; $i++) {
  $StackBuilder.Add([System.Collections.ArrayList]@()) >$null
  $Stacks.Add([System.Collections.Stack]@()) >$null
}

# Read the "crates" input
do {
  $current_line = $stream_reader.ReadLine()

  # If the current line is like "[B] [T]     [C] [B]     [G]"
  if ($current_line -match '\s*(\[\w\])') {
    # Split into strings of length 4, e.g. "[B] ", "[T] ", "    ", etc.
    $row = $current_line -split '(.{4})' | Where-Object { $_ }
    
    # Go through the stacks and push on the letter, if it's not blank
    for ($i = 0; $i -lt $StackBuilder.Count; $i++) {
      if ($row[$i] -match '(\w{1})') { # If the current string has a letter, e.g. "[B] "
        $StackBuilder[$i].Add(($row[$i] -replace '(\s*\[)|(\]\s*)', '')) >$null # Push on just the letter, e.g. "B"
      }
    }
  }
} while ("" -ne $current_line) # Loop through until we get to the whitespace line

# Now go through the arrays and push them onto the stacks, so that the last line read is the bottom of each stack
for ($i = 0; $i -lt $NumberOfStacks; $i++) {
  for ($j = $StackBuilder[$i].Count - 1; $j -ge 0; $j--) {
    $Stacks[$i].Push($StackBuilder[$i][$j])
  }

  Write-Host $Stacks[$i]
}

# Now set up the instructions...
[System.Collections.ArrayList]$Instructions = @()

do {
  $current_line = $stream_reader.ReadLine()

  if ($current_line.Length -gt 0) {
    # Just get the numerical values from the instructions
    $values = ($current_line -split '\s?[a-z]+\s?')  | Where-Object { $_ -match '\d+' }

    # Make a custom object that says how many crates should be moved from where to where
    $Instructions.Add([PSCustomObject]@{
      Count = [int]$values[0]
      From = ([int]$values[1]) - 1
      To = ([int]$values[2]) - 1
    }) >$null
  }
} while ($null -ne $current_line) # Loop through until we reach the end of file

$stream_reader.Close()
Write-Host ""

# Now loop through the instructions, moving crates from stack to stack
$Instructions | ForEach-Object {
  Write-Host $_

  [System.Collections.ArrayList]$ToMove = @()
  for ($i = 0; $i -lt $_.Count; $i++) {
    $ToMove.Add($Stacks[$_.From].Pop()) >$null
  }

  for ($i = $ToMove.Count - 1; $i -ge 0; $i--) {
    $Stacks[$_.To].Push($ToMove[$i])
  }

  $Stacks | ForEach-Object {
    Write-Host $_
  }

  Write-Host ""
}

# Finally, pop the top row of each stack to generate the result
$Result = ""
$Stacks | ForEach-Object {
  $Result += $_.Pop()
}

Write-Host "Result: $Result"