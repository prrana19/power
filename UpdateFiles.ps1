$workspace = "C:\Users\prrana\Documents\legacyDevOps\powershell-script\power"
[string[]]$arrayRepos = Get-Content -Path $workspace\repos.txt
cd $workspace
rm temp.txt

for ($i=0; $i -lt $arrayRepos.Count; $i++) {
    cd $workspace
    cd $arrayRepos[$i]
   $file= dir
#  $file.name | Where-object {$_ -like "*.cs"}| foreach{$_ -replace'.cs'} | out-file -Append $workspace\filenamelist.txt
  

  git ls-files | Where-object {$_ -like "*.cs"}| foreach{",Oh/Odjfs/Sets/$_".replace('/','.')} | foreach{$_ -replace '.cs'} | foreach{$_.Split(".")[-1]+$_} | out-file $workspace\temp.txt

}


$metadata= Get-Content $workspace\programmetadata.txt
$newmetadata= Get-Content $workspace\temp.txt


$Lookup = @{
    "=>" = "Present in temp"
    "<=" = "Present in programmetadata"
    "==" = "Present in both files"
}

Compare-Object -ReferenceObject $metadata -DifferenceObject $newmetadata | Select @{Name="String";Expression={$_.InputObject}},@{Name="Presence";Expression={$Lookup[$_.SideIndicator]}}  | Where-Object -Property Presence -Contains 'Present in temp'| format-list String | out-file $workspace\stringList.txt
$stringArray = Get-Content $workspace\stringList.txt | foreach{$_.Split(":")[-1]} | out-file $workspace\fileList.txt
$lasthope= Get-Content $workspace\fileList.txt | where{$_ -ne ""} | foreach{$_ -replace "nul"}| Out-File -Append $workspace\programmetadata.txt

