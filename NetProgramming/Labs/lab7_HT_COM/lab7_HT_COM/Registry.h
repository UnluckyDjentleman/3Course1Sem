#pragma once
#include <assert.h>
#include <objbase.h>

static const GUID CLSID_CA =
{ 0x5069492b, 0x383d, 0x440d, { 0x98, 0x18, 0x99, 0x76, 0xd3, 0xd1, 0x85, 0xb5 } };

extern HMODULE hUDCA;

static LPCWSTR FNAME = L"UnluckyDjentleman.lab7.HTCOMSERVICE";
static LPCWSTR VINDX = L"UnluckyDjentleman.lab7.1";
static LPCWSTR PRGID = L"UnluckyDjentleman.lab7";

STDAPI DllInstall(BOOL b, PCWSTR s);
STDAPI DllRegisterServer();
STDAPI DllUnregisterServer();


HRESULT RegisterServer(HMODULE hModule,            // DLL module handle
	const CLSID& clsid,         // Class ID
	const WCHAR* szFriendlyName, // Friendly Name
	const WCHAR* szVerIndProgID, // Programmatic
	const WCHAR* szProgID);     //   IDs

HRESULT UnregisterServer(const CLSID& clsid,
	const WCHAR* szVerIndProgID,
	const WCHAR* szProgID);