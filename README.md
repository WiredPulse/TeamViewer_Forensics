# TeamViewer_Forensics
A series of functions to parse Teamviewer logs to answer specific questions

# Logs of Interest
* C:\ProgramFiles(x86)\Teamviewer\Connections_incoming.txt
  * Contains logs of successful connections to the system
  * Contains the following Properties: Teamviewer ID of the connecting device, display name, start time, end time, the username of logged on user, connection type, and the connection ID
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
  * Contains the following Properties: Teamviewer ID of the connecting device, start time, end time, the username of logged on user, connection type, and the connection ID
  * Depicted time in the log is in UTC

# Questions that can be Answered
* What outgoing connections have this machine made?
* Of those connections, what were the successful and unsuccessful ones?
* What incoming connections were made to this machine?
* What PID was tied to that connection and was there child process spawned?
* What IPs are communicating with this machine?
* What Teamviewer IDs communicate with this machine?
* What is the keyboard layout associated with the incoming connection?
* Were there any files transmitted during the incoming connection?
* What is the duration of the incoming and outgoing connection?
* How long does the Teamviewer process run, on average?

# Disclaimer
While the questions are valid for all versions of Teamviewer, the code was only tested with Teamviewer 15. 

