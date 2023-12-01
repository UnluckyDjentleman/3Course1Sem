#include"pch.h"
#include"HT.h"
using namespace std;
namespace HT {
	HTHANDLE::HTHANDLE() {
		this->Capacity = 0;
		this->SecSnapshotInterval = 0;
		this->Addr = NULL;
		this->File = NULL;
		this->FileMapping = NULL;
		this->lastsnaptime = 0;
		this->MaxKeyLength = 0;
		this->MaxPayloadLength = 0;
		ZeroMemory(this->FileName, sizeof(this->FileName));
		ZeroMemory(this->LastErrorMessage, sizeof(this->LastErrorMessage));
	}
	HTHANDLE::HTHANDLE(int Capacity, int SecSnapshotInterval, int MaxKeyLength, int MaxPayloadLength, const wchar_t* FileName) {
		this->Capacity = Capacity;
		this->SecSnapshotInterval = SecSnapshotInterval;
		this->MaxKeyLength = MaxKeyLength;
		this->MaxPayloadLength = MaxPayloadLength;
		memcpy(this->FileName, FileName, sizeof(this->FileName));
	}
	Element::Element() {
		this->key = NULL;
		this->keylength = 0;
		this->payload = NULL;
		this->payloadlength = 0;
	}
	Element::Element(const void* key, int keylength) {
		this->key = key;
		this->keylength = keylength;
	}
	Element::Element(const void* key, int keylength, const void* payload, int  payloadlength) {
		this->key = key;
		this->keylength = keylength;
		this->payload = payload;
		this->payloadlength = payloadlength;
	}
	Element::Element(Element* oldelement, const void* newpayload, int  newpayloadlength) {
		this->key = oldelement->key;
		this->keylength = oldelement->keylength;
		this->payload = newpayload;
		this->payloadlength = newpayloadlength;
	}
	HTHANDLE* Create(int Capacity, int SecSnapshotInterval, int MaxKeyLength, int MaxPayloadLength, const wchar_t* FileName) {
		HANDLE hf = CreateFile(
			FileName,
			GENERIC_WRITE | GENERIC_READ,
			NULL,
			NULL,
			CREATE_ALWAYS,
			FILE_ATTRIBUTE_NORMAL,
			NULL
		);
		if (hf == INVALID_HANDLE_VALUE) {
			throw "createFile was failed";
		}
		int sizeMapping = sizeof(HTHANDLE) + (MaxKeyLength + MaxPayloadLength + sizeof(int) * 2) * Capacity;
		HANDLE hm = CreateFileMapping(
			hf,
			NULL,
			PAGE_READWRITE,
			0, sizeMapping, (LPCWSTR)FileName);
		if (hm == INVALID_HANDLE_VALUE) {
			throw "createFileMapping was failed";
		}
		LPVOID lp = MapViewOfFile(hm, FILE_MAP_ALL_ACCESS, 0, 0, 0);
		if (!lp) return NULL;
		ZeroMemory(lp, sizeMapping);
		HTHANDLE* htHandle = new(lp) HTHANDLE(Capacity, SecSnapshotInterval, MaxKeyLength, MaxPayloadLength, FileName);
		htHandle->File = hf;
		htHandle->FileMapping = hm;
		htHandle->Addr = lp;
		htHandle->lastsnaptime = time(NULL);
		runSnapshotTimer(htHandle);
		return htHandle;
	}
	HTHANDLE* Open(const wchar_t* FileName, bool isMapped) {
		if (isMapped) {
				HANDLE hm;
				if (!(hm = OpenFileMapping(
					FILE_MAP_ALL_ACCESS,
					false,
					FileName))) {
					return NULL;
				}

				LPVOID lp = MapViewOfFile(
					hm,
					FILE_MAP_ALL_ACCESS,
					0, 0, 0);
				if (lp == NULL)
					throw "Cannot create view on file\n";
				HTHANDLE* htHandle=new HTHANDLE();
				memcpy(htHandle, lp, sizeof(HT::HTHANDLE));
				htHandle->File = NULL;
				htHandle->FileMapping = hm;
				htHandle->Addr = lp;
				runSnapshotTimer(htHandle);
				return htHandle;
		}
		else {
			HANDLE hf = CreateFile(
				FileName,
				GENERIC_WRITE | GENERIC_READ,
				NULL,
				NULL,
				OPEN_EXISTING,
				FILE_ATTRIBUTE_NORMAL,
				NULL);
			if (hf == INVALID_HANDLE_VALUE)
				return NULL;

			HANDLE hm = CreateFileMapping(
				hf,
				NULL,
				PAGE_READWRITE,
				0, 0,
				FileName);
			if (!hm)
				return NULL;
			LPVOID lp = MapViewOfFile(hm, FILE_MAP_ALL_ACCESS, 0, 0, 0);
			if (!lp) return NULL;
			HTHANDLE* htHandle = new HTHANDLE();
			htHandle = (HTHANDLE*)lp;
			htHandle->File = hf;
			htHandle->FileMapping = hm;
			htHandle->Addr = lp;
			htHandle->lastsnaptime = time(NULL);
			runSnapshotTimer(htHandle);
			return htHandle;
		}
	}
	BOOL Snap(const HTHANDLE* hthandle) {
		if (!FlushViewOfFile(hthandle->Addr, NULL)) {
			getLastError((HTHANDLE*)hthandle);
			return false;
		}
		((HTHANDLE*)hthandle)->lastsnaptime = time(NULL);
		return true;
	}
	BOOL Close(const HTHANDLE* hthandle) {
		try {
			HANDLE hf = hthandle->File;
			HANDLE hfm = hthandle->FileMapping;

			if (!UnmapViewOfFile(hthandle->Addr)) {
				throw "unmap xd\n";
			}
			if (!CloseHandle(hfm)) {
				throw "closehandle xd\n";
			}
			if (hf != NULL) {
				if (!CloseHandle(hf))
					throw "close file xd\n";
			}
		}
		catch (const char* e) {
			memcpy((void*)hthandle->LastErrorMessage, e, sizeof(hthandle->LastErrorMessage));
			cout << getLastError((HT::HTHANDLE*)hthandle);
		}
		return true;
	}
	BOOL Insert(const HTHANDLE* hthandle, const Element* element) {
		try {
			if (hthandle->count >= hthandle->Capacity) {
				throw "Index out of range exception\n";
			}
			int freeIndex = findFree(hthandle, element);
			if (freeIndex < 0) {
				throw "Cannot insert element with negative index\n";
			}
			WriteToMem(hthandle, element, freeIndex);
			incrCount((HTHANDLE*)hthandle);
			return true;
		}
		catch (const char* e) {
			memcpy((void*)hthandle->LastErrorMessage, e, sizeof(hthandle->LastErrorMessage));
			cout << getLastError((HT::HTHANDLE*)hthandle);
			return false;
		}
	}
	BOOL Delete(const HTHANDLE* hthandle, const Element* element) {
		try {
			int index = findIndex(hthandle, element);
			if (index < 0) {
				throw "Cannot find element you want to delete\n";
			}
			clearMem(hthandle, index);
			decrCount((HTHANDLE*)hthandle);
			return true;
		}
		catch (const char* e) {
			memcpy((void*)hthandle->LastErrorMessage, e, sizeof(hthandle->LastErrorMessage));
			cout << getLastError((HT::HTHANDLE*)hthandle);
			return false;
		}
	}
	Element* Get(const HTHANDLE* hthandle, const Element* element) {
		try {
			int index = findIndex(hthandle, element);
			if (index < 0) {
				throw "exception getError: Index cannot be negative!\n";;
			}
			Element* foundElement = new Element();
			readFromMem(hthandle, foundElement, index);
			return foundElement;
		}
		catch (const char* e) {
			memcpy((void*)hthandle->LastErrorMessage, e, sizeof(hthandle->LastErrorMessage));
			cout << getLastError((HT::HTHANDLE*)hthandle);
			return NULL;
		}
	}
	BOOL Update(const HTHANDLE* hthandle, const Element* oldelement, const void* newpayload, int newpayloadlength) {
		try {
			int index = findIndex(hthandle, oldelement);
			if (index < 0) {
				throw "Cannot find the element you want to update\n";
			}
			Element* updateElement = new Element((Element*)oldelement, newpayload, newpayloadlength);
			WriteToMem(hthandle, updateElement, index);
			return true;
		}
		catch (const char* e) {
			memcpy((void*)hthandle->LastErrorMessage, e, sizeof(hthandle->LastErrorMessage));
			cout << getLastError((HT::HTHANDLE*)hthandle);
			return false;
		}
	}
	char* getLastError(HTHANDLE* hthandle) {
		return hthandle->LastErrorMessage;
	}
	void print(const Element* element) {
		std::cout << "Element:" << std::endl;
		std::cout << "{" << std::endl;
		std::cout << "\t\"key\": \"" << (char*)element->key << "\"," << std::endl;
		std::cout << "\t\"keyLength\": " << element->keylength << "," << std::endl;
		std::cout << "\t\"payload\": \"" << (char*)element->payload << "\"," << std::endl;
		std::cout << "\t\"payloadLength\": " << element->payloadlength << std::endl;
		std::cout << "}" << std::endl;
	}
	void asyncSnap(LPVOID prm, DWORD, DWORD)
	{
		HTHANDLE* htHandle = (HTHANDLE*)prm;
		if (Snap(htHandle))
			std::cout << "-- snapshotAsync success\n" << std::endl;
	}
	BOOL runSnapshotTimer(HTHANDLE* htHandle)
	{
		htHandle->snapshotTimer = CreateWaitableTimer(0, FALSE, 0);
		LARGE_INTEGER Li{};
		Li.QuadPart = -(10000000 * htHandle->SecSnapshotInterval);
		SetWaitableTimer(htHandle->snapshotTimer, &Li, 1, asyncSnap, htHandle, FALSE);

		return true;
	}
	Element* createElementForInsert(const void* xd, int xd1, const void* xd2, int xd3) {
		return new Element(xd, xd1, xd2, xd3);
	}
	//FOR HT
	int hashFunc(const char* key, int Capacity) {
		unsigned long i = 0;
		for (int j = 0; key[j]; j++) {
			i += key[j];
		}
		return i % Capacity;
	}
	int findFree(const HTHANDLE* hthandle, const Element* element) {
		int index = hashFunc((char*)element->key, hthandle->Capacity);
		Element* foundElement = new Element();
		do {
			if (index >= hthandle->Capacity) {
				index = -1;
				break;
			}
			readFromMem(hthandle, foundElement, index);
			index += 1;
		} while (foundElement->key != NULL && foundElement->payloadlength != NULL);
		delete foundElement;
		return index - 1;
	}
	int findIndex(const HTHANDLE* hthandle, const Element* element) {
		int index = hashFunc((char*)element->key, hthandle->Capacity);
		Element* foundElement = new Element();
		do {
			if (index >= hthandle->Capacity) {
				index = -1;
				break;
			}
			readFromMem(hthandle, foundElement, index);
			index += 1;
		} while (memcmp(foundElement->key, element->key, element->keylength) != NULL);
		delete foundElement;
		return index - 1;
	}
	int decrCount(HTHANDLE* hthandle) {
		return --hthandle->count;
	}
	int incrCount(HTHANDLE* hthandle) {
		return ++hthandle->count;
	}
	bool WriteToMem(const HTHANDLE* hthandle, const Element* element, int index) {
		LPVOID lp = hthandle->Addr;
		lp = (HTHANDLE*)lp + 1;
		lp = (BYTE*)lp + (hthandle->MaxKeyLength + hthandle->MaxPayloadLength + sizeof(int) * 2) * index;

		memcpy(lp, element->key, element->keylength);
		lp = (BYTE*)lp + hthandle->MaxKeyLength;
		memcpy(lp, &element->keylength, sizeof(int));
		lp = (int*)lp + 1;
		memcpy(lp, element->payload, element->payloadlength);
		lp = (BYTE*)lp + hthandle->MaxPayloadLength;
		memcpy(lp, &element->payloadlength, sizeof(int));

		return true;
	}
	Element* readFromMem(const HTHANDLE* hthandle, Element* element, int index) {
		LPVOID lp = hthandle->Addr;
		lp = (HTHANDLE*)lp + 1;
		lp = (BYTE*)lp + (hthandle->MaxKeyLength + hthandle->MaxPayloadLength + sizeof(int) * 2) * index;

		element->key = lp;
		lp = (BYTE*)lp + hthandle->MaxKeyLength;
		element->keylength = *(int*)lp;
		lp = (int*)lp + 1;
		element->payload = lp;
		lp = (BYTE*)lp + hthandle->MaxPayloadLength;
		element->payloadlength = *(int*)lp;
		return element;
	}
	BOOL clearMem(const HTHANDLE* hthandle, int index) {

		LPVOID lp = hthandle->Addr;
		int sizeElement = hthandle->MaxKeyLength + hthandle->MaxPayloadLength + sizeof(int) * 2;
		lp = (HTHANDLE*)lp + 1;
		lp = (BYTE*)lp + sizeElement * index;
		ZeroMemory(lp, sizeElement);
		return true;
	}
}