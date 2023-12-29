#pragma once
#include <objbase.h>
#include <Unknwn.h>
#include <LM.h>
#include"HT.h"
#include "sddl.h"
#include "Interface.h"

#pragma comment (lib, "netapi32.lib")

extern ULONG g_Components;

class CA :IHTManager, IHTManagerData, IHTElement, IHTUtility {
private:
	ULONG count;
public:
	CA();
	~CA();
	virtual HRESULT STDMETHODCALLTYPE QueryInterface(REFIID riid, void** ppv);
	virtual ULONG STDMETHODCALLTYPE AddRef(void);
	virtual ULONG STDMETHODCALLTYPE Release(void);

	virtual HRESULT STDMETHODCALLTYPE Create   //  создать HT             
	(
		HT::HTHANDLE** handle,
		int	  capacity,					   // емкость хранилища
		int   secSnapshotInterval,		   // переодичность сохранения в сек.
		int   maxKeyLength,                // максимальный размер ключа
		int   maxPayloadLength,            // максимальный размер данных
		const wchar_t* HTUsersGroup,
		const wchar_t* fileName           // имя файла 
	); 	// != NULL успешное завершение 

	virtual HRESULT STDMETHODCALLTYPE Open     //  открыть HT             
	(
		HT::HTHANDLE** handle,
		const wchar_t* fileName,         // имя файла 
		bool isMapFile = false
	); 	// != NULL успешное завершение  

	virtual HRESULT STDMETHODCALLTYPE Open(
		HT::HTHANDLE** handle,
		const wchar_t* HTUser,
		const wchar_t* HTPassword,
		const wchar_t* fileName,
		bool isMapFile = false
	);

	virtual HRESULT STDMETHODCALLTYPE Close        // snap и закрыть HT  и  очистить htHandle
	(
		BOOL& rc,
		const HT::HTHANDLE* htHandle           // управление HT (File, FileMapping)
	);	//  == TRUE успешное завершение   


	virtual HRESULT STDMETHODCALLTYPE Insert      // добавить элемент в хранилище
	(
		BOOL& rc,
		HT::HTHANDLE* htHandle,            // управление HT
		const HT::Element* element              // элемент
	);	//  == TRUE успешное завершение 

	virtual HRESULT STDMETHODCALLTYPE Delete      // удалить элемент в хранилище
	(
		BOOL& rc,
		HT::HTHANDLE* htHandle,            // управление HT (ключ)
		const HT::Element* element              // элемент 
	);	//  == TRUE успешное завершение 

	HRESULT __stdcall Snap(BOOL& rc, HT::HTHANDLE* htHandle);


	virtual HRESULT STDMETHODCALLTYPE Get     //  читать элемент в хранилище
	(
		HT::Element** resultElement,
		HT::HTHANDLE* htHandle,            // управление HT
		const HT::Element* element              // элемент 
	); 	//  != NULL успешное завершение 


	virtual HRESULT STDMETHODCALLTYPE Update     //  именить элемент в хранилище
	(
		BOOL& rc,
		HT::HTHANDLE* htHandle,            // управление HT
		const HT::Element* oldElement,          // старый элемент (ключ, размер ключа)
		const void* newPayload,          // новые данные  
		int             newPayloadLength     // размер новых данных
	); 	//  != NULL успешное завершение 

	virtual HRESULT STDMETHODCALLTYPE getLastError  // получить сообщение о последней ошибке
	(
		const char** error,
		const HT::HTHANDLE* htHandle                         // управление HT
	);

	virtual HRESULT STDMETHODCALLTYPE print                               // распечатать элемент 
	(
		const HT::Element* element              // элемент 
	);

	virtual HRESULT STDMETHODCALLTYPE CreateElementGet
	(
		HT::Element** element,
		const void* key,
		int keyLength
	);

	virtual HRESULT STDMETHODCALLTYPE CreateElementInsert
	(
		HT::Element** element,
		const void* key,
		int keyLength,
		const void* payload,
		int payloadLength
	);

	virtual HRESULT STDMETHODCALLTYPE CreateElementUpdate
	(
		HT::Element** element,
		const HT::Element* oldElement,
		const void* newPayload,
		int newPayloadLength
	);

	void CALLBACK snapAsync(LPVOID prm, DWORD, DWORD);

private:
	volatile ULONG m_Ref;
	int GetElementSize
	(
		int   maxKeyLength,                // максимальный размер ключа
		int   maxPayloadLength	  // максимальный размер данных
	);
	int hashFunction(const char* key, int capacity);
	int nextHash(int currentHash, const char* key, int capacity);

	int findFreeIndex(const HT::HTHANDLE* htHandle, const HT::Element* element);
	BOOL writeToMemory(const HT::HTHANDLE* const htHandle, const HT::Element* const element, int index);
	int incrementCount(HT::HTHANDLE* const htHandle);

	int findIndex(const HT::HTHANDLE* htHandle, const HT::Element* element);
	HT::Element* readFromMemory(const HT::HTHANDLE* const htHandle, HT::Element* const element, int index);
	BOOL clearMemoryByIndex(const HT::HTHANDLE* const htHandle, int index);
	int decrementCount(HT::HTHANDLE* const htHandle);

	const char* WriteLastError(HT::HTHANDLE* const htHandle, const char* msg);

	HT::HTHANDLE* OpenHTFromFile(const wchar_t* fileName);
	HT::HTHANDLE* OpenHTFromMapName(const wchar_t* fileName);
	BOOL isGroupExisting(LPCWSTR groupName);

	BOOL isUserInGroup(LPCWSTR userName, LPCWSTR groupName);
	BOOL isCurrentUserInGroup(LPCWSTR groupName);
	BOOL verifyCredentials(LPCWSTR name, LPCWSTR pass);
	SECURITY_ATTRIBUTES getSecurityAttributes();
};