# check-deedrive
Iterate  though all XenApp Servers in the farm and checks that the D: drive is formatted.

#Contributions to this script
I'd like to highlight the posts that helped me write this scrip below.
* http://carlwebster.com/finding-offline-servers-using-powershell-part-1-of-4/

# get-help .\get-ctxLoadAndLE.ps1 -full

NAME<br>
    check-deedrive.ps1
    
SYNOPSIS<br>
    Iterate  though all XenApp Servers in the farm and checks that the D: drive is formatted.
    
SYNTAX<br>
    PS> check-deedrive.ps1 [-XMLBrokers] <Object> [<CommonParameters>]
    
DESCRIPTION<br>
    Iterate  though all XenApp Servers in the farm and checks that the D: drive is formatted.
    It is recommended that this script be run as a Citrix admin.
    
PARAMETERS

    -XMLBrokers <Object>
        Required parameter. Which Citrix XMLBroker(s) (farm) to query. Can be 
        a list separated by commas.
        PS C:\PSScript > .\check-deedrive.ps1
        Will use all default values.
        
        Required?                    true
        Position?                    1
        Default value                XMLBROKER
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see 
        about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216). 
    
INPUTS<br>
    None
    
OUTPUTS<br>
    None
    
NOTES
    
        NAME        :  check-deedrive
        VERSION     :  1.00
        CHANGE LOG - Version - When - What - Who
        1.00 - 03/27/2017 - Initial script. Cloned from 
        copy-files2xaservers.ps1 - Alain Assaf
        LAST UPDATED:  03/27/2017
        AUTHOR      :  Alain Assaf
    
    -------------------------- EXAMPLE 1 --------------------------
    
    PS C:\PSScript >.\check-deedrive.ps1 -XMLBrokers "XMLBROKER"
    
    Will use "XMLBROKER" to query XenApp farm.
    
# Legal and Licensing
The check-deedrive.ps1 script is licensed under the [MIT license][].

[MIT license]: LICENSE

# Want to connect?
* LinkedIn - https://www.linkedin.com/in/alainassaf
* Twitter - http://twitter.com/alainassaf
* Wag the Real - my blog - https://wagthereal.com
* Edgesightunderthehood - my other - blog https://edgesightunderthehood.com

# Help
I welcome any feedback, ideas or contributors.
