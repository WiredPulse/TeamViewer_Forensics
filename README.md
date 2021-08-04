# TeamViewer_Forensics
A series of scripts to parse Teamviewer logs to answer specific questions

# Logs of Interest
C:\ProgramFiles(x86)\Teamviewer\Connections_incoming.txt
* Logs successful connections to the system
* Contains the following Properties: Teamviewer ID of connecting device, display name, start time, end time, username of logged on user, connection type, and the connection ID
* Depicted time in the log is in UTC

C:\ProgramFiles(x86)\Teamviewer\TeamViewer15_Logfile.log
* Contains verbose information for troubleshooting
* Contains verbose logging of incoming and outgoing connections
 * Can be used to identify successful and unsuccessful incoming or outgoing connections
* Can be used to identify settings and characteristics about the connecting system 
* Contains the public IP (or assigned IP) of the connecting system
* Depicted time in the log is local time to the system

C:\ProgramFiles(x86)\Teamviewer\TeamViewer15_Logfile_OLD.log
* a
* a

C:\Users\<user>\AppData\Roaming\TeamViewer\MRU\RemoteSupport\*tvc
* a
* a

C:\Users\<user>\AppData\Roaming\TeamViewer\connections.txt
* a
* a

# Questions that can be Answered
