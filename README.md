# TeamViewer_Forensics
A series of scripts to parse Teamviewer logs to answer specific questions

# Logs of Interest
C:\ProgramFiles(x86)\Teamviewer\Connections_incoming.txt
* Logs successful connections to the system
* Contains the following Properties: Teamviewer ID of connecting device, display name, start time, end time, username of logged on user, connection type, and the connection ID
* Time is in UTC

C:\ProgramFiles(x86)\Teamviewer\TeamViewer**_Logfile.log
* Contains verbose information for troubleshooting
* Contains verbose logging of incoming and outgoing connections
* Contains the public IP of the connecting system

C:\ProgramFiles(x86)\Teamviewer\TeamViewer**_Logfile_OLD.log
* a
* a

C:\Users\<user>\AppData\Roaming\TeamViewer\MRU\RemoteSupport\*tvc
* a
* a

C:\Users\<user>\AppData\Roaming\TeamViewer\connections.txt
* a
* a
