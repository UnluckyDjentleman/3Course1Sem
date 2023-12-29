#define _CRT_SECURE_NO_WARNINGS
#include <iostream>
#include <Windows.h>
#include <wchar.h>
#include <string>
#include <conio.h>
#ifdef _WIN64
#pragma comment(lib, "../x64/Debug/lab7_HT_COM_LIB.lib")
#else
#pragma comment(lib, "../Debug/lab7_HT_COM_LIB.lib")
#endif

#include "../lab7_HT_COM_LIB/pch.h"
#include "../lab7_HT_COM_LIB/SP7.h"

wchar_t* fromCharToWchar(const char* str) {
	wchar_t* res = new wchar_t[strlen(str) + 1];
	mbstowcs(res, str, strlen(str) + 1);
	return res;
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

HANDLE createStopEvent(const wchar_t* stopEventName)
{
	std::wstring closeEventName = L"Global\\"; closeEventName += stopEventName; closeEventName += L"-stopEvent";
	SECURITY_ATTRIBUTES SA = getSecurityAttributes();

	HANDLE hStopEvent = CreateEvent(
		NULL,
		TRUE, //FALSE - �������������� �����; TRUE - ������
		FALSE,
		L"Global\\STOP_HT");

	return hStopEvent;
}

int main(int argc, char* argv[])
{
	HANDLE hStopEvent;
	wchar_t* fileName;
	try
	{
		SP7_HTCOM_HANDLER h1 = SP7::Init();
		HT::HTHANDLE* ht;

		if (argc == 4)
		{
			ht = SP7::HTManager::Open(h1, fromCharToWchar(argv[1]), fromCharToWchar(argv[2]), fromCharToWchar(argv[3]), true);
			fileName = fromCharToWchar(argv[3]);
			hStopEvent = createStopEvent(fileName);
		}
		else if (argc == 2)
		{
			ht = SP7::HTManager::Open(h1, fromCharToWchar(argv[1]), true);
			fileName = fromCharToWchar(argv[1]);
			hStopEvent = createStopEvent(fileName);
		}
		else
		{
			throw "Invalid file name";
		}

		if (ht)
		{
			if (!SP7::HTManager::Snap(h1, ht))
				throw "Error while Span in HT";
			SetEvent(hStopEvent);
		}
		else
			throw "Error while opening a storage";

		SP7::Dispose(h1);
	}
	catch (const char* err)
	{
		std::cout << err << std::endl;
		return -1;
	}
	catch (int err)
	{
		std::cout << "Error code: " << err << std::endl;
		return -1;
	}
	catch (const std::exception&)
	{
		std::cout << "An error has occurred. Check settings and try again" << std::endl;
		return -1;
	}
	return 0;
}