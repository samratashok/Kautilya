#!/usr/bin/ruby
require "rubygems"
require 'bundler/setup'
if ((/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil)
  require 'Win32/Console/ANSI'
end
require "colored"
require "./lib/src/methods"
require "artii"
#Config Variables. Separate class or file would be used if more are required.
$output_path = File.expand_path(File.dirname(__FILE__))

system("clear")
puts"\n\n\n\n"

#Load banner
fonts = ['3-d', 'banner3', 'colossal', 'epic', 'isometric1', 'isometric2', 'isometric3', 'isometric4', 'univers', 'starwars', 'calgphy2' ]
a = Artii::Base.new :font => fonts.sample
puts"#{a.asciify('Kautilya')}".blue

puts"\nVersion 0.5.6"
print"|..| ".green
print"Written By: ".yellow
print"Nikhil \"SamratAshok\" Mittal            ".cyan
print"|..|\n".green
print"|..| ".green
print"Twitter: ".yellow
print"@nikhil_mitt                              ".cyan
print"|..|\n".green
print"|..| ".green
print"Bugs & Feedback: ".yellow
print"nikhil_uitrgpv@yahoo.co.in        ".cyan
print"|..|\n".green
print"|..| ".green
print"Code: ".yellow
print"https://github.com/samratashok/Kautilya      ".cyan
print"|..|\n".green
print"|..| ".green
print"Blog: ".yellow
print"http://labofapenetrationtester.com/          ".cyan
print"|..|\n".green
puts"\nKautilya is a toolkit to ease usage of Human Interface Devices in Pen Tests."
puts"Tested on Teensy++ and Teensy 3.0 from pjrc.com."

while(true)

puts "\n\nChoose target OS from the menu below:\n\n".bold

puts "1. Payloads for Windows"
puts "2. Payloads for Linux"
puts "3. Payloads for Mac OS X"
puts "\n0. Exit Kautilya"
target = input""
if target == "1"
puts "\n\nChoose a payload category from the menu below:\n\n".bold
puts" 1. Gather"
puts" 2. Execute"
puts" 3. Backdoor"
puts" 4. Escalate"
puts" 5. Manage"
puts" 6. Drop Files"
puts" 7. Misc"
puts"\n 0. Go back to Main Menu"
category = input("")
case category
when "1"
  puts" 1. Gather Information"
  puts" 2. Hashdump and Exfiltrate"
  puts" 3. Keylog and Exfiltrate"
  puts" 4. Sniffer"
  puts" 5. WLAN keys dump"
  puts" 6. Get Target Credentials"
  puts" 7. Dump LSA Secrets"
  puts" 8. Get Screenshots"
  puts" 9. Dump passwords in plain"
  puts "10. Copy SAM"
  puts "11. Dump Process Memory"
  puts "12. Dump Windows Vault Credentials"
  puts"\n 0. Go back to Main Menu"
  option = input("")
  case option
  when "1"
    info()
  when "2"
    hashdump_powershelldown()
  when "3"
    keylogger()
  when "4"
    sniffer()
  when "5"
    wlan_keys()
  when "6"
    credentials()
  when "7"
    lsa_secrets()
  when "8"
    screenshot()
  when "9"
    dump_passwords()
  when "10"
    vss()
  when "11"
    memdump()
  when "12"
    getvault()
  when "0"
  end
when "2"
  puts" 1. Download and Execute"
  puts" 2. Connect to Hotspot and Execute code"
  puts" 3. Code Execution using Powershell"
  puts" 4. Code Execution using DNS TXT queries"
  puts" 5. Download and Execute PowerShell Script"
  puts" 6. Execute ShellCode"
  puts" 7. Reverse TCP Shell"
  puts" 8. Reverse UDP Shell"
  puts" 9. Reverse ICMP Shell"
  puts" 10. Reverse HTTPS Shell"
  puts" 11. Reverse HTTP Shell"
  puts"\n 0. Go back to Main Menu"
  option = input("")
  case option
  when"1"
    download_execute()
  when "2"
    force_wifi()
  when "3"
    powershell_codeexec()
  when "4"
    dns_txt_codeexec()
  when "5"
    download_execute_ps()
  when "6"
    invoke_shellcode()
  when "7"
    reverse_tcp()
  when "8"
    reverse_udp()
  when "9"
    reverse_icmp()
  when "10"
    reverse_https()
  when "11"
    reverse_http()
  when "0"
  end
when "3"
  puts" 1. Sethc and Utilman backdoor"
  puts" 2. Time based payload execution"
  puts" 3. HTTP backdoor"
  puts" 4. DNS TXT Backdoor"
  puts" 5. Wireless Rogue AP"
  puts" 6. Tracking Target Connectivity"
  puts" 7. Gupt Backdoor"
  puts"\n 0. Go back to Main Menu"
  option = input("")
  case option
  when "1"
    backdoor()
  when "2"
    time_based_exec()
  when "3"
    http_backdoor()
  when "4"
    dns_txt_backdoor()
  when "5"
    rogue_ap()
  when "6"
    ncsi()
  when "7"
    gupt()
  when "0"
  end
when"4"
  puts" 1. Remove Update"
  puts" 2. Forceful Browsing"
  puts"\n 0. Go back to Main Menu"
  option = input("")
  case option
  when "1"
    remove_update()
  when "2"
    force_browse()
  when "0"
  end
when "5"
  puts" 1. Add an admin user"
  puts" 2. Change the default DNS server"
  puts" 3. Edit the hosts file"
  puts" 4. Add a user and Enable RDP"
  puts" 5. Add a user and Enable Telnet"
  puts" 6. Add a user and Enable Powershell Remoting"
  puts"\n 0. Go back to Main Menu"
  option = input("")
  case option
  when "1"
    windows_add_user()
  when "2"
    default_dns()
  when "3"
    edit_hosts()
  when "4"
    enable_rdp()
  when "5"
    enable_telnet()
  when "6"
    enable_psremoting()
  when "0"
  end

when "6"
  puts" 1. Drop a MS Word File"
  puts" 2. Drop a MS Excel File"
  puts" 3. Drop a CHM (Compiled HTML Help) file"
  puts" 4. Drop a Shortcut (.LNK) file"
  puts" 5. Drop a JAR file"
  puts"\n 0. Go back to Main Menu"
  option = input("")
  case option
  when "1"
    drop_word()
  when "2"
    drop_excel()
  when "3"
    drop_chm()
  when "4"
    drop_shortcut()
  when "5"
    drop_jar()
  when "0"
  end

when "7"
  puts" 1. Browse and Accept Java Signed Applet"
  puts" 2. Speak on Target"
  puts"\n 0. Go back to Main Menu"
  option = input("")
  case option
  when "1"
    signed_applet()
  when "2"
    speak()
  when "0"
  end
end
elsif target == "2"
puts "\n\nChoose a payload from the menu below:\n\n".bold

puts" 1. Download and Execute"
puts" 2. Reverse Shells using built in tools"
#puts" 3. Gather Information "
#puts" 4. Keylog and upload to pastebin"
puts" 3. Code Execution"
puts" 4. DNS TXT Code Execution"
puts" 5. Perl reverse shell (MSF)"

puts"\n 0. Go back to Main Menu"
option = input("")

case option
when "1"
 linux_download_execute()
when "2"
  linux_builtin_reverse_shells()
#when "3"
  #linux_keylogger()
#when "4"
  #linux_keylogger()
when "3"
  linux_codeexec()
when "4"
  linux_dns_txt_codeexec()
when "5"
  linux_perl_reverse_shell()
when "0"

end
elsif target == "3"
puts "\n\nChoose a payload from the menu below:\n\n".bold

puts" 1. Download and Execute"
puts" 2. DNS TXT Code Execution"
puts" 3. Perl Reverse Shell (MSF)"
puts" 4. Ruby Reverse Shell (MSF)"

puts"\n 0. Go back to Main Menu"
option = input("")

case option
when "1"
  osx_download_execute()
when "2"
  osx_dns_txt_codeexec()
when "3"
  osx_perl_reverse_shell()
when "4"
  osx_ruby_reverse_shell()
when "0"

end

elsif target == "0"
  break

end
end
quote = rand(14)

quotes = ["\nOnce you start a working on something, don't be afraid of failure and don't abandon it.
People who work sincerely are the happiest.",
"Before you start some work, always ask yourself three questions - Why am I doing it?
What the results might be? And Will I be successful? Only when you think deeply and find
satisfactory answers to these questions, go ahead.",
"A person should not be too honest. Straight trees are cut first and honest people are screwed first.",
"Do not reveal what you have thought upon doing, but by wise council keep it secret being determined to carry it into execution.",
"The life of an uneducated man is as useless as the tail of a dog which neither covers its rear end, 
nor protects it from the bites of insects.",
"The biggest guru-mantra is: never share your secrets with anybody. It will destroy you. 
If you cannot keep your secrets with you then how can you trust others to keep them secret?",
"One whose knowledge is confined to books and whose wealth is in the possession of others, 
can use neither his knowledge nor wealth when the need for them arises.",  
"A rich man has many friends.",  
"An egoist can be won over by being respected, 
a crazy person can be won over by allowing him to behave in an insane manner and 
a wise person can be won over by truth.",
"As soon as the fear approaches near, attack and destroy it.",
"Books are as useful to a stupid person as a mirror is useful to a blind person.",
"If you get to learn something even from the worst of creatures, don't hesitate.",
"One who is in search of knowledge should give up the search of pleasure and 
the one who is in search of pleasure should give up the search of knowledge.",
"The world's biggest power is the youth and beauty of a woman.",
]
print"\n#{quotes[quote]}".red.bold
print" - Kautilya".blue.bold
gets
