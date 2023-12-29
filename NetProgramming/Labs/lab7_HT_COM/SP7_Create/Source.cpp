#define _CRT_SECURE_NO_WARNINGS
#include <iostream>
#include <Windows.h>
#include <wchar.h>
#include <string>
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


int main(int argc, char* argv[])
{
	try {
		SP7_HTCOM_HANDLER h1 = SP7::Init();
		if (argc != 7) {
			throw "Invalid parameters. Check it one more time!";
		}
		HT::HTHANDLE* ht = SP7::HTManager::Create(h1, std::stoi(argv[1]), std::stoi(argv[2]), std::stoi(argv[3]), std::stoi(argv[4]), fromCharToWchar(argv[5]), fromCharToWchar(argv[6]));
		if (ht == NULL) {
			throw "Cannot create storage";
		}
		std::cout << "HT-Storage Created " << std::endl;
		std::wcout << "Filepath: " << ht->FileName << std::endl;
		std::cout << "SnapshotIntervalSec: " << ht->SecSnapshotInterval << std::endl;
		std::cout << "Capacity: " << ht->Capacity << std::endl;
		std::cout << "MaxKeyLength: " << ht->MaxKeyLength << std::endl;
		std::cout << "MaxPayloadLength: " << ht->MaxPayloadLength << std::endl;

		SP7::HTManager::Close(h1, ht);
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