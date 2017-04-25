<#
.SYNOPSIS
Iterate  though all XenApp Servers in the farm and checks that the D: drive is formatted.
.DESCRIPTION
Iterate  though all XenApp Servers in the farm and checks that the D: drive is formatted.
It is recommended that this script be run as a Citrix admin. 
.PARAMETER XMLBrokers
Required parameter. Which Citrix XMLBroker(s) (farm) to query. Can be a list separated by commas.
PS C:\PSScript > .\check-deedrive.ps1
Will use all default values.
.EXAMPLE
PS C:\PSScript > .\check-deedrive.ps1 -XMLBrokers "XMLBROKER"
Will use "XMLBROKER" to query XenApp farm.
.NOTES
NAME        :  check-deedrive
VERSION     :  1.00
CHANGE LOG - Version - When - What - Who
1.00 - 03/27/2017 - Initial script. Cloned from copy-files2xaservers.ps1 - Alain Assaf
LAST UPDATED:  03/27/2017
AUTHOR      :  Alain Assaf
.LINK
http://www.linkedin.com/in/alainassaf/
http://wagthereal.com
http://carlwebster.com/finding-offline-servers-using-powershell-part-1-of-4/
.INPUTS
None
.OUTPUTS
None
#>
Param(
 [parameter(Position = 0, Mandatory=$True)]
 [ValidateNotNullOrEmpty()]
 $XMLBrokers="XMLBROKER" # Change to hardcode a default value for your Delivery Controller
)
### START FUNCTION: test-port #################################################
function Test-Port{
<#
    .SYNOPSIS
    Tests TCP connection to a server with specified port (defaults to 3389).
    .DESCRIPTION
    Tests TCP connection to a server with specified port (defaults to 3389).
    .PARAMETER srv
    Optional parameter. Server to connect to
    .PARAMETER port
    Optional parameter. TCP port to connect to. Defaults to 3389.
    .PARAMETER timeout
    Optional parameter. Timeout in milliseconds to wait for response.
    .INPUTS
    None
    .OUTPUTS
    None
    .EXAMPLE
    PS> test-port SERVERNAME
    Test TCP connection to SERVERNAME over port 3389 with a 300 millisecond timeout
    .EXAMPLE
    PS> test-port SERVERNAME 1494
    Test TCP connection to SERVERNAME over port 1494 with a 300 millisecond timeout
    .EXAMPLE
    PS> test-port SERVERNAME 1494 100
    Test TCP connection to SERVERNAME over port 1494 with a 100 millisecond timeout
    .LINK
    http://cgit0401v.ncsecu.local/Bonobo.Git.Server/Repository/ctxModules/
    http://www.linkedin.com/in/alainassaf/
    http://wagthereal.com
    http://irl33t.com/blog/2011/03/powershell-script-connect-rdp-ps1
    .NOTES
    Written by Aaron Wurthmann (aaron (AT) wurthmann (DOT) com)
    NAME        :  test-port
    VERSION     :  1.00
    CHANGE LOG - Version - When - What - Who
    1.00 - 02/13/2017 - Initial script - Alain Assaf
    LAST UPDATED:  02/13/2017
    AUTHOR      :  Alain Assaf
#>
    Param([string]$srv=$strhost,$port=3389,$timeout=300)
    $ErrorActionPreference = "SilentlyContinue"
    $tcpclient = new-Object system.Net.Sockets.TcpClient
    $iar = $tcpclient.BeginConnect($srv,$port,$null,$null)
    $wait = $iar.AsyncWaitHandle.WaitOne($timeout,$false)
    if(!$wait) {
        $tcpclient.Close()
        Return $false
    } else {
        $error.Clear()
        $tcpclient.EndConnect($iar) | out-Null
        Return $true
        $tcpclient.Close()
    }
}
### END FUNCTION: test-port ###################################################
### START FUNCTION: get-mysnapin ##############################################
Function Get-MySnapin {
<#
    .SYNOPSIS
    Checks for a PowerShell Snapin(s) and imports it if available, otherwise it will display a warning and exit.
    .DESCRIPTION
    Checks for a PowerShell Snapin(s) and imports it if available, otherwise it will display a warning and exit.
    .PARAMETER snapins
    Required parameter. List of PSSnapins separated by commas.
    .INPUTS
    None
    .OUTPUTS
    None
    .EXAMPLE
    PS> get-MySnapin PSSNAPIN
    Checks system for installed PSSNAPIN and imports it if available.
    .LINK
    http://www.linkedin.com/in/alainassaf/
    http://wagthereal.com
    https://github.com/alainassaf/get-mysnapin
    .NOTES
    NAME        :  Get-MySnapin
    VERSION     :  1.00
    CHANGE LOG - Version - When - What - Who
    1.00 - 02/13/2017 - Initial script - Alain Assaf
    LAST UPDATED:  02/13/2017
    AUTHOR      :  Alain Assaf
#>
    Param([string]$snapins)
        $ErrorActionPreference= 'silentlycontinue'
        foreach ($snap in $snapins.Split(",")) {
            if(-not(Get-PSSnapin -name $snap)) {
                if(Get-PSSnapin -Registered | Where-Object { $_.name -like $snap }) {
                    add-PSSnapin -Name $snap
                    $true
                }                                                                           
                else {
                    write-warning "$snap PowerShell Cmdlet not available."
                    write-warning "Please run this script from a system with the $snap PowerShell Cmdlet installed."
                    exit 1
                }                                                                           
            }                                                                                                                                                                  
        }
}
### END FUNCTION: get-mysnapin ################################################
### START FUNCTION: get-xmlbroker #############################################
Function Get-xmlbroker { 
<#
    .SYNOPSIS
    Gets responsive Citrix.
    .DESCRIPTION
    Gets responsive Citrix.
    .PARAMETER XMLBrokers
    Required parameter. Server to use as an XML Broker. Can be a list separated by commas.
    .INPUTS
    None
    .OUTPUTS
    None
    .EXAMPLE
    PS> Get-xmlbroker SERVERNAME
    Query SERVERNAME to see if it responsive. Assumes that SERVERNAME is a Citrix XML Broker
    .LINK
    http://cgit0401v.ncsecu.local/Bonobo.Git.Server/Repository/ctxModules/
    http://www.linkedin.com/in/alainassaf/
    http://wagthereal.com
    .NOTES
    NAME        :  Get-xmlbroker
    VERSION     :  1.00
    CHANGE LOG - Version - When - What - Who
    1.00 - 03/08/2017 - Initial script - Alain Assaf
    LAST UPDATED:  03/08/2017
    AUTHOR      :  Alain Assaf
#>
    [CmdletBinding()] 
    param ([parameter(Position = 0, Mandatory=$False)]
           [ValidateNotNullOrEmpty()]
           $XMLBrokers
    )
            
    $DC = $XMLBrokers.Split(",")
    foreach ($broker in $DC) {
        if ((Test-Port $broker) -and (Test-Port $broker -port 1494) -and (Test-Port $broker -port 2598))  {
            $XMLBroker = $broker
            break
        }
    }
    Return $XMLBroker
}
### END FUNCTION: get-xmlbroker ###############################################

#Constants
$PSSnapins = ("Citrix*")

#Import Module(s) and Snapin(s)
get-MySnapin $PSSnapins

#Find an XML Broker that is up
$XMLBroker = Get-xmlbroker $XMLBrokers

$OnlineXAServers = Get-XAzone -ComputerName $XMLBroker | Get-XAServer -ComputerName $XMLBroker -OnlineOnly | Sort-Object ServerName
$OnlineServers = @()
ForEach( $OnlineServer in $OnlineXAServers )
{
   $OnlineServers += $OnlineServer.ServerName
}

# Get computers in workergroup
foreach ($server in $OnlineServers) {
    if (test-port $server) { #confirm server is up
        if (invoke-command -ComputerName $server -ScriptBlock {Test-Path D:\}) {
        } else {
            write-host "$server does not have a (D:) drive" -ForegroundColor Red
        }
    }
 }
