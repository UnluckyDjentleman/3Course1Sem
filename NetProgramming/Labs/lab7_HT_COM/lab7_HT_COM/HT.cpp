#include"pch.h"
#include "HT.h"

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
	HTHANDLE::HTHANDLE(int Capacity, int SecSnapshotInterval, int MaxKeyLength, int MaxPayloadLength, const wchar_t* FileName, const wchar_t* HTUsersGroup) {
		this->Capacity = Capacity;
		this->SecSnapshotInterval = SecSnapshotInterval;
		this->MaxKeyLength = MaxKeyLength;
		this->MaxPayloadLength = MaxPayloadLength;
		memcpy(this->FileName, FileName, sizeof(this->FileName));
		memcpy(this->HTUsersGroup, HTUsersGroup, sizeof(this->HTUsersGroup));
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
}