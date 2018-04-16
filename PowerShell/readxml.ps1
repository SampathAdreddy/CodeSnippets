
#folder path for the XMl files
$folderPath = "C:\bk\"

Get-ChildItem -Path $folderPath + '\Source'  -Filter *xml | ForEach-Object { 
$RecordCount= 0 
Write-Host "Reading file: "  $_.Name
#Select-Xml -XPath '//Table' -Path $_.FullName | foreach { $Count++} -ErrorAction SilentlyContinue 

#Read XML document
$doc = [xml](Get-Content -Path $_.FullName)
#Check selected nodes and look 'for' Table node
$rows = $doc.selectnodes("//Table")
$RecordCount = $rows.count
Write-Host "Record Count: " $RecordCount

#Create new attribute
$attr = $doc.CreateAttribute("TotalRecordsCount")
#Update attribute with the Record Count
$attr.psbase.Value = $Count
$doc.psbase.DocumentElement.SetAttributeNode($attr)

$doc.Save($folderPath  + '\Target\' + $_.Name)
Write-Host "File: "  $_.Name " updated with record count successfully."
}