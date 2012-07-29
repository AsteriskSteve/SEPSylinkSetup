$update = @"
C:\"Program Files"\7-Zip\7z.exe u
"@
$delete = @"
C:\"Program Files"\7-Zip\7z.exe d  
"@
$MakeSFX = "D:\temp\MakeSFX.exe"
$setup_src = "D:\temp\input.zip"
$setup_dst = "D:\Program Files\Symantec\SEP Agents\bulk\"
$sylink_dir = "D:\Program Files\Symantec\SEP Agents\Sylink\"
$domains_txt = $sylink_dir + "domains.txt"
$bits = "_x64"
$type = "_Server"


$domains = get-content $domains_txt



ForEach ($d in $domains) {

	$d
	$group_file = $sylink_dir + $d + "\groups.txt"
	$grps = get-content $group_file
	ForEach ($g in $grps) {
		
		$i = $g.Replace("\", "_")
		$j = $i.Replace(" ", "_")
		$j

		$sylink_file = $sylink_dir + $d + "\" + $j + "_SyLink.xml" 
		$sylink_in = "d:\temp\" + "Sylink.xml"
		copy-item $sylink_file $sylink_in

		CMD /c $delete $setup_src "Sylink.xml"
		
		CMD /c $update $setup_src $sylink_in
		
		$output_path = $setup_dst + $d + "\" + $j
		mkdir $output_path
		$output_file = $output_path + "\" + $j + $type + $bits + "_setup.exe"
		

		& $MakeSFX /zip=$setup_src /sfx=$output_file /title="Symantec Endpoint Protection" /defaultpath='$temp$\sepinst' /autoextract /delete /exec='$temp$\sepinst\setup.exe' /overwrite /noGUI

	}


}

