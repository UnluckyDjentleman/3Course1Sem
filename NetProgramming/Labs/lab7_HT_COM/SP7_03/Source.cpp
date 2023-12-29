#define _CRT_SECURE_NO_WARNINGS
#define HTPATH L"D:/Sem31/NetProgramming/Labs/lab7_HT_COM/x64/Debug/405.ht"
#include <iostream>
#include <sstream>
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

int main(int argc, char* argv[])
{
	try
	{
		SP7_HTCOM_HANDLER h1 = SP7::Init();
		HT::HTHANDLE* ht;
		SECURITY_ATTRIBUTES SA = getSecurityAttributes();

		HANDLE hStopEvent = OpenEvent(
			EVENT_ALL_ACCESS,
			FALSE,
			L"Global\\STOP_HT");
		if (!hStopEvent) {
			throw "Cannot open event";
		}

		if (argc == 4)
		{
			ht = SP7::HTManager::Open(h1, fromCharToWchar(argv[1]), fromCharToWchar(argv[2]), fromCharToWchar(argv[3]), true);
		}
		else if (argc == 2)
		{
			ht = SP7::HTManager::Open(h1, fromCharToWchar(argv[1]), true);
		}
		else
		{
			throw "Invalid file name";
		}
		if (ht == NULL)
		{
			throw "Invalid handle";
		}

		while (WaitForSingleObject(hStopEvent, 0) == WAIT_TIMEOUT)
		{
			int keyGen = rand() % 50;
			std::string key = std::to_string(keyGen);
			std::cout << "Generated Key: " << key << std::endl;

			HT::Element* el;
			HT::Element* el1 = SP7::HTElement::CreateElementGet(h1, key.c_str(), key.length() + 1);
			HT::Element* el2;
			if ((el = SP7::HTManagerData::Get(h1, ht, el1)) == NULL)
			{
				std::cout << SP7::HTUtility::getLastError(h1, ht) << std::endl;
			}
			else
			{
				SP7::HTUtility::print(h1, el);
				std::stringstream ss;
				int num;
				ss << *(char*)el->payload;
				ss >> num;
				int newNum = num + 1;
				std::cout << "old payload: " << *(char*)el->payload << " new value: " << newNum << std::endl;
				std::string payload;
				std::stringstream payloadConvert;
				payloadConvert << newNum;
				payload = payloadConvert.str();

				el2 = SP7::HTElement::CreateElementInsert(h1, key.c_str(), key.length() + 1, payload.c_str(), payload.length() + 1);

				if (!SP7::HTManagerData::Update(h1, ht, el1, el2->payload, el2->payloadlength))
				{
					std::cout << SP7::HTUtility::getLastError(h1, ht) << std::endl;
				}
				else
				{
					std::cout << "UPDATE SUCCESS" << std::endl;
				}
				if ((el = SP7::HTManagerData::Get(h1, ht, el2)) == NULL)
				{
					std::cout << SP7::HTUtility::getLastError(h1, ht) << std::endl;
				}
				delete el2;
			}
			Sleep(1000);
		}
		SP7::Dispose(h1);
	}
	catch (std::exception&) {
	}
}