$workspace = "C:\Users\prrana\Documents\legacyDevOps\powershell-script\power"
[string[]]$arrayRepos = Get-Content -Path $workspace\GitFilesUpdate\repos.txt
cd $workspace
rm temp.txt

#for ($i=0; $i -lt $arrayRepos.Count; $i++) {
 #   cd $workspace
#    cd $arrayRepos[$i]
#   $file= dir
#  $file.name | Where-object {$_ -like "*.cs"}| foreach{$_ -replace'.cs'} | out-file -Append $workspace\filenamelist.txt
  

  git ls-files | Where-object {$_ -like "*.cs"}| foreach{",Oh/Odjfs/Sets/$_".replace('/','.')} | foreach{$_ -replace '.cs'} | foreach{$_.Split(".")[-1]+$_} | out-file $workspace\GitFilesUpdate\temp.txt

#}