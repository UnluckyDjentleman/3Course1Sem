#include"Service.h"

#ifdef _WIN64
#pragma comment(lib, "../x64/Debug/lab7_HT_COM_LIB.lib")
#else
#pragma comment(lib, "../Debug/lab7_HT_COM_LIB.lib")
#endif

using namespace std;

using namespace std;

WCHAR ServiceName[] = SERVICENAME;
SERVICE_STATUS_HANDLE hServiceStatusHandle;
SERVICE_STATUS serviceStatus;

SECURITY_ATTRIBUTES SA = getSecurityAttributes();

HANDLE hStopEvent = CreateEvent(
	&SA,
	TRUE,
	FALSE,
	L"Global\\STOP_HT");

VOID WINAPI ServiceMain(DWORD dwArgc, LPTSTR* lpszArgv)
{
	char temp[121];

	serviceStatus.dwServiceType = SERVICE_WIN32_SHARE_PROCESS;
	serviceStatus.dwCurrentState = SERVICE_START_PENDING;
	serviceStatus.dwControlsAccepted = SERVICE_ACCEPT_STOP | SERVICE_ACCEPT_SHUTDOWN | SERVICE_ACCEPT_PAUSE_CONTINUE;
	serviceStatus.dwWin32ExitCode = 0;
	serviceStatus.dwServiceSpecificExitCode = 0;
	serviceStatus.dwCheckPoint = 0;
	serviceStatus.dwWaitHint = 0;

	if (!(hServiceStatusHandle = RegisterServiceCtrlHandler(ServiceName, ServiceHandler)))
	{
		sprintf_s(temp, "RegisterServiceCtrlHandler failed, error code = %d\n", GetLastError());
		trace(temp);
	}
	else
	{
		serviceStatus.dwCurrentState = SERVICE_RUNNING;
		serviceStatus.dwCheckPoint = 0;
		serviceStatus.dwWaitHint = 0;

		if (!SetServiceStatus(hServiceStatusHandle, &serviceStatus))
		{
			sprintf_s(temp, "SetServiceStatus failed, error code = %d\n", GetLastError());
			trace(temp);
		}
		else
		{
			if (hStopEvent) {
				trace("Start service", std::ofstream::out);
				startService();
			}
		}
	}
}

VOID WINAPI ServiceHandler(DWORD fdwControl)
{
	char temp[121];

	switch (fdwControl)
	{
	case SERVICE_CONTROL_STOP:
	case SERVICE_CONTROL_SHUTDOWN:
	{
		serviceStatus.dwWin32ExitCode = 0;
		serviceStatus.dwCurrentState = SERVICE_STOPPED;
		serviceStatus.dwCheckPoint = 0;
		serviceStatus.dwWaitHint = 0;
		if (hStopEvent) {
			SetEvent(hStopEvent);
			trace("Stop service");
		}
		break;
	}
	case SERVICE_CONTROL_PAUSE:
		serviceStatus.dwCurrentState = SERVICE_PAUSED;
		break;
	case SERVICE_CONTROL_CONTINUE:
		serviceStatus.dwCurrentState = SERVICE_RUNNING;
		break;
	case SERVICE_CONTROL_INTERROGATE:
		break;
	default:
		sprintf_s(temp, "Unrecognized opcode %d\n", fdwControl);
		trace(temp);
	};

	if (!SetServiceStatus(hServiceStatusHandle, &serviceStatus))
	{
		sprintf_s(temp, "SetServiceStatus failed, error code = %d\n", GetLastError());
		trace(temp);
	}
}

void startService()
{

	try
	{
		cout << "Component initialization:" << endl;
		SP7_HTCOM_HANDLER h = SP7::Init();

		HT::HTHANDLE* ht = SP7::HTManager::Open(h, USERNAME, PASSWORD, L"D:/Sem31/NetProgramming/Labs/lab7_HT_COM/x64/Debug/405.ht");

		if (ht)
		{
			trace("HT-Storage Start\n");
			trace("MaxKeyLength: ");
			trace(std::to_string(ht->MaxKeyLength).c_str());
			trace("\nMaxPayloadLength: ");
			trace(std::to_string(ht->MaxPayloadLength).c_str());
			trace("\nSecSnapshotInterval: ");
			trace(std::to_string(ht->SecSnapshotInterval).c_str());
			trace("\nCapacity: ");
			trace(std::to_string(ht->Capacity).c_str());

			while (WaitForSingleObject(hStopEvent, 0) == WAIT_TIMEOUT)
				SleepEx(0, TRUE);

			SP7::HTManager::Snap(h, ht);
			SP7::HTManager::Close(h, ht);

			trace("Close ht");
		}
		else
			trace("-- open: error\n");

		SP7::Dispose(h);
	}
	catch (const char* e) { cout << e << endl; }
	catch (int e) { cout << "HRESULT: " << e << endl; }
}

SECURITY_ATTRIBUTES getSecurityAttributes()
{
	const wchar_t* sdd = L"D:"
		L"(D;OICI;GA;;;BG)" //Deny guests
		L"(D;OICI;GA;;;AN)" //Deny anonymous
		L"(A;OICI;GA;;;AU)" //Allow read, write and execute for Users
		L"(A;OICI;GA;;;BA)"; //Allow all for Administrators
	SECURITY_ATTRIBUTES SA;
	ZeroMemory(&SA, sizeof(SA));
	SA.nLength = sizeof(SA);
	ConvertStringSecurityDescriptorToSecurityDescriptor(
		sdd,
		SDDL_REVISION_1,
		&SA.lpSecurityDescriptor,
		NULL);

	return SA;
}

void trace(const char* msg, int r)
{
	std::ofstream out;

	out.open(TRACEPATH, r);
	out << msg << std::endl;

	out.close();
}