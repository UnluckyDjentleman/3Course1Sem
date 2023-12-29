#pragma once
#include <windows.h>
#include <iostream>
#include <fstream>
#include <tchar.h>
#include <string>
#include "sddl.h"

#include "../lab7_HT_COM_LIB/pch.h"
#include "../lab7_HT_COM_LIB/SP7.h"

#define SERVICENAME L"SP7_HTService"
#define HTPATH L"D:/Sem31/NetProgramming/Labs/lab7_HT_COM/x64/Debug/405.ht"

#define USERNAME L"HTUser1"
#define PASSWORD L"1111"

#define TRACEPATH L"D:/Sem31/NetProgramming/Labs/lab7_HT_COM/x64/Debug/service.trace"

VOID WINAPI ServiceMain(DWORD dwArgc, LPTSTR* lpszArgv);
VOID WINAPI ServiceHandler(DWORD fdwControl);

SECURITY_ATTRIBUTES getSecurityAttributes();
HANDLE createStopEvent(const wchar_t* stopEventName);
void startService();
void trace(const char* msg, int r = std::ofstream::app);