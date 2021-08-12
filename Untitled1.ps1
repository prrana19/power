$metadatapath = Get-Content path.txt 
[string[]]$arrayRepos = Get-Content repos.txt

for ($i=0; $i -lt $arrayRepos.Count; $i++) {
    $arrayRepos[$i]
    cd $arrayRepos[$i]
    git ls-files | Where-object {$_ -like "*.cs"}| foreach{",Oh/Odjfs/Sets/$_".replace('/','.')} | foreach{$_ -replace '.cs'} | foreach{$_.Split(".")[-1]+$_} | out-file -Append $metadatapath\temp.txt

}
$metadata= Get-Content $metadatapath\programmetadata.txt
$newmetadata= Get-Content $metadatapath\temp.txt


$Lookup = @{
    "=>" = "Present in temp"
    "<=" = "Present in programmetadata"
    "==" = "Present in both files"
}

Compare-Object -ReferenceObject $metadata -DifferenceObject $newmetadata | Select @{Name="String";Expression={$_.InputObject}},@{Name="Presence";Expression={$Lookup[$_.SideIndicator]}}  | Where-Object -Property Presence -Contains 'Present in temp'| format-list String | out-file $metadatapath\difference.txt


if([String]::IsNullOrWhiteSpace((Get-content $metadatapath\difference.txt))){

Write-Output "Programmetadata.txt is up to date"


}
else{
Get-Content $metadatapath\temp.txt | out-file $metadatapath\programmetadata.txt
}
rm $metadatapath\temp.txt