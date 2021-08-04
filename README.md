# TeamViewer_Forensics
A series of functions to parse Teamviewer logs to answer specific questions

# Logs of Interest
* C:\ProgramFiles(x86)\Teamviewer\Connections_incoming.txt
  * Contains logs of successful connections to the system
  * Contains the following Properties: Teamviewer ID of connecting device, display name, start time, end time, username of logged on user, connection type, and the connection ID
  * Depicted time in the log is in UTC

* C:\ProgramFiles(x86)\Teamviewer\TeamViewer15_Logfile.log
  * Contains verbose information for troubleshooting
  * Contains verbose logging of incoming and outgoing connections that can be used to:
    * identify successful and unsuccessful incoming or outgoing connections
    * identify settings and characteristics about the connecting system 
    * identify the public IP (or assigned IP) of the connecting system
    * PID associated with the Teamviewer program
  * Depicted time in the log is local time to the system

* C:\ProgramFiles(x86)\Teamviewer\TeamViewer15_Logfile_OLD.log
  * Rollover log of C:\ProgramFiles(x86)\Teamviewer\TeamViewer15_Logfile.log

* C:\Users\<user>\AppData\Roaming\TeamViewer\MRU\RemoteSupport\*tvc
  * Files are artifacts of successful connections
  * The data from the file populates the dropdown list under "Partner ID" in the program's GUI

* C:\Users\<user>\AppData\Roaming\TeamViewer\connections.txt
  * Contains logs of successful outgoing connections
  * Contains the following Properties: Teamviewer ID of connecting device, start time, end time, username of logged on user, connection type, and the connection ID
  * Depicted time in the log is in UTC

# Questions that can be Answered

