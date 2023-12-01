#pragma once
#include"pch.h"
namespace HT    // HT API
{
	// API HT - ����������� ��������� ��� ������� � ��-��������� 
	//          ��-��������� ������������� ��� �������� ������ � �� � ������� ����/��������
	//          ���������������� (�����������) ������ �������������� � ������� snapshot-���������� 
	//          Create - �������  � ������� HT-��������� ��� �������������   
	//          Open   - ������� HT-��������� ��� �������������
	//          Insert - ������� ������� ������
	//          Delete - ������� ������� ������    
	//          Get    - ������  ������� ������
	//          Update - �������� ������� ������
	//          Snap   - �������� snapshot
	//          Close  - ��������� Snap � ������� HT-��������� ��� �������������
	//          GetLastError - �������� ��������� � ��������� ������


	extern "C" __declspec(dllexport) struct HTHANDLE    // ���� ���������� HT
	{
		__declspec(dllexport) HTHANDLE();
		__declspec(dllexport) HTHANDLE(int Capacity, int SecSnapshotInterval, int MaxKeyLength, int MaxPayloadLength, const wchar_t* FileName);
		int     Capacity;               // ������� ��������� � ���������� ��������� 
		int     SecSnapshotInterval;    // ������������� ���������� � ���. xd
		int     MaxKeyLength;           // ������������ ����� �����
		int     MaxPayloadLength;       // ������������ ����� ������
		wchar_t    FileName[512];          // ��� ����� 
		HANDLE  File;                   // File HANDLE != 0, ���� ���� ������
		HANDLE  FileMapping;            // Mapping File HANDLE != 0, ���� mapping ������  
		LPVOID  Addr;                   // Addr != NULL, ���� mapview ��������  
		char    LastErrorMessage[512];  // ��������� �� ��������� ������ ��� 0x00  
		time_t  lastsnaptime;           // ���� ���������� snap'a (time())  
		int count;						//���������� ��������� � ���������
		HANDLE snapshotTimer;			// ������ ��� snapshot
	};

	extern "C" __declspec(dllexport) struct Element   // ������� 
	{
		__declspec(dllexport) Element();
		__declspec(dllexport) Element(const void* , int );                                             // for Get
		__declspec(dllexport) Element(const void* , int , const void* , int  );    // for Insert
		__declspec(dllexport) Element(Element* , const void* , int  );         // for update
		const void* key;                 // �������� ����� 
		int             keylength;           // ������ �����
		const void* payload;             // ������ 
		int             payloadlength;       // ������ ������
	};

	extern "C" __declspec(dllexport) Element * createElementForInsert(const void*, int, const void*, int);

	extern "C" __declspec(dllexport) HTHANDLE* Create   //  ������� HT             
	(
		int	  Capacity,					   // ������� ���������
		int   SecSnapshotInterval,		   // ������������� ���������� � ���.
		int   MaxKeyLength,                // ������������ ������ �����
		int   MaxPayloadLength,            // ������������ ������ ������
		const wchar_t* FileName         // ��� ����� 
	); 	// != NULL �������� ����������  

	extern "C" __declspec(dllexport) HTHANDLE* Open     //  ������� HT             
	(
		const wchar_t* FileName,         // ��� ����� 
		bool IsMapped=false //true - ������ �� FileMapping, false - ������ �� ����
	); 	// != NULL �������� ����������  

	extern "C" __declspec(dllexport) BOOL Snap         // ��������� Snapshot
	(
		const HTHANDLE* hthandle           // ���������� HT (File, FileMapping)
	);


	extern "C" __declspec(dllexport) BOOL Close        // Snap � ������� HT  �  �������� HTHANDLE
	(
		const HTHANDLE* hthandle           // ���������� HT (File, FileMapping)
	);	//  == TRUE �������� ����������   


	extern "C" __declspec(dllexport) BOOL Insert      // �������� ������� � ���������
	(
		const HTHANDLE* hthandle,            // ���������� HT
		const Element* element              // �������
	);	//  == TRUE �������� ���������� 


	extern "C" __declspec(dllexport) BOOL Delete      // ������� ������� � ���������
	(
		const HTHANDLE* hthandle,            // ���������� HT (����)
		const Element* element              // ������� 
	);	//  == TRUE �������� ���������� 

	extern "C" __declspec(dllexport) Element* Get     //  ������ ������� � ���������
	(
		const HTHANDLE* hthandle,            // ���������� HT
		const Element* element              // ������� 
	); 	//  != NULL �������� ���������� 


	extern "C" __declspec(dllexport) BOOL Update     //  ������� ������� � ���������
	(
		const HTHANDLE* hthandle,            // ���������� HT
		const Element* oldelement,          // ������ ������� (����, ������ �����)
		const void* newpayload,          // ����� ������  
		int             newpayloadlength     // ������ ����� ������
	); 	//  != NULL �������� ���������� 

	extern "C" __declspec(dllexport) char* getLastError  // �������� ��������� � ��������� ������
	(
		HTHANDLE* ht                         // ���������� HT
	);

	extern "C" __declspec(dllexport) void print                               // ����������� ������� 
	(
		const Element* element              // ������� 
	);
	void CALLBACK asyncSnap(LPVOID prm, DWORD, DWORD);
	BOOL runSnapshotTimer(HTHANDLE* htHandle);
	//FOR HT
	int hashFunc(const char* key, int Capacity);
	int findFree(const HTHANDLE* hthandle, const Element* element);
	int findIndex(const HTHANDLE* hthandle, const Element* element);
	BOOL clearMem(const HTHANDLE* hthandle, int index);
	Element* readFromMem(const HTHANDLE* hthandle, Element* element, int index);
	bool WriteToMem(const HTHANDLE* hthandle, const Element* element, int index);
	int decrCount(HTHANDLE* hthandle);
	int incrCount(HTHANDLE* hthandle);
};
