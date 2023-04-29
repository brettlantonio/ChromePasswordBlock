# ChromePasswordBlock
Simple scripts to stop chrome from syncing passwords when logged in. Currently Chrome allows organizations to manage the browser, but this just prevents users from saving new passwords in the browser. The below powershell script will prevent chrome from pulling already existing saved passwords for users who are signed into chrome by means of clearing the Chrome Login data file and restricting both system and user access to this file (when the file is cleared and locked, chrome can't edit the file to pull hashed passwords and usernames into the sqllite database chrome reads from).

The powershell script includes three placeholders where usernames will be stored, this is commonly done when an admin is running this script on a users computer and wants to target just that users system files. The -exclude keyword excludes these usernames from being returned in the search.


## Windows 10 / 11

Ex.) $user = get-ChildItem -Path C:\Users -exclude "exampleUserOne", "exampleUserTwo", "exampleUserThree" 

This searches for all child directories in the C:\Users path on windows, excluding results for "exampleUserOne", "exampleUserTwo", and "exampleUserThree" which could be local administrator accounts or other shared accounts. 


```
#Getting the username of the user on the computer, excluding example users one, two three
$user = get-ChildItem -Path C:\Users -exclude "exampleUserOne", "exampleUserTwo", "exampleUserThree" 
$user = $user.Name 
#Building the beginning path of the Login Data path
$beginningPath = "C:\Users\" 
#Combining the beginning path with the user name
$combinedPath = $beginningPath + $user + "\" 
#Building the full path to the login data file used by chrome to sync passwords
$fullPath = $combinedPath + "AppData\Local\Google\Chrome\User Data\Default\Login Data" 
#Clearing the Login Data file content
Clear-Content $fullPath 
#Getting the ACL for the Login Data File
$acl = Get-Acl $fullPath 
#Disabling inheritance on permissions for this file
$acl.SetAccessRuleProtection($true,$false) 
#Setting the new ACL on the path
$acl | Set-Acl $fullPath 
```


## Mac OS
Working on Mac OS still

## Linux
Working on Linux still
