0) Create in project with DLL module file input (*.def) where you should write your exports
1) Open Command Prompt as admin
2) To register your DLL input this(my example, but you can have different):
		regsvr32 /i "D:\Sem31\NetProgramming\lab2\SP02_COM\x64\Debug\SP02_COM.dll"
3) After that you should input 
		regedit (from Admin Command Prompt)
To be convinced that registration is successful
4) After that you can execute another projects)
5) To unregister your DLL
		regsvr32 /i /u "D:\Sem31\NetProgramming\lab2\SP02_COM\x64\Debug\SP02_COM.dll"
6) Good luck!
PS: Also change the way to your LIB in SP02_04(there's my example)
