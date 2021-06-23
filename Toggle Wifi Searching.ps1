$newStatus = ""

$settings = netsh wlan show settings
$interfaceName = ($settings | Select-String -Pattern 'interface "(.*)"').Matches.Groups[1].Value
$currentStatus = ($settings | Select-String -Pattern 'Auto configuration logic is (.*) on').Matches.Groups[1].Value

if($currentStatus -eq 'enabled') {
	$newStatus = "no"
}
if($currentStatus -eq 'disabled'){
	$newStatus = "yes"
}

if($newStatus){
	netsh wlan set autoconfig enabled=$newStatus interface="$interfaceName"

	$duration = 100
	$C4 = 261
	# $E4 = 330
	$G4 = 392
	
	if($newStatus -eq "yes")
	{
		[console]::beep($C4,$duration)
		# [console]::beep($E4,$duration)
		[console]::beep($G4,$duration)
	}
	
	if($newStatus -eq "no")
	{
		[console]::beep($G4,$duration)
		# [console]::beep($E4,$duration)
		[console]::beep($C4,$duration)
	}
}



