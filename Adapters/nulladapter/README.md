BizTalk 2013 R2 Null Adapter (plus installer script)
====================================================
A version of the /dev/null Adapter updated for BizTalk Server 2013 R2 with an added installer script.
***
Summary
-------
According to the [original author](http://winterdom.com/2005/03/biztalk2004nullsendadaptersample), the BizTalk Null adapter "basically does nothing" with the messages.  There are several methods for "vaporizing" messages within BizTalk (orchestrations, file system, WCF null behavior) including this adapter method.

### Quick Start
The detailed directions are below but for those which are more experienced:
1. Build the adapter in RELEASE mode
2. Run install.ps1 (as admin)
3. Register in BizTalk (via the Admin Console)
4. Create a send port, select the adapter, set a unique Name

Obviously, you only need to install the adapter once (per server).

***
Installation
------------
### Original Instructions
For the original documentation for installing the adapter refer to the original author's posts [here](http://winterdom.com/2005/03/biztalk2004nullsendadaptersample) and [here](http://winterdom.com/2008/04/registeringnulladapteron64bitmachines).  However, I have created a PowerShell script to make deployment a bunch easier for developers.

### PowerShell (Developer)
The included PowerShell script (install.ps1) will install directly from the Visual Studio directory structure given a successful Release mode build:
1. Launch Visual Studio 2013, Open solution
2. Build in RELEASE mode (installer assumes release mode)
3. Open an ADMIN PowerShell prompt, change to the Deployment directory
4. Run the Install.ps1 script
 
The script will perform the following actions:
* Copy the DLL to the appropriate Program Files folder
* Merge in the BizTalk adapter registry entries (32- and 64-bit as needed)
* Register the Event Source for logging (instead of running installutil.exe)
 
### PowerShell (Servers)
The included PowerShell assumes the source DLL is located in the VS build structure and assumes the .reg files are in the same folder.  You can either maintain this structure when copying these files to the target server or modify the PowerShell script as needed.  *I recommend* you modify the PowerShell script to your liking to support whatever standards you have in your environment.

If you plan on changing the install path of the DLL, you must also modify BOTH .reg files to point to that specific path locaiton.

### Register with BizTalk
The final step is to configure/register the adapter using the BizTalk admin console.  In case you are not familiar:
1. Open the BizTalk Admin Console, expand Platform Settings->Adapters
2. Right-click on Adapters, select New->Adapter...
3. Select /dev/null from the list of adapters
4. Enter a name for the adapter (suggest: /dev/null)

Double check that yoru desired send handler hosts are registered as well: 
1. Right-click on the newly added adapter, select New->Send Handler...
2. Select the desired host, repeat as necessary
3. Note that a default handler was already added for you during the initial registation

Finally, and as is always true in BizTalk, restart your host instances.
***
Usage / Configuration
-----
### Using the adapter
This adapter can be used in a send port like you would any other adapter with minimal configuration.  Simply choose it in the Send Port dialog's Type drop down and setup the port as you require for the situation (filters, bindings).

### Configuration options
The following configuration options are available for this adapter:
_Name of the port_ : This value created the uri "address" of the port to make it unique within the realm of BizTalk.  This needs to be set to something universally unique within a given BizTalk group.

_Log to Event Log_ : When true, creates a log entry in the Application Event Log under the /dev/null event source for each file that is handled by this adapter.
***
Troubleshooting
---------------
### Messages are suspended with Unknown Error
Make sure you have restarted your host instance after you register the adapter for the first time. 
