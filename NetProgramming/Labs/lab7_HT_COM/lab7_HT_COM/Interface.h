#pragma once
#include <objbase.h>
#include "HT.h"

// {E0E0B7F5-AB07-4C80-9234-F1A185CA3BF0}
static const GUID IID_IHTManager =
{ 0xe0e0b7f5, 0xab07, 0x4c80, { 0x92, 0x34, 0xf1, 0xa1, 0x85, 0xca, 0x3b, 0xf0 } };


interface IHTManager :IUnknown {
	STDMETHOD(Create(HT::HTHANDLE** handle, int capacity, int secSnapshotInterval, int maxKeyLength, int maxPayloadLength, const wchar_t* HTUSersGroup, const wchar_t* fileName)) = 0;
	STDMETHOD(Open(HT::HTHANDLE** handle, const wchar_t* fileName, bool isMapFile = false)) = 0;
	STDMETHOD(Open(HT::HTHANDLE** handle, const wchar_t* HTUser, const wchar_t* HTPassword, const wchar_t* fileName, bool isMapFile = false)) = 0;
	STDMETHOD(Snap(BOOL& rc, HT::HTHANDLE* htHandle)) = 0;
	STDMETHOD(Close(BOOL& rc, const HT::HTHANDLE* htHandle)) = 0;
};

// {43C3D4DE-F972-4E0F-AD07-5899C516E7C1}
static const GUID IID_IHTManagerData =
{ 0x43c3d4de, 0xf972, 0x4e0f, { 0xad, 0x7, 0x58, 0x99, 0xc5, 0x16, 0xe7, 0xc1 } };


interface IHTManagerData :IUnknown {
	STDMETHOD(Get(HT::Element** resultElement, HT::HTHANDLE* htHandle, const HT::Element* element)) = 0;
	STDMETHOD(Insert(BOOL& rc, HT::HTHANDLE* htHandle, const HT::Element* element)) = 0;
	STDMETHOD(Update(BOOL& rc, HT::HTHANDLE* htHandle, const HT::Element* oldElement, const void* newPayload, int newPayloadLength)) = 0;
	STDMETHOD(Delete(BOOL& rc, HT::HTHANDLE* htHandle, const HT::Element* element)) = 0;
};

// {C11EAE6F-C508-4E14-96AC-2C9624A8E608}
static const GUID IID_IHTUtility =
{ 0xc11eae6f, 0xc508, 0x4e14, { 0x96, 0xac, 0x2c, 0x96, 0x24, 0xa8, 0xe6, 0x8 } };


interface IHTUtility :IUnknown {
	STDMETHOD(getLastError(const char** error, const HT::HTHANDLE* htHandle)) = 0;
	STDMETHOD(print(const HT::Element* element)) = 0;
};

// {C6B9638D-E22D-4797-BD56-388817303F16}
static const GUID IID_IHTElement =
{ 0xc6b9638d, 0xe22d, 0x4797, { 0xbd, 0x56, 0x38, 0x88, 0x17, 0x30, 0x3f, 0x16 } };


interface IHTElement :IUnknown
{
	STDMETHOD(CreateElementGet(HT::Element** element, const void* key, int keyLength)) = 0;
	STDMETHOD(CreateElementInsert(HT::Element** element, const void* key, int keyLength, const void* payload, int payloadLength)) = 0;
	STDMETHOD(CreateElementUpdate(HT::Element** element, const HT::Element* oldElement, const void* newPayload, int newPayloadLength)) = 0;
};