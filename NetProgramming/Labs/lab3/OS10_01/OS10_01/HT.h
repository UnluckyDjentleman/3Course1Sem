#pragma once
#include <Windows.h>
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


	struct HTHANDLE    // ���� ���������� HT
	{
		HTHANDLE();
		HTHANDLE(int Capacity, int SecSnapshotInterval, int MaxKeyLength, int MaxPayloadLength, const wchar_t* FileName);
		int     Capacity;               // ������� ��������� � ���������� ��������� 
		int     SecSnapshotInterval;    // ������������� ���������� � ���. xd
		int     MaxKeyLength;           // ������������ ����� �����
		int     MaxPayloadLength;       // ������������ ����� ������
		char    FileName[512];          // ��� ����� 
		HANDLE  File;                   // File HANDLE != 0, ���� ���� ������
		HANDLE  FileMapping;            // Mapping File HANDLE != 0, ���� mapping ������  
		LPVOID  Addr;                   // Addr != NULL, ���� mapview ��������  
		char    LastErrorMessage[512];  // ��������� �� ��������� ������ ��� 0x00  
		time_t  lastsnaptime;           // ���� ���������� snap'a (time())  
		int count; //���������� ��������� � ���������
	};

	struct Element   // ������� 
	{
		Element();
		Element(const void* key, int keylength);                                             // for Get
		Element(const void* key, int keylength, const void* payload, int  payloadlength);    // for Insert
		Element(Element* oldelement, const void* newpayload, int  newpayloadlength);         // for update
		const void* key;                 // �������� ����� 
		int             keylength;           // ������ �����
		const void* payload;             // ������ 
		int             payloadlength;       // ������ ������
	};

	HTHANDLE* Create   //  ������� HT             
	(
		int	  Capacity,					   // ������� ���������
		int   SecSnapshotInterval,		   // ������������� ���������� � ���.
		int   MaxKeyLength,                // ������������ ������ �����
		int   MaxPayloadLength,            // ������������ ������ ������
		const wchar_t* FileName         // ��� ����� 
	); 	// != NULL �������� ����������  

	HTHANDLE* Open     //  ������� HT             
	(
		const wchar_t* FileName         // ��� ����� 
	); 	// != NULL �������� ����������  

	BOOL Snap         // ��������� Snapshot
	(
		const HTHANDLE* hthandle           // ���������� HT (File, FileMapping)
	);


	BOOL Close        // Snap � ������� HT  �  �������� HTHANDLE
	(
		const HTHANDLE* hthandle           // ���������� HT (File, FileMapping)
	);	//  == TRUE �������� ����������   


	BOOL Insert      // �������� ������� � ���������
	(
		const HTHANDLE* hthandle,            // ���������� HT
		const Element* element              // �������
	);	//  == TRUE �������� ���������� 


	BOOL Delete      // ������� ������� � ���������
	(
		const HTHANDLE* hthandle,            // ���������� HT (����)
		const Element* element              // ������� 
	);	//  == TRUE �������� ���������� 

	Element* Get     //  ������ ������� � ���������
	(
		const HTHANDLE* hthandle,            // ���������� HT
		const Element* element              // ������� 
	); 	//  != NULL �������� ���������� 


	BOOL Update     //  ������� ������� � ���������
	(
		const HTHANDLE* hthandle,            // ���������� HT
		const Element* oldelement,          // ������ ������� (����, ������ �����)
		const void* newpayload,          // ����� ������  
		int             newpayloadlength     // ������ ����� ������
	); 	//  != NULL �������� ���������� 

	char* GetLastError  // �������� ��������� � ��������� ������
	(
		HTHANDLE* ht                         // ���������� HT
	);

	void print                               // ����������� ������� 
	(
		const Element* element              // ������� 
	);
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

