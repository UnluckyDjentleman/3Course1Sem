// dllmain.cpp : Defines the entry point for the DLL application.
#include "pch.h"
#include "OperFactory.h"
#include <fstream>
#include <Windows.h>
#include <iostream>

HMODULE hmodule;
// {B89DD548-EBF1-491F-9E9D-595F5403FDAF}
static const GUID CLSID_CA =
{ 0xb89dd548, 0xebf1, 0x491f, { 0x9e, 0x9d, 0x59, 0x5f, 0x54, 0x3, 0xfd, 0xaf } };

LONG Seq = 0;
BOOL APIENTRY DllMain( HMODULE hModule,
                       DWORD  ul_reason_for_call,
                       LPVOID lpReserved
                     )
{
    switch (ul_reason_for_call)
    {
    case DLL_PROCESS_ATTACH: hmodule = hModule; break;
    case DLL_THREAD_ATTACH: break;
    case DLL_THREAD_DETACH: break;
    case DLL_PROCESS_DETACH:
        break;
    }
    return TRUE;
}


const WCHAR* FNAME = L"SP02_unluckyDjentleman.dll";
const WCHAR* VerInd = L"SP02_unluckyDjentleman.1.0";
const WCHAR* ProgId = L"SP02_unluckyDjentleman.1";

HRESULT __declspec(dllexport) DllInstall(bool b, PCWSTR s) {
    return S_OK;
}
HRESULT __declspec(dllexport) DllRegisterServer() {
    return RegisterServer(hmodule,CLSID_CA,FNAME,VerInd,ProgId);
}
HRESULT __declspec(dllexport) DllUnregisterServer() {
    return UnregisterServer(CLSID_CA, VerInd, ProgId);
}
STDAPI DllCanUnloadNow() {
    return S_OK;
}
STDAPI DllGetClassObject(const CLSID& clsid, const IID& iid, void** ppv) {
    HRESULT rc = E_UNEXPECTED;
    OperFactory* oF;
    if (clsid != CLSID_CA) rc = CLASS_E_CLASSNOTAVAILABLE;
    else if ((oF = new OperFactory()) == NULL) rc = E_OUTOFMEMORY;
    else {
        rc = oF->QueryInterface(iid, ppv);
        oF->Release();
    }
    return rc;
}