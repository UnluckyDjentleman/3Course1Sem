#include<iostream>
#include<Windows.h>
DWORD integerToProcessPriority(int i) {
	switch (i) {
	case 1: return IDLE_PRIORITY_CLASS; break;
	case 2: return BELOW_NORMAL_PRIORITY_CLASS; break;
	case 3: return NORMAL_PRIORITY_CLASS; break;
	case 4: return ABOVE_NORMAL_PRIORITY_CLASS; break;
	case 5: return HIGH_PRIORITY_CLASS; break;
	case 6: return REALTIME_PRIORITY_CLASS; break;
	default: throw "xd"; break;
	}
}
int main(int argc, char* argv[]) {
	try {
		if (argc == 4) {
			HANDLE pH = GetCurrentProcess();
			DWORD_PTR pa = NULL, sa = NULL, icpu = -1;
			int parm1 = atoi(argv[1]);
			int parm2 = atoi(argv[2]);
			int parm3 = atoi(argv[3]);
			if (!GetProcessAffinityMask(pH, &pa, &sa)) {
				throw "GetProcessAffinityMask is ended with error!";
			}
			std::cout << "Before affiniting the mask: " << std::endl;
			std::cout << "Process AM: " << std::showbase << std::hex << pa << std::endl;
			std::cout << "System AM: " << std::showbase << std::hex << sa << std::endl;
			if (!SetProcessAffinityMask(pH, parm1)) {
				throw "SetProcessAffinityMask is ended with error!";
			}
			if (!GetProcessAffinityMask(pH, &pa, &sa)) {
				throw "GetProcessAffinityMask is ended with error!";
			}
			std::cout << "After affiniting the mask: " << std::endl;
			std::cout << "Process AM: " << std::showbase << std::hex << pa << std::endl;
			std::cout << "System AM: " << std::showbase << std::hex << sa << std::endl;
			LPCWSTR path1 = L"D:\\Sem31\\OperationSystems\\Labs\\lab5\\OS05-01\\x64\\Debug\\OS05-02x.exe";
			LPCWSTR path2 = L"D:\\Sem31\\OperationSystems\\Labs\\lab5\\OS05-01\\x64\\Debug\\OS05-02x.exe";
			STARTUPINFO si1, si2;
			PROCESS_INFORMATION pi1, pi2;
			ZeroMemory(&si1, sizeof(STARTUPINFO));
			ZeroMemory(&si2, sizeof(STARTUPINFO));
			si1.cb = sizeof(STARTUPINFO);
			si2.cb = sizeof(STARTUPINFO);
			if (CreateProcess(path1, NULL, NULL, NULL, FALSE, CREATE_NEW_CONSOLE | integerToProcessPriority(parm2), NULL, NULL, &si1, &pi1))
				std::cout << "-- Process OS05-02 1 was created\n";
			else std::cout << "-- Process OS05_02 1 wasn't created\n";

			if (CreateProcess(path2, NULL, NULL, NULL, FALSE, CREATE_NEW_CONSOLE | integerToProcessPriority(parm3), NULL, NULL, &si2, &pi2))
				std::cout << "-- Process OS05_02 2 was created\n";
			else std::cout << "-- Process OS05_02 2 wasn't created\n";

			WaitForSingleObject(pi1.hProcess, INFINITE);
			WaitForSingleObject(pi2.hProcess, INFINITE);

			CloseHandle(pi1.hProcess);
			CloseHandle(pi2.hProcess);
		}
	}
	catch (const char* e) {
		throw e;
	}
	system("pause");
}