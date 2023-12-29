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

	virtual HRESULT STDMETHODCALLTYPE Create   //  ������� HT             
	(
		HT::HTHANDLE** handle,
		int	  capacity,					   // ������� ���������
		int   secSnapshotInterval,		   // ������������� ���������� � ���.
		int   maxKeyLength,                // ������������ ������ �����
		int   maxPayloadLength,            // ������������ ������ ������
		const wchar_t* HTUsersGroup,
		const wchar_t* fileName           // ��� ����� 
	); 	// != NULL �������� ���������� 

	virtual HRESULT STDMETHODCALLTYPE Open     //  ������� HT             
	(
		HT::HTHANDLE** handle,
		const wchar_t* fileName,         // ��� ����� 
		bool isMapFile = false
	); 	// != NULL �������� ����������  

	virtual HRESULT STDMETHODCALLTYPE Open(
		HT::HTHANDLE** handle,
		const wchar_t* HTUser,
		const wchar_t* HTPassword,
		const wchar_t* fileName,
		bool isMapFile = false
	);

	virtual HRESULT STDMETHODCALLTYPE Close        // snap � ������� HT  �  �������� htHandle
	(
		BOOL& rc,
		const HT::HTHANDLE* htHandle           // ���������� HT (File, FileMapping)
	);	//  == TRUE �������� ����������   


	virtual HRESULT STDMETHODCALLTYPE Insert      // �������� ������� � ���������
	(
		BOOL& rc,
		HT::HTHANDLE* htHandle,            // ���������� HT
		const HT::Element* element              // �������
	);	//  == TRUE �������� ���������� 

	virtual HRESULT STDMETHODCALLTYPE Delete      // ������� ������� � ���������
	(
		BOOL& rc,
		HT::HTHANDLE* htHandle,            // ���������� HT (����)
		const HT::Element* element              // ������� 
	);	//  == TRUE �������� ���������� 

	HRESULT __stdcall Snap(BOOL& rc, HT::HTHANDLE* htHandle);


	virtual HRESULT STDMETHODCALLTYPE Get     //  ������ ������� � ���������
	(
		HT::Element** resultElement,
		HT::HTHANDLE* htHandle,            // ���������� HT
		const HT::Element* element              // ������� 
	); 	//  != NULL �������� ���������� 


	virtual HRESULT STDMETHODCALLTYPE Update     //  ������� ������� � ���������
	(
		BOOL& rc,
		HT::HTHANDLE* htHandle,            // ���������� HT
		const HT::Element* oldElement,          // ������ ������� (����, ������ �����)
		const void* newPayload,          // ����� ������  
		int             newPayloadLength     // ������ ����� ������
	); 	//  != NULL �������� ���������� 

	virtual HRESULT STDMETHODCALLTYPE getLastError  // �������� ��������� � ��������� ������
	(
		const char** error,
		const HT::HTHANDLE* htHandle                         // ���������� HT
	);

	virtual HRESULT STDMETHODCALLTYPE print                               // ����������� ������� 
	(
		const HT::Element* element              // ������� 
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
		int   maxKeyLength,                // ������������ ������ �����
		int   maxPayloadLength	  // ������������ ������ ������
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