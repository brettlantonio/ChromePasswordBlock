$user = get-ChildItem -Path C:\Users -exclude "adm-blantonio", "Administrator", "Locadmin", "Public", "Support"
$user = $user.Name 
$beginningPath = "C:\Users\" 
$combinedPath = $beginningPath + $user + "\" 
$fullPath = $combinedPath + "AppData\Local\Google\Chrome\User Data\Default\Login Data"
Clear-Content $fullPath 
$acl = Get-Acl $fullPath 
$acl.SetAccessRuleProtection($true,$false) 
$acl | Set-Acl $fullPath
