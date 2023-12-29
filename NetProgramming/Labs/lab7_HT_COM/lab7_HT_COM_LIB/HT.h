#pragma once
#include"pch.h"
#include<Windows.h>
namespace HT {
	struct HTHANDLE    // блок управления HT
	{
		HTHANDLE();
		HTHANDLE(int Capacity, int SecSnapshotInterval, int MaxKeyLength, int MaxPayloadLength, const wchar_t* FileName, const wchar_t* HTUsersGroup);
		int     Capacity;               // емкость хранилища в количестве элементов 
		int     SecSnapshotInterval;    // периодичность сохранения в сек. xd
		int     MaxKeyLength;           // максимальная длина ключа
		int     MaxPayloadLength;       // максимальная длина данных
		wchar_t     FileName[512];          // имя файла 
		HANDLE  File;                   // File HANDLE != 0, если файл открыт
		HANDLE  FileMapping;            // Mapping File HANDLE != 0, если mapping создан  
		LPVOID  Addr;                   // Addr != NULL, если mapview выполнен  
		char    LastErrorMessage[512];  // сообщение об последней ошибке или 0x00  
		time_t  lastsnaptime;           // дата последнего snap'a (time())  
		wchar_t     HTUsersGroup[512];          // имя файла 
		int count;						//количество элементов в хранилище
		HANDLE snapshotTimer;			// таймер для snapshot
	};

	struct Element   // элемент 
	{
		Element();
		Element(const void* key, int keylength);                                             // for Get
		Element(const void* key, int keylength, const void* payload, int  payloadlength);    // for Insert
		Element(Element* oldelement, const void* newpayload, int  newpayloadlength);         // for update
		const void* key;                 // значение ключа 
		int             keylength;           // рахмер ключа
		const void* payload;             // данные 
		int             payloadlength;       // размер данных
	};
}