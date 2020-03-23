

filter MultiSelect-String( [string[]]$Patterns ) {
    # Check the current item against all patterns.
    foreach( $Pattern in $Patterns ) {
      # If one of the patterns does not match, skip the item.
      $matched = @($_ | Select-String -Pattern $Pattern)
      if( -not $matched ) {
        return
      }
    }
  
    # If all patterns matched, pass the item through.
    #$_ 
     Select Filename,LineNumber,line | Format-table -AutoSize | Out-File -Width 512 E:\VScode\PowerShell\grep\log.txt -Append

  } 