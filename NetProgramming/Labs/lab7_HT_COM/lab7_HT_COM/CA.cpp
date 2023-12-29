#include "pch.h"
#include "CA.h"
#include "OperFactory.h"
#include "SEQLOG.h"
#include <iostream>

using namespace std;

static void CALLBACK SnapAsyncWrapper(LPVOID prm, DWORD dwTimerLowValue, DWORD dwTimerHighValue);

CA::CA() :m_Ref(1)
{
	SEQ;
	InterlockedIncrement((LONG*)&g_Components);
	LOG("OS13::Adder g_Components = ", g_Components);
};

CA::~CA()
{
	SEQ;
	InterlockedDecrement((LONG*)&g_Components);
	LOG("OS13::~Adder g_Components = ", g_Components);
};

HRESULT STDMETHODCALLTYPE CA::QueryInterface(REFIID riid, void** ppv)
{
	SEQ;
	HRESULT rc = S_OK;
	*ppv = NULL;
	if (riid == IID_IUnknown)
		*ppv = (IHTManager*)this;
	else if (riid == IID_IHTManager)
		*ppv = (IHTManager*)this;
	else if (riid == IID_IHTManagerData)
		*ppv = (IHTManagerData*)this;
	else if (riid == IID_IHTUtility)
		*ppv = (IHTUtility*)this;
	else if (riid == IID_IHTElement)
		*ppv = (IHTElement*)this;
	else rc = E_NOINTERFACE;

	if (rc == S_OK) this->AddRef();
	LOG("OS13::QueryInterface rc = ", rc);
	return rc;
};

ULONG STDMETHODCALLTYPE CA::AddRef(void)
{
	SEQ;
	InterlockedIncrement((LONG*)&(this->m_Ref));
	LOG("OS13::AddRef m_Ref = ", this->m_Ref);
	return this->m_Ref;
};

ULONG STDMETHODCALLTYPE CA::Release(void)
{
	SEQ;
	ULONG rc = this->m_Ref;
	if ((rc = InterlockedDecrement((LONG*)&(this->m_Ref))) == 0) delete this;
	LOG("OS13::Release rc = ", rc);
	return rc;
};

HRESULT STDMETHODCALLTYPE CA::Create(
	HT::HTHANDLE** handle,
	int	  capacity,					// емкость хранилища
	int   secSnapshotInterval,		// переодичность сохранения в сек.
	int   maxKeyLength,             // максимальный размер ключа
	int   maxPayloadLength,			// максимальный размер данных
	const wchar_t* fileName,
	const wchar_t* HTUsersGroup)		// имя файла 
{

	if (!isGroupExisting(HTUsersGroup))
	{
		std::cout << "Error: group doesn't exist" << std::endl;
		*handle = NULL;
		return S_OK;
	}
	if (!isCurrentUserInGroup(HTUsersGroup))
	{
		std::wcout << "Error: user is not in group " << HTUsersGroup << std::endl;
		*handle = NULL;
		return S_OK;
	}
	if (!isCurrentUserInGroup(L"Администраторы"))
	{
		std::cout << "Error: user is not admin" << std::endl;
		*handle = NULL;
		return S_OK;
	}

	HANDLE hf = CreateFile(
		fileName,
		GENERIC_WRITE | GENERIC_READ,
		NULL,
		NULL,
		CREATE_ALWAYS,
		FILE_ATTRIBUTE_NORMAL,
		NULL);
	if (hf == INVALID_HANDLE_VALUE)
		throw "Create or open file failed";

	int sizeMap = sizeof(HT::HTHANDLE) + GetElementSize(maxKeyLength, maxPayloadLength) * capacity;
	std::wstring FileMappingName = L"Global\\"; FileMappingName += fileName; FileMappingName += L"-filemapping";
	SECURITY_ATTRIBUTES SA = getSecurityAttributes();
	HANDLE hm = CreateFileMapping(
		hf,
		&SA,
		PAGE_READWRITE,
		0, sizeMap,
		FileMappingName.c_str());
	if (!hm)
		throw "Create File Mapping failed";

	LPVOID lp = MapViewOfFile(
		hm,
		FILE_MAP_ALL_ACCESS,
		0, 0, 0);
	if (!lp)
	{
		*handle = NULL;
		return S_OK;
	}

	ZeroMemory(lp, sizeMap);

	HT::HTHANDLE* htHandle = new(lp) HT::HTHANDLE(capacity, secSnapshotInterval, maxKeyLength, maxPayloadLength, fileName, HTUsersGroup);
	htHandle->File = hf;
	htHandle->FileMapping = hm;
	htHandle->Addr = lp;
	htHandle->lastsnaptime = time(NULL);

	htHandle->snapshotTimer = CreateWaitableTimer(0, FALSE, 0);
	LARGE_INTEGER Li{};
	Li.QuadPart = -(10000000 * htHandle->SecSnapshotInterval);
	SetWaitableTimer(htHandle->snapshotTimer, &Li, htHandle->SecSnapshotInterval * 1000, SnapAsyncWrapper, htHandle, FALSE);

	*handle = htHandle;
	return S_OK;
}

static void CALLBACK SnapAsyncWrapper(LPVOID prm, DWORD dwTimerLowValue, DWORD dwTimerHighValue)
{
	CA* caInstance = new CA();
	caInstance->snapAsync(prm, dwTimerLowValue, dwTimerHighValue);
}

void CALLBACK CA::snapAsync(LPVOID prm, DWORD, DWORD)
{
	HT::HTHANDLE* htHandle = (HT::HTHANDLE*)prm;
	BOOL rc;
	Snap(rc, htHandle);
	if (rc)
		std::cout << "SpanshotAsync success" << std::endl;
}

HRESULT STDMETHODCALLTYPE CA::Open
(
	HT::HTHANDLE** handle,
	const wchar_t* fileName,
	bool isMapFile)         // имя файла
{
	HT::HTHANDLE* htHandle;
	if (isMapFile)
	{
		htHandle = OpenHTFromMapName(fileName);
	}
	else
	{
		htHandle = OpenHTFromFile(fileName);
		if (htHandle)
		{
			htHandle->snapshotTimer = CreateWaitableTimer(0, FALSE, 0);
			LARGE_INTEGER Li{};
			Li.QuadPart = -(10000000 * htHandle->SecSnapshotInterval);
			SetWaitableTimer(htHandle->snapshotTimer, &Li, htHandle->SecSnapshotInterval * 1000, SnapAsyncWrapper, htHandle, FALSE);
		}
	}

	if (htHandle && !isCurrentUserInGroup(htHandle->HTUsersGroup))
	{
		std::wcout << "Error: user is not in group " << htHandle->HTUsersGroup << std::endl;
		BOOL rc;
		Close(rc, htHandle);
		*handle = NULL;
		return S_OK;
	}

	*handle = htHandle;
	return S_OK;
}

HRESULT STDMETHODCALLTYPE CA::Open(HT::HTHANDLE** handle, const wchar_t* HTUser, const wchar_t* HTPassword, const wchar_t* fileName, bool isMapFile)
{

	HT::HTHANDLE* htHandle;
	if (isMapFile)
	{
		htHandle = OpenHTFromMapName(fileName);
	}
	else
	{
		htHandle = OpenHTFromFile(fileName);
		if (htHandle)
		{
			htHandle->snapshotTimer = CreateWaitableTimer(0, FALSE, 0);
			LARGE_INTEGER Li{};
			Li.QuadPart = -(10000000 * htHandle->SecSnapshotInterval);
			SetWaitableTimer(htHandle->snapshotTimer, &Li, htHandle->SecSnapshotInterval * 1000, SnapAsyncWrapper, htHandle, FALSE);
		}
	}

	if (htHandle && !(isUserInGroup(HTUser, htHandle->HTUsersGroup) && verifyCredentials(HTUser, HTPassword)))
	{
		std::wcout << "Error: user is not in group " << htHandle->HTUsersGroup << " or their credetials are incorrect" << std::endl;
		BOOL rc;
		Close(rc, htHandle);
		*handle = NULL;
		return S_OK;
	}

	*handle = htHandle;
	return S_OK;
}

HT::HTHANDLE* CA::OpenHTFromFile(const wchar_t* fileName)
{
	HANDLE hf = CreateFile(
		fileName,
		GENERIC_WRITE | GENERIC_READ,
		NULL,
		NULL,
		OPEN_ALWAYS,
		FILE_ATTRIBUTE_NORMAL,
		NULL);
	if (hf == INVALID_HANDLE_VALUE)
		return NULL;

	std::wstring FileMappingName = L"Global\\"; FileMappingName += fileName; FileMappingName += L"-filemapping";
	SECURITY_ATTRIBUTES SA = getSecurityAttributes();

	HANDLE hm = CreateFileMapping(
		hf,
		&SA,
		PAGE_READWRITE,
		0, 0,
		FileMappingName.c_str());
	if (!hm)
		return NULL;

	LPVOID lp = MapViewOfFile(
		hm,
		FILE_MAP_ALL_ACCESS,
		0, 0, 0);
	if (!lp)
		return NULL;

	HT::HTHANDLE* htHandle = (HT::HTHANDLE*)lp;
	htHandle->File = hf;
	htHandle->FileMapping = hm;
	htHandle->Addr = lp;
	htHandle->lastsnaptime = time(NULL);

	return htHandle;
}

HT::HTHANDLE* CA::OpenHTFromMapName(const wchar_t* fileName)
{
	std::wstring FileMappingName = L"Global\\"; FileMappingName += fileName; FileMappingName += L"-filemapping";
	HANDLE hm = OpenFileMapping(
		FILE_MAP_ALL_ACCESS,
		false,
		FileMappingName.c_str());
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
	htHandle->snapshotTimer = NULL;

	return htHandle;
}


HRESULT STDMETHODCALLTYPE CA::Get     //  читать элемент из хранилища
(
	HT::Element** resultElement,
	HT::HTHANDLE* htHandle,            // управление HT
	const HT::Element* element)              // элемент 
{
	int index = findIndex(htHandle, element);
	if (index < 0)
	{
		WriteLastError(htHandle, "Not found element (GET)");
		*resultElement = NULL;
		return S_OK;
	}

	HT::Element* foundElement = new HT::Element();
	readFromMemory(htHandle, foundElement, index);

	*resultElement = foundElement;

	return S_OK;
}

HRESULT STDMETHODCALLTYPE CA::Insert		// добавить элемент в хранилище
(
	BOOL& rc,
	HT::HTHANDLE* htHandle,            // управление HT
	const HT::Element* element)              // элемент
{
	if (htHandle->count >= htHandle->Capacity)
	{
		WriteLastError(htHandle, "Not found free memory");
		rc = false;
		return S_OK;
	}

	int freeIndex = findFreeIndex(htHandle, element);

	if (freeIndex < 0)
	{
		WriteLastError(htHandle, "Key already exists");
		rc = false;
		return S_OK;
	}

	writeToMemory(htHandle, element, freeIndex);
	incrementCount(htHandle);

	rc = true;
	return S_OK;
}

HRESULT STDMETHODCALLTYPE CA::Update     //  именить элемент в хранилище
(
	BOOL& rc,
	HT::HTHANDLE* htHandle,            // управление HT
	const HT::Element* oldElement,          // старый элемент (ключ, размер ключа)
	const void* newPayload,          // новые данные  
	int             newPayloadLength)     // размер новых данных
{
	int index = findIndex(htHandle, oldElement);
	if (index < 0)
	{
		WriteLastError(htHandle, "Not found element (UPDATE)");
		rc = false;
		return S_OK;
	}

	HT::Element* updateElement = new HT::Element((HT::Element*)oldElement, newPayload, newPayloadLength);
	writeToMemory(htHandle, updateElement, index);

	rc = true;
	return S_OK;
}

HRESULT STDMETHODCALLTYPE CA::Delete      // удалить элемент в хранилище
(
	BOOL& rc,
	HT::HTHANDLE* htHandle,            // управление HT (ключ)
	const HT::Element* element)				 // элемент 
{
	int index = findIndex(htHandle, element);
	if (index < 0)
	{
		WriteLastError(htHandle, "Not found element (DELETE)");
		rc = false;
		return S_OK;
	}

	clearMemoryByIndex(htHandle, index);
	decrementCount(htHandle);

	rc = true;
	return S_OK;
}

HRESULT STDMETHODCALLTYPE CA::Snap         // выполнить Snapshot
(
	BOOL& rc,
	HT::HTHANDLE* htHandle)           // управление HT (File, FileMapping)
{
	if (!FlushViewOfFile(htHandle->Addr, NULL))
	{
		WriteLastError(htHandle, "Snapshot error");
		rc = false;
		return S_OK;
	}
	htHandle->lastsnaptime = time(NULL);

	rc = true;
	return S_OK;
}

HRESULT STDMETHODCALLTYPE CA::print                               // распечатать элемент 
(
	const HT::Element* element)              // элемент 
{
	std::cout << "Element:" << std::endl;
	std::cout << "{" << std::endl;
	std::cout << "\t\"key\": \"" << (char*)element->key << "\"," << std::endl;
	std::cout << "\t\"keyLength\": " << element->keylength << "," << std::endl;
	std::cout << "\t\"payload\": \"" << (char*)element->payload << "\"," << std::endl;
	std::cout << "\t\"payloadLength\": " << element->payloadlength << std::endl;
	std::cout << "}" << std::endl;

	return S_OK;
}

HRESULT STDMETHODCALLTYPE CA::Close        // snap и закрыть HT  и  очистить htHandle
(
	BOOL& rc,
	const HT::HTHANDLE* htHandle)           // управление HT (File, FileMapping)
{
	HANDLE hf = htHandle->File;
	HANDLE hfm = htHandle->FileMapping;

	if (!CancelWaitableTimer(htHandle->snapshotTimer))
		throw "Cancel snapshotTimer failed";
	if (!UnmapViewOfFile(htHandle->Addr))
		throw "Unmapping view failed";
	if (!CloseHandle(hfm))
		throw "Close File Mapping failed";
	if (hf != NULL)
		if (!CloseHandle(hf))
			throw "Close File failed";

	rc = true;
	return S_OK;
}

int CA::GetElementSize(int maxKeyLength, int maxPayloadLength)
{
	return maxKeyLength + maxPayloadLength + sizeof(int) * 2;
}

int CA::hashFunction(const char* key, int capacity)
{
	unsigned long i = 0;
	for (int j = 0; key[j]; j++)
		i += key[j];
	return i % capacity;
}

int CA::nextHash(int currentHash, const char* key, int capacity)
{
	return ++currentHash;
}

int CA::findFreeIndex(
	const HT::HTHANDLE* htHandle,           // управление HT
	const HT::Element* element)				// элемент
{
	int index = hashFunction((char*)element->key, htHandle->Capacity);

	HT::Element* foundElement = new HT::Element();
	do
	{
		if (index >= htHandle->Capacity || foundElement->key != NULL &&
			memcmp(foundElement->key, element->key, element->keylength) == NULL)
		{
			index = -1;
			break;
		}

		readFromMemory(htHandle, foundElement, index);
		index = nextHash(index, (char*)element->key, htHandle->Capacity);
	} while (
		foundElement->keylength != NULL &&
		foundElement->payloadlength != NULL);

	delete foundElement;
	return index - 1;
}

int CA::findIndex(
	const HT::HTHANDLE* htHandle,           // управление HT
	const HT::Element* element)				// элемент
{
	int index = hashFunction((char*)element->key, htHandle->Capacity);

	HT::Element* foundElement = new HT::Element();
	do
	{
		if (index >= htHandle->Capacity)
		{
			index = -1;
			break;
		}

		readFromMemory(htHandle, foundElement, index);
		index = nextHash(index, (char*)element->key, htHandle->Capacity);
	} while (
		memcmp(foundElement->key, element->key, element->keylength) != NULL);

	delete foundElement;
	return index - 1;
}

BOOL CA::writeToMemory(const HT::HTHANDLE* const htHandle, const HT::Element* const element, int index)
{
	LPVOID lp = htHandle->Addr;

	lp = (HT::HTHANDLE*)lp + 1;
	lp = (BYTE*)lp + GetElementSize(htHandle->MaxKeyLength, htHandle->MaxPayloadLength) * index;

	memcpy(lp, element->key, element->keylength);
	lp = (BYTE*)lp + htHandle->MaxKeyLength;
	memcpy(lp, &element->keylength, sizeof(int));
	lp = (int*)lp + 1;
	memcpy(lp, element->payload, element->payloadlength);
	lp = (BYTE*)lp + htHandle->MaxPayloadLength;
	memcpy(lp, &element->payloadlength, sizeof(int));

	return true;
}

int CA::incrementCount(HT::HTHANDLE* const htHandle)
{
	return ++htHandle->count;
}

HT::Element* CA::readFromMemory(const HT::HTHANDLE* const htHandle, HT::Element* const element, int index)
{
	LPVOID lp = htHandle->Addr;

	lp = (HT::HTHANDLE*)lp + 1;
	lp = (BYTE*)lp + GetElementSize(htHandle->MaxKeyLength, htHandle->MaxPayloadLength) * index;

	element->key = lp;
	lp = (BYTE*)lp + htHandle->MaxKeyLength;
	element->keylength = *(int*)lp;
	lp = (int*)lp + 1;
	element->payload = lp;
	lp = (BYTE*)lp + htHandle->MaxPayloadLength;
	element->payloadlength = *(int*)lp;

	return element;
}

BOOL CA::clearMemoryByIndex(const HT::HTHANDLE* const htHandle, int index)
{
	LPVOID lp = htHandle->Addr;
	int sizeElement = GetElementSize(htHandle->MaxKeyLength, htHandle->MaxPayloadLength);

	lp = (HT::HTHANDLE*)lp + 1;
	lp = (BYTE*)lp + sizeElement * index;

	ZeroMemory(lp, sizeElement);

	return true;
}

int CA::decrementCount(HT::HTHANDLE* const htHandle)
{
	return --htHandle->count;
}

const char* CA::WriteLastError(HT::HTHANDLE* const htHandle, const char* msg)
{
	memcpy(htHandle->LastErrorMessage, msg, sizeof(htHandle->LastErrorMessage));
	return htHandle->LastErrorMessage;
}

HRESULT STDMETHODCALLTYPE CA::getLastError  // получить сообщение о последней ошибке
(
	const char** error,
	const HT::HTHANDLE* htHandle                         // управление HT
)
{
	*error = htHandle->LastErrorMessage;
	return S_OK;
}

HRESULT STDMETHODCALLTYPE CA::CreateElementGet
(
	HT::Element** element,
	const void* key,
	int keyLength
)
{
	*element = new HT::Element(key, keyLength);
	return S_OK;
}

HRESULT STDMETHODCALLTYPE CA::CreateElementInsert
(
	HT::Element** element,
	const void* key,
	int keyLength,
	const void* payload,
	int payloadLength
)
{
	*element = new HT::Element(key, keyLength, payload, payloadLength);
	return S_OK;
}

HRESULT STDMETHODCALLTYPE CA::CreateElementUpdate
(
	HT::Element** element,
	const HT::Element* oldElement,
	const void* newPayload,
	int newPayloadLength
)
{
	*element = new HT::Element((HT::Element*)oldElement, newPayload, newPayloadLength);
	return S_OK;
}

BOOL CA::isGroupExisting(LPCWSTR groupName)
{
	GROUP_INFO_0* groupsInfo;
	DWORD readed = 0, total = 0;
	NetLocalGroupEnum(
		NULL,
		0,
		(LPBYTE*)&groupsInfo,
		MAX_PREFERRED_LENGTH,
		&readed,
		&total,
		NULL
	);
	bool exosts = false;
	for (int i = 0; i < readed; i++)
	{
		int res = lstrcmpW(groupName, groupsInfo[i].grpi0_name);
		if (res == 0) {
			exosts = true;
			break;
		}
	}
	NetApiBufferFree((LPVOID)groupsInfo);
	return exosts;
}

BOOL CA::isUserInGroup(LPCWSTR userName, LPCWSTR groupName)
{
	GROUP_USERS_INFO_0* groupUsersInfo;
	DWORD uc = 0, tc = 0;
	NET_API_STATUS ns = NetUserGetLocalGroups(
		NULL,
		userName,
		0,
		LG_INCLUDE_INDIRECT,
		(LPBYTE*)&groupUsersInfo,
		MAX_PREFERRED_LENGTH,
		&uc,
		&tc
	);
	bool exists = false;
	if (ns == NERR_Success)
	{
		for (int i = 0; i < uc; i++)
		{
			int res = lstrcmpW(groupName, groupUsersInfo[i].grui0_name);
			if (res == 0)
			{
				exists = true;
				break;
			}
		}
		NetApiBufferFree((LPVOID)groupUsersInfo);
	}
	return exists;
}

BOOL CA::isCurrentUserInGroup(LPCWSTR groupName)
{
	WCHAR currentUserName[512];
	DWORD lenUserName = 512;
	GetUserName(currentUserName, &lenUserName);
	return isUserInGroup(currentUserName, groupName);
}

BOOL CA::verifyCredentials(LPCWSTR name, LPCWSTR pass)
{
	bool res;
	HANDLE hToken = 0;
	res = LogonUserW(
		name,
		L".",
		pass,
		LOGON32_LOGON_INTERACTIVE,
		LOGON32_PROVIDER_DEFAULT,
		&hToken
	);
	CloseHandle(hToken);
	return res;
}
SECURITY_ATTRIBUTES CA::getSecurityAttributes()
{
	const wchar_t* sdd = L"D:"
		L"(D;OICI;GA;;;BG)" //Deny guests
		L"(D;OICI;GA;;;AN)" //Deny anonymous
		L"(A;OICI;GA;;;AU)" //Allow read, write and execute for Users
		L"(A;OICI;GA;;;BA)"; //Allow all for Administrators
	SECURITY_ATTRIBUTES SA;
	ZeroMemory(&SA, sizeof(SA));
	SA.nLength = sizeof(SA);
	ConvertStringSecurityDescriptorToSecurityDescriptor(
		sdd,
		SDDL_REVISION_1,
		&SA.lpSecurityDescriptor,
		NULL);

	return SA;
}