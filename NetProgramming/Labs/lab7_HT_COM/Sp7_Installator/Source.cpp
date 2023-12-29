#define _CRT_SECURE_NO_WARNINGS
#include <Windows.h>
#include <iostream>
#include <wchar.h>
#include <string>
#define SERVICENAME L"SP7_HTService"

#ifdef _WIN64
#pragma comment(lib, "../x64/Debug/lab7_HT_COM_LIB.lib")
#define SERVICEPATH L"D:/Sem31/NetProgramming/Labs/lab7_HT_COM/x64/Debug/SP7_SERVICE.exe"
#else
#define SERVICEPATH L"D:/Sem31/NetProgramming/Labs/lab7_HT_COM/Debug/SP7_SERVICE.exe"
#pragma comment(lib, "../Debug/lab7_HT_COM_LIB.lib")
#endif

#include "../lab7_HT_COM_LIB/pch.h"
#include "../lab7_HT_COM_LIB/SP7.h"

char* errortxt(const char* msg, int code)
{
	char* buf = new char[512];

	sprintf_s(buf, 512, "%s: error code = %d\n", msg, code);

	return buf;
}

int main()
{
	SC_HANDLE schService = NULL, schSCManager = NULL;
	try
	{
		SP7_HTCOM_HANDLER h1 = SP7::Init();
		HT::HTHANDLE* ht = SP7::HTManager::Create(h1, 200, 3, 4, 4, L"D:/Sem31/NetProgramming/Labs/lab7_HT_COM/x64/Debug/405.ht", L"HT");
		if (ht == NULL) {
			throw "Cannot create storage";
		}
		std::cout << "HT-Storage Created " << std::endl;
		std::wcout << "Filepath: " << ht->FileName << std::endl;
		std::cout << "SnapshotIntervalSec: " << ht->SecSnapshotInterval << std::endl;
		std::cout << "Capacity: " << ht->Capacity << std::endl;
		std::cout << "MaxKeyLength: " << ht->MaxKeyLength << std::endl;
		std::cout << "MaxPayloadLength: " << ht->MaxPayloadLength << std::endl;

		SP7::Dispose(h1);
		schSCManager = OpenSCManager(NULL, NULL, SC_MANAGER_CREATE_SERVICE);

		if (!schSCManager)
		{
			throw errortxt("OpenSCManager", GetLastError());
		}
		else
		{
			schService = CreateService(
				schSCManager,
				SERVICENAME,
				SERVICENAME,
				SERVICE_ALL_ACCESS,
				SERVICE_WIN32_SHARE_PROCESS,
				SERVICE_AUTO_START,
				SERVICE_ERROR_NORMAL,
				SERVICEPATH,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL
			);

			if (!schService)
			{
				throw errortxt("CreateService", GetLastError());
			}
		}
	}
	catch (char* txt)
	{
		std::cout << txt << std::endl;
	}


	if (schSCManager)
	{
		CloseServiceHandle(schSCManager);
	}

	if (schService)
	{
		CloseServiceHandle(schService);
	}

	return 0;
}