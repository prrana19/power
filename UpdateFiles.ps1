#Script to update programmetadata.txt 

#Reading path of programmetadata.txt and store it in variable

$metadatapath = Get-Content path.txt 

#Reading all the repositories path and storing it in array.

[string[]]$arrayRepos = Get-Content repos.txt


#For loop to go through all the repos, get all .cs files and format the list as per the requirement.

for ($i=0; $i -lt $arrayRepos.Count; $i++) {
    $arrayRepos[$i]
    cd $arrayRepos[$i]
    git ls-files | Where-object {$_ -like "*.cs"}| Where-object {$_ -like "Pgms/*"}| foreach{",Oh/Odjfs/Sets/$_".replace('/','.')} | foreach{$_ -replace '.cs'} | foreach{$_.Split(".")[-1]+$_} | out-file -Append $metadatapath\temp.txt

}


#Comparing the programmetadata.txt and new temp.txt file generated by for loop.

$metadata= Get-Content $metadatapath\programmetadata.txt
$newmetadata= Get-Content $metadatapath\temp.txt


$Lookup = @{
    "=>" = "Present in temp"
    "<=" = "Present in programmetadata"
    "==" = "Present in both files"
}

Compare-Object -ReferenceObject $metadata -DifferenceObject $newmetadata | Select @{Name="String";Expression={$_.InputObject}},@{Name="Presence";Expression={$Lookup[$_.SideIndicator]}}  | Where-Object -Property Presence -Contains 'Present in temp'| format-list String | out-file $metadatapath\difference.txt



#Checking if there is any value returned for the difference, if not then skip the rest if difference is there then update programmetadata file and push it to git.
  
if([String]::IsNullOrWhiteSpace((Get-content $metadatapath\difference.txt))){

        Write-Output "Programmetadata.txt is up to date"
}
  else{
        Get-Content $metadatapath\temp.txt | out-file $metadatapath\programmetadata.txt
        cd $metadatapath
        git add .
        git commit -m "updating programmetadata.txt"
        git push
}
