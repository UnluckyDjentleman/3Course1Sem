#pragma once
#include"pch.h"
namespace HT    // HT API
{
	// API HT - программный интерфейс для доступа к НТ-хранилищу 
	//          НТ-хранилище предназначено для хранения данных в ОП в формате ключ/значение
	//          Персистестеность (сохранность) данных обеспечивается с помощью snapshot-менханизма 
	//          Create - создать  и открыть HT-хранилище для использования   
	//          Open   - открыть HT-хранилище для использования
	//          Insert - создать элемент данных
	//          Delete - удалить элемент данных    
	//          Get    - читать  элемент данных
	//          Update - изменить элемент данных
	//          Snap   - выпонить snapshot
	//          Close  - выполнить Snap и закрыть HT-хранилище для использования
	//          GetLastError - получить сообщение о последней ошибке


	extern "C" __declspec(dllexport) struct HTHANDLE    // блок управления HT
	{
		__declspec(dllexport) HTHANDLE();
		__declspec(dllexport) HTHANDLE(int Capacity, int SecSnapshotInterval, int MaxKeyLength, int MaxPayloadLength, const wchar_t* FileName);
		int     Capacity;               // емкость хранилища в количестве элементов 
		int     SecSnapshotInterval;    // периодичность сохранения в сек. xd
		int     MaxKeyLength;           // максимальная длина ключа
		int     MaxPayloadLength;       // максимальная длина данных
		wchar_t    FileName[512];          // имя файла 
		HANDLE  File;                   // File HANDLE != 0, если файл открыт
		HANDLE  FileMapping;            // Mapping File HANDLE != 0, если mapping создан  
		LPVOID  Addr;                   // Addr != NULL, если mapview выполнен  
		char    LastErrorMessage[512];  // сообщение об последней ошибке или 0x00  
		time_t  lastsnaptime;           // дата последнего snap'a (time())  
		int count;						//количество элементов в хранилище
		HANDLE snapshotTimer;			// таймер для snapshot
	};

	extern "C" __declspec(dllexport) struct Element   // элемент 
	{
		__declspec(dllexport) Element();
		__declspec(dllexport) Element(const void* , int );                                             // for Get
		__declspec(dllexport) Element(const void* , int , const void* , int  );    // for Insert
		__declspec(dllexport) Element(Element* , const void* , int  );         // for update
		const void* key;                 // значение ключа 
		int             keylength;           // рахмер ключа
		const void* payload;             // данные 
		int             payloadlength;       // размер данных
	};

	extern "C" __declspec(dllexport) Element * createElementForInsert(const void*, int, const void*, int);

	extern "C" __declspec(dllexport) HTHANDLE* Create   //  создать HT             
	(
		int	  Capacity,					   // емкость хранилища
		int   SecSnapshotInterval,		   // переодичность сохранения в сек.
		int   MaxKeyLength,                // максимальный размер ключа
		int   MaxPayloadLength,            // максимальный размер данных
		const wchar_t* FileName         // имя файла 
	); 	// != NULL успешное завершение  

	extern "C" __declspec(dllexport) HTHANDLE* Open     //  открыть HT             
	(
		const wchar_t* FileName,         // имя файла 
		bool IsMapped=false //true - открыт ли FileMapping, false - открыт ли файл
	); 	// != NULL успешное завершение  

	extern "C" __declspec(dllexport) BOOL Snap         // выполнить Snapshot
	(
		const HTHANDLE* hthandle           // управление HT (File, FileMapping)
	);


	extern "C" __declspec(dllexport) BOOL Close        // Snap и закрыть HT  и  очистить HTHANDLE
	(
		const HTHANDLE* hthandle           // управление HT (File, FileMapping)
	);	//  == TRUE успешное завершение   


	extern "C" __declspec(dllexport) BOOL Insert      // добавить элемент в хранилище
	(
		const HTHANDLE* hthandle,            // управление HT
		const Element* element              // элемент
	);	//  == TRUE успешное завершение 


	extern "C" __declspec(dllexport) BOOL Delete      // удалить элемент в хранилище
	(
		const HTHANDLE* hthandle,            // управление HT (ключ)
		const Element* element              // элемент 
	);	//  == TRUE успешное завершение 

	extern "C" __declspec(dllexport) Element* Get     //  читать элемент в хранилище
	(
		const HTHANDLE* hthandle,            // управление HT
		const Element* element              // элемент 
	); 	//  != NULL успешное завершение 


	extern "C" __declspec(dllexport) BOOL Update     //  именить элемент в хранилище
	(
		const HTHANDLE* hthandle,            // управление HT
		const Element* oldelement,          // старый элемент (ключ, размер ключа)
		const void* newpayload,          // новые данные  
		int             newpayloadlength     // размер новых данных
	); 	//  != NULL успешное завершение 

	extern "C" __declspec(dllexport) char* getLastError  // получить сообщение о последней ошибке
	(
		HTHANDLE* ht                         // управление HT
	);

	extern "C" __declspec(dllexport) void print                               // распечатать элемент 
	(
		const Element* element              // элемент 
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
