// dllmain.cpp : Defines the entry point for the DLL application.
#include "pch.h"
#include"Registry.h"
#include <fstream>

HMODULE hUDCA;
LONG Seq = 0;
std::fstream LogCOM;

ULONG g_Components = 0;
ULONG g_ServerLocks = 0;

BOOL APIENTRY DllMain(HMODULE hModule,
    DWORD  ul_reason_for_call,
    LPVOID lpReserved
)
{
    switch (ul_reason_for_call)
    {
    case DLL_PROCESS_ATTACH:
        hUDCA = hModule;
        LogCOM.open("D:\\Sem31\\NetProgramming\\Labs\\lab7_HT_COM\\log.txt", std::ios_base::out);
    case DLL_THREAD_ATTACH:
    case DLL_THREAD_DETACH:
    case DLL_PROCESS_DETACH:
        break;
    }
    return TRUE;
}
