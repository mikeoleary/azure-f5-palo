param(
    [string] $srcBlob,
	[string] $destStorageAcctName,
    [string] $destFileShare,
    [string] $publicIP,
	[string] $StorageAccountKey
    )

apt-get update

apt-get install wget
wget -O azcopy_v10.tar.gz https://aka.ms/downloadazcopy-v10-linux && tar -xf azcopy_v10.tar.gz --strip-components=1
#optional line below will remove any previous versions of azcopy
rm /usr/bin/azcopy
cp ./azcopy /usr/bin/

azcopy cp $srcBlob "/var/tmp" --recursive=true

#replace values in XML file with public IP values
$filesToUpdate = @("/var/tmp/paloaltobootstrapfiles/pavm1/config/bootstrap.xml", "/var/tmp/paloaltobootstrapfiles/pavm2/config/bootstrap.xml")

foreach ($file in $filesToUpdate) {
	$xml = New-Object XML
	$xml.Load($file)
	$nodeToUpdate1 = $xml.config.devices.entry.vsys.entry.rulebase.security.rules.entry.destination.member = $publicIP
	$nodeToUpdate2 = $xml.config.devices.entry.vsys.entry.rulebase.nat.rules.entry.destination.member = $publicIP
	$xml.Save($file)
}

#create a SAS Token to upload to new Storage Account
$StorageContext = New-AzStorageContext -StorageAccountName $destStorageAcctName -StorageAccountKey $StorageAccountKey
$SAStoken = New-AzStorageAccountSASToken -Service File -ResourceType Service,Container,Object -Permission racwdlup -Context $StorageContext -ExpiryTime (Get-Date).AddHours(+1)

azcopy cp "/var/tmp/paloaltobootstrapfiles/*" "$destFileShare$SAStoken" --recursive=true