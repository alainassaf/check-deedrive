
NAME
    \\pfil9903\users\s26246d\Codevault\github\check-deedrive\check-deedrive.ps1
    
SYNOPSIS
    Iterate  though all XenApp Servers in the farm and checks that the D: 
    drive is formatted.
    
    
SYNTAX
    \\pfil9903\users\s26246d\Codevault\github\check-deedrive\check-deedrive.ps1
     [-XMLBrokers] <Object> [<CommonParameters>]
    
    
DESCRIPTION
    Iterate  though all XenApp Servers in the farm and checks that the D: 
    drive is formatted.
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
        OutBuffer, PipelineVariable, and OutVariable. For more information, 
    see 
        about_CommonParameters 
    (http://go.microsoft.com/fwlink/?LinkID=113216). 
    
INPUTS
    None
    
    
OUTPUTS
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
    
    
    
    
    
RELATED LINKS
    http://www.linkedin.com/in/alainassaf/
    http://wagthereal.com
    http://carlwebster.com/finding-offline-servers-using-powershell-part-1-of-4
    /



