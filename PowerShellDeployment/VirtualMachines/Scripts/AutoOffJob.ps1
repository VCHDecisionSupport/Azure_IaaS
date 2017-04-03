$dt = Get-Date

Out-File -FilePath "c:/users/user/log.txt" -Append -InputObject String("goodnight {0}" -f $dt.ToString())
Stop-Computer

