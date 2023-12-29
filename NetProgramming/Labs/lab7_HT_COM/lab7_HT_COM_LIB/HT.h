#pragma once
#include"pch.h"
#include<Windows.h>
namespace HT {
	struct HTHANDLE    // ���� ���������� HT
	{
		HTHANDLE();
		HTHANDLE(int Capacity, int SecSnapshotInterval, int MaxKeyLength, int MaxPayloadLength, const wchar_t* FileName, const wchar_t* HTUsersGroup);
		int     Capacity;               // ������� ��������� � ���������� ��������� 
		int     SecSnapshotInterval;    // ������������� ���������� � ���. xd
		int     MaxKeyLength;           // ������������ ����� �����
		int     MaxPayloadLength;       // ������������ ����� ������
		wchar_t     FileName[512];          // ��� ����� 
		HANDLE  File;                   // File HANDLE != 0, ���� ���� ������
		HANDLE  FileMapping;            // Mapping File HANDLE != 0, ���� mapping ������  
		LPVOID  Addr;                   // Addr != NULL, ���� mapview ��������  
		char    LastErrorMessage[512];  // ��������� �� ��������� ������ ��� 0x00  
		time_t  lastsnaptime;           // ���� ���������� snap'a (time())  
		wchar_t     HTUsersGroup[512];          // ��� ����� 
		int count;						//���������� ��������� � ���������
		HANDLE snapshotTimer;			// ������ ��� snapshot
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
}