// lab7_HT_COM_LIB.cpp : Defines the functions for the static library.
//

#include "pch.h"
#include "framework.h"
#include"SP7.h"
#include"Interface.h"
#include<iostream>

using namespace std;

namespace SP7 {
	SP7_HTCOM_HANDLER Init() {
		IUnknown* pIUnknown = NULL;
		CoInitialize(NULL);                        // инициализация библиотеки OLE32
		HRESULT hr0 = CoCreateInstance(CLSID_CA, NULL, CLSCTX_INPROC_SERVER, IID_IUnknown, (void**)&pIUnknown);
		if (SUCCEEDED(hr0))
		{
			std::cout << "CoCreateInstance succeeded" << std::endl;
			return pIUnknown;
		}
		else
		{
			std::cout << "CoCreateInstance error" << std::endl;
			throw (int)hr0;
		}
	}
	namespace HTManager
	{
		HT::HTHANDLE* Create(SP7_HTCOM_HANDLER h, int capacity, int secSnapshotInterval, int maxKeyLength, int maxPayloadLength, const wchar_t* fileName, const wchar_t* HTUsersGroup)
		{
			IHTManager* pIManipulator = nullptr;
			HRESULT hr0 = ((IUnknown*)h)->QueryInterface(IID_IHTManager, (void**)&pIManipulator);

			if (SUCCEEDED(hr0))
			{
				HT::HTHANDLE* ht;
				HRESULT hr1 = pIManipulator->Create(&ht, capacity, secSnapshotInterval, maxKeyLength, maxPayloadLength, fileName, HTUsersGroup);
				if (!SUCCEEDED(hr1))
				{
					std::cout << "IHTManipulator::Create" << std::endl;
					throw (int)hr1;
				}
				else
				{
					return ht;
				}
			}
			else
			{
				std::cout << "IHTManipulator" << std::endl;
				throw (int)hr0;
			}
		}

		HT::HTHANDLE* Open(SP7_HTCOM_HANDLER h, const wchar_t* fileName, bool isMapFile)
		{
			IHTManager* pIManipulator = nullptr;
			HRESULT hr0 = ((IUnknown*)h)->QueryInterface(IID_IHTManager, (void**)&pIManipulator);

			if (SUCCEEDED(hr0))
			{
				HT::HTHANDLE* ht;
				HRESULT hr1 = pIManipulator->Open(&ht, fileName, isMapFile);
				if (!SUCCEEDED(hr1))
				{
					std::cerr << "IHTManipulator::Open" << std::endl;
					throw (int)hr1;
				}
				else
				{
					return ht;
				}
			}
			else
			{
				std::cerr << "IHTManipulator" << std::endl;
				throw (int)hr0;
			}
		}

		HT::HTHANDLE* Open(SP7_HTCOM_HANDLER h, const wchar_t* HTUser, const wchar_t* HTPassword, const wchar_t* fileName, bool isMapFile)
		{
			IHTManager* pIManipulator = nullptr;
			HRESULT hr0 = ((IUnknown*)h)->QueryInterface(IID_IHTManager, (void**)&pIManipulator);

			if (SUCCEEDED(hr0))
			{
				HT::HTHANDLE* ht;
				HRESULT hr1 = pIManipulator->Open(&ht, HTUser, HTPassword, fileName, isMapFile);
				if (!SUCCEEDED(hr1))
				{
					std::cerr << "IHTManipulator::Open" << std::endl;
					throw (int)hr1;
				}
				else
				{
					return ht;
				}
			}
			else
			{
				std::cerr << "IHTManipulator" << std::endl;
				throw (int)hr0;
			}
		}

		BOOL Snap(SP7_HTCOM_HANDLER h, HT::HTHANDLE* htHandle)
		{
			IHTManager* pIManipulator = nullptr;
			HRESULT hr0 = ((IUnknown*)h)->QueryInterface(IID_IHTManager, (void**)&pIManipulator);

			if (SUCCEEDED(hr0))
			{
				BOOL rc;
				HRESULT hr1 = pIManipulator->Snap(rc, htHandle);
				if (!SUCCEEDED(hr1))
				{
					std::cerr << "IHTManipulator::Snap" << std::endl;
					throw (int)hr1;
				}
				else
				{
					return rc;
				}
			}
			else
			{
				std::cerr << "IHTManipulator" << std::endl;
				throw (int)hr0;
			}
		}

		BOOL Close(SP7_HTCOM_HANDLER h, const HT::HTHANDLE* htHandle)
		{
			IHTManager* pIManipulator = nullptr;
			HRESULT hr0 = ((IUnknown*)h)->QueryInterface(IID_IHTManager, (void**)&pIManipulator);

			if (SUCCEEDED(hr0))
			{
				BOOL rc;
				HRESULT hr1 = pIManipulator->Close(rc, htHandle);
				if (!SUCCEEDED(hr1))
				{
					std::cerr << "IHTManipulator::Close" << std::endl;
					throw (int)hr1;
				}
				else
				{
					return rc;
				}
			}
			else
			{
				std::cerr << "IHTManipulator" << std::endl;
				throw (int)hr0;
			}
		}
	}

	namespace HTManagerData
	{
		HT::Element* Get(SP7_HTCOM_HANDLER h, HT::HTHANDLE* htHandle, const HT::Element* element)
		{
			IHTManagerData* pIDataManipulator = nullptr;
			HRESULT hr0 = ((IUnknown*)h)->QueryInterface(IID_IHTManagerData, (void**)&pIDataManipulator);

			if (SUCCEEDED(hr0))
			{
				HT::Element* el;
				HRESULT hr1 = pIDataManipulator->Get(&el, htHandle, element);
				if (!SUCCEEDED(hr1))
				{
					std::cerr << "IHTDataManipulator::Get" << std::endl;
					throw (int)hr1;
				}
				else
				{
					return el;
				}
			}
			else
			{
				std::cerr << "IHTDataManipulator" << std::endl;
				throw (int)hr0;
			}
		}

		BOOL Insert(SP7_HTCOM_HANDLER h, HT::HTHANDLE* htHandle, const HT::Element* element)
		{
			IHTManagerData* pIDataManipulator = nullptr;
			HRESULT hr0 = ((IUnknown*)h)->QueryInterface(IID_IHTManagerData, (void**)&pIDataManipulator);

			if (SUCCEEDED(hr0))
			{
				BOOL rc;
				HRESULT hr1 = pIDataManipulator->Insert(rc, htHandle, element);
				if (!SUCCEEDED(hr1))
				{
					std::cerr << "IHTDataManipulator::Insert" << std::endl;
					throw (int)hr1;
				}
				else
				{
					return rc;
				}
			}
			else
			{
				std::cerr << "IHTDataManipulator" << std::endl;
				throw (int)hr0;
			}
		}

		BOOL Update(SP7_HTCOM_HANDLER h, HT::HTHANDLE* htHandle, const HT::Element* oldElement, const void* newPayload, int newPayloadLength)
		{
			IHTManagerData* pIDataManipulator = nullptr;
			HRESULT hr0 = ((IUnknown*)h)->QueryInterface(IID_IHTManagerData, (void**)&pIDataManipulator);

			if (SUCCEEDED(hr0))
			{
				BOOL rc;
				HRESULT hr1 = pIDataManipulator->Update(rc, htHandle, oldElement, newPayload, newPayloadLength);
				if (!SUCCEEDED(hr1))
				{
					std::cerr << "IHTDataManipulator::Update" << std::endl;
					throw (int)hr1;
				}
				else
				{
					return rc;
				}
			}
			else
			{
				std::cerr << "IHTDataManipulator" << std::endl;
				throw (int)hr0;
			}
		}

		BOOL Delete(SP7_HTCOM_HANDLER h, HT::HTHANDLE* htHandle, const HT::Element* element)
		{
			IHTManagerData* pIDataManipulator = nullptr;
			HRESULT hr0 = ((IUnknown*)h)->QueryInterface(IID_IHTManagerData, (void**)&pIDataManipulator);

			if (SUCCEEDED(hr0))
			{
				BOOL rc;
				HRESULT hr1 = pIDataManipulator->Delete(rc, htHandle, element);
				if (!SUCCEEDED(hr1))
				{
					std::cerr << "IHTDataManipulator::Delete" << std::endl;
					throw (int)hr1;
				}
				else
				{
					return rc;
				}
			}
			else
			{
				std::cerr << "IHTDataManipulator" << std::endl;
				throw (int)hr0;
			}
		}
	}

	namespace HTElement
	{
		HT::Element* CreateElementGet(SP7_HTCOM_HANDLER h, const void* key, int keyLength)
		{
			IHTElement* pIElement = nullptr;
			HRESULT hr0 = ((IUnknown*)h)->QueryInterface(IID_IHTElement, (void**)&pIElement);

			if (SUCCEEDED(hr0))
			{
				HT::Element* element;
				HRESULT hr1 = pIElement->CreateElementGet(&element, key, keyLength);
				if (!SUCCEEDED(hr1))
				{
					std::cerr << "IElement::CreateElementGet" << std::endl;
					throw (int)hr1;
				}
				else
				{
					return element;
				}
			}
			else
			{
				std::cerr << "IElement" << std::endl;
				throw (int)hr0;
			}
		}

		HT::Element* CreateElementInsert(SP7_HTCOM_HANDLER h, const void* key, int keyLength, const void* payload, int payloadLength)
		{
			IHTElement* pIElement = nullptr;
			HRESULT hr0 = ((IUnknown*)h)->QueryInterface(IID_IHTElement, (void**)&pIElement);

			if (SUCCEEDED(hr0))
			{
				HT::Element* element;
				HRESULT hr1 = pIElement->CreateElementInsert(&element, key, keyLength, payload, payloadLength);
				if (!SUCCEEDED(hr1))
				{
					std::cerr << "IElement::CreateElementInsert" << std::endl;
					throw (int)hr1;
				}
				else
				{
					return element;
				}
			}
			else
			{
				std::cerr << "IElement" << std::endl;
				throw (int)hr0;
			}
		}

		HT::Element* CreateElementUpdate(SP7_HTCOM_HANDLER h, const HT::Element* oldElement, const void* newPayload, int newPayloadLength)
		{
			IHTElement* pIElement = nullptr;
			HRESULT hr0 = ((IUnknown*)h)->QueryInterface(IID_IHTElement, (void**)&pIElement);

			if (SUCCEEDED(hr0))
			{
				HT::Element* element;
				HRESULT hr1 = pIElement->CreateElementUpdate(&element, oldElement, newPayload, newPayloadLength);
				if (!SUCCEEDED(hr1))
				{
					std::cerr << "IElement::CreateElementUpdate" << std::endl;
					throw (int)hr1;
				}
				else
				{
					return element;
				}
			}
			else
			{
				std::cerr << "IElement" << std::endl;
				throw (int)hr0;
			}
		}
	}

	namespace HTUtility
	{
		const char* getLastError(SP7_HTCOM_HANDLER h, const HT::HTHANDLE* htHandle)
		{
			IHTUtility* pIUtil = nullptr;
			HRESULT hr0 = ((IUnknown*)h)->QueryInterface(IID_IHTUtility, (void**)&pIUtil);

			if (SUCCEEDED(hr0))
			{
				const char* error;
				HRESULT hr1 = pIUtil->getLastError(&error, htHandle);
				if (!SUCCEEDED(hr1))
				{
					std::cerr << "IHTUtil::getLastError" << std::endl;
					throw (int)hr1;
				}
				else
				{
					return error;
				}
			}
			else
			{
				std::cerr << "IHTUtil" << std::endl;
				throw (int)hr0;
			}
		}

		void print(SP7_HTCOM_HANDLER h, const HT::Element* element)
		{
			IHTUtility* pIUtil = nullptr;
			HRESULT hr0 = ((IUnknown*)h)->QueryInterface(IID_IHTUtility, (void**)&pIUtil);

			if (SUCCEEDED(hr0))
			{
				HRESULT hr1 = pIUtil->print(element);
				if (!SUCCEEDED(hr1))
				{
					std::cerr << "IHTUtil::print" << std::endl;
					throw (int)hr1;
				}
			}
			else
			{
				std::cerr << "IHTUtil" << std::endl;
				throw (int)hr0;
			}
		}
	}
	void Dispose(SP7_HTCOM_HANDLER h)
	{
		((IUnknown*)h)->Release();
		CoFreeUnusedLibraries();
	}
}

