#include"pch.h"
#include<iostream>
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
			OPEN_ALWAYS,
			FILE_ATTRIBUTE_NORMAL,
			NULL
		);
		if (hf == INVALID_HANDLE_VALUE) {
			throw "createFile was failed";
		}
		int sizeMapping = sizeof(HTHANDLE) + (MaxKeyLength + MaxPayloadLength + sizeof(int) * 2) * Capacity;
		HANDLE hm = CreateFileMapping(
			INVALID_HANDLE_VALUE,
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
		return htHandle;
	}
	HTHANDLE* Open(const wchar_t* FileName) {
		HANDLE hm = OpenFileMapping(
			FILE_MAP_ALL_ACCESS,
			false,
			FileName);
		if (!hm)
			return NULL;

		LPVOID lp = MapViewOfFile(
			hm,
			FILE_MAP_ALL_ACCESS,
			0, 0, 0);
		if (!lp)
			return NULL;

		HT::HTHANDLE* htHandle = new HT::HTHANDLE();
		memcpy(htHandle, lp, sizeof(HT::HTHANDLE));
		htHandle->File = NULL;
		htHandle->FileMapping = hm;
		htHandle->Addr = lp;

		return htHandle;
	}
	BOOL Snap(const HTHANDLE* hthandle) {
		if (!FlushViewOfFile(hthandle->Addr, NULL)) {
			GetLastError((HTHANDLE*)hthandle);
			return false;
		}
		((HTHANDLE*)hthandle)->lastsnaptime = time(NULL);
		return true;
	}
	BOOL Close(const HTHANDLE* hthandle) {
		HANDLE hf = hthandle->File;
		HANDLE hfm = hthandle->FileMapping;

		if (!UnmapViewOfFile(hthandle->Addr)) {
			throw "unmap xd";
		}
		if (!CloseHandle(hfm)) {
			throw "closehandle xd";
		}
		if (hf != NULL) {
			if (!CloseHandle(hf))
				throw "close file xd";
		}
		return true;
	}
	BOOL Insert(const HTHANDLE* hthandle, const Element* element) {
		if (hthandle->count >= hthandle->Capacity) {
			return false;
		}
		int freeIndex = findFree(hthandle, element);
		if (freeIndex < 0) {
			return false;
		}
		WriteToMem(hthandle, element, freeIndex);
		incrCount((HTHANDLE*)hthandle);
		return true;
	}
	BOOL Delete(const HTHANDLE* hthandle, const Element* element) {
		int index = findIndex(hthandle, element);
		if (index < 0) {
			return false;
		}
		clearMem(hthandle, index);
		decrCount((HTHANDLE*)hthandle);
		return true;
	}
	Element* Get(const HTHANDLE* hthandle, const Element* element) {
		int index = findIndex(hthandle, element);
		if (index < 0) {
			return NULL;
		}
		Element* foundElement = new Element();
		readFromMem(hthandle, foundElement, index);
		return foundElement;
	}
	BOOL Update(const HTHANDLE* hthandle, const Element* oldelement, const void* newpayload, int newpayloadlength) {
		int index = findIndex(hthandle, oldelement);
		if (index < 0) {
			return false;
		}
		Element* updateElement = new Element((Element*)oldelement, newpayload, newpayloadlength);
		WriteToMem(hthandle, updateElement, index);
		return true;
	}
	char* GetLastError(HTHANDLE* hthandle) {
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
	//FOR HT
	int hashFunc(const char* key, int Capacity) {
		unsigned long i = 0;
		for (int j = 0; key[i]; j++) {
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
			++index;
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
			++index;
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