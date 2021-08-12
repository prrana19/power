$workspace = "C:\Users\prrana\Documents\legacyDevOps\powershell-script\power"
[string[]]$arrayRepos = Get-Content -Path $workspace\repos.txt
cd $workspace
rm temp.txt
rm difference.txt

for ($i=0; $i -lt $arrayRepos.Count; $i++) {
    cd $workspace
    cd $arrayRepos[$i]
   $file= dir
#  $file.name | Where-object {$_ -like "*.cs"}| foreach{$_ -replace'.cs'} | out-file -Append $workspace\filenamelist.txt
  

  git ls-files | Where-object {$_ -like "*.cs"}| foreach{",Oh/Odjfs/Sets/$_".replace('/','.')} | foreach{$_ -replace '.cs'} | foreach{$_.Split(".")[-1]+$_} | out-file $workspace\temp.txt

}
[string[]]$newList = Get-Content -Path $workspace\temp.txt
[string[]]$oldList = Get-Content -Path $workspace\programmetadata.txt

for ($i=0; $i -lt $newList.Count; $i++){
 $n=0

    for($j=0; $j -lt $oldList.Count; $j++){

        if ($newList[$i] -ne $oldList[$j]){
            $n=$n+1  

        }else{

          Write-Output "skip"  

        }
   } if ($n -eq $oldList.Count){
    $newList[$i] | out-file -Append $workspace\difference.txt
   
   }else{
   Write-Output "File is already up-to-date"
   
   }

}