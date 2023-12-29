#pragma once
#include <assert.h>
#include <objbase.h>
#include"Interface.h"
#include"sddl.h"

#define SP7_HTCOM_HANDLER void*


static const GUID CLSID_CA =
{ 0x5069492b, 0x383d, 0x440d, { 0x98, 0x18, 0x99, 0x76, 0xd3, 0xd1, 0x85, 0xb5 } };

namespace SP7 {
	SP7_HTCOM_HANDLER Init();
	namespace HTManager {
		HT::HTHANDLE* Create(SP7_HTCOM_HANDLER, int, int, int, int, const wchar_t*, const wchar_t*);
		HT::HTHANDLE* Open(SP7_HTCOM_HANDLER, const wchar_t*, bool isMapped = false);
		HT::HTHANDLE* Open(SP7_HTCOM_HANDLER, const wchar_t*, const wchar_t*, const wchar_t*, bool isMapped = false);
		BOOL Snap(SP7_HTCOM_HANDLER, HT::HTHANDLE*);
		BOOL Close(SP7_HTCOM_HANDLER, const HT::HTHANDLE*);
	}
	namespace HTManagerData {
		HT::Element* Get(SP7_HTCOM_HANDLER, HT::HTHANDLE*, const HT::Element*);
		BOOL Insert(SP7_HTCOM_HANDLER, HT::HTHANDLE*, const HT::Element*);
		BOOL Update(SP7_HTCOM_HANDLER, HT::HTHANDLE*, const HT::Element*, const void*, int);
		BOOL Delete(SP7_HTCOM_HANDLER, HT::HTHANDLE*, const HT::Element*);
	}
	namespace HTElement {
		HT::Element* CreateElementGet(SP7_HTCOM_HANDLER, const void*, int);
		HT::Element* CreateElementInsert(SP7_HTCOM_HANDLER, const void*, int, const void*, int);
		HT::Element* CreateElementUpdate(SP7_HTCOM_HANDLER, const HT::Element*, const void*, int);
	}
	namespace HTUtility {
		const char* getLastError(SP7_HTCOM_HANDLER, const HT::HTHANDLE*);
		void print(SP7_HTCOM_HANDLER, const HT::Element*);
	}
	void Dispose(SP7_HTCOM_HANDLER);
}