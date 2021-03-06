##################################################################################
# Pull PSP data from vSphere hosts
#
#
##################################################################################

# Init and pull data
$creds = Get-Credential
$vc = Read-Host "Enter the vCenter Server name"
Connect-VIServer $vc -Credential $creds | Out-Null
$esxcli = Get-EsxCli -VMHost (Get-VMHost)
New-Variable -Name paths -Value $null -Scope global

function getpsp {
foreach ($vmhost in $esxcli)
	{
	$paths = $vmhost.storage.nmp.device.list() | Where {$_.device -like "*"} `
	| Select-Object devicedisplayname,pathselectionpolicy,storagearraytype,workingpaths
	$paths += $paths
	}
$paths | Sort-Object workingpaths | Out-GridView -Title Paths
}

getpsp