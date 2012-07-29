$xml_orig = New-Object XML
$xml_orig.Load("Sylink.xml")

$grps = get-content groups.txt
ForEach ($i in $grps) {
$i
$PreferredGroup = $i.toString()
$xml_new = New-Object XML
$xml_new = $xml_orig

$xml_new.ServerSettings.CommConf.RegisterClient.PreferredGroup = $PreferredGroup

$j = $i.Replace("\", "_")
$filename = $j.Replace(" ", "_")
$xml_new.Save($filename + "_Sylink.xml")

remove-variable xml_new

}

