Option Explicit
Dim WMIService, Process, Processes, Flag, WS
Set WMIService = GetObject("winmgmts:{impersonationlevel=impersonate}!\\.\root\cimv2")
Set Processes = WMIService.ExecQuery("select * from win32_process")
Flag = true
for each Process in Processes 
    if strcomp(Process.name, "rclone.exe") = 0 then
       Flag = false
       exit for
    end if
next
Set WMIService = nothing
if Flag then
    Set WS = Wscript.CreateObject("Wscript.Shell")
    WS.Run "rclone mount onedrive_local:/ Z: --copy-links --no-gzip-encoding --no-check-certificate --allow-other --allow-non-empty", 0
end if
