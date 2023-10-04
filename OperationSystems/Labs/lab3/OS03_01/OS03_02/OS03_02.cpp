#include <iostream>
#include <Windows.h>
using namespace std;

int main()
{
	cout << "====================  OS03_02  ====================\n\n";

	LPCWSTR OS03_02_1 = L"D:\\Sem31\\OperationSystems\\Labs\\lab3\\OS03_01\\x64\\Debug\\OS03_02_1.exe";
	LPCWSTR OS03_02_2 = L"D:\\Sem31\\OperationSystems\\Labs\\lab3\\OS03_01\\x64\\Debug\\OS03_02_2.exe";
	STARTUPINFO si1;								
	STARTUPINFO si2;
	PROCESS_INFORMATION pi1;						
	PROCESS_INFORMATION pi2;
	ZeroMemory(&si1, sizeof(STARTUPINFO));			
	ZeroMemory(&si2, sizeof(STARTUPINFO));
	si1.cb = sizeof(STARTUPINFO);					
	si1.dwFlags = STARTF_USEFILLATTRIBUTE;			
	si1.dwFillAttribute = (DWORD)FOREGROUND_BLUE;	
	si1.lpReserved = NULL;							
	si2.cb = sizeof(STARTUPINFO);
	si2.dwFlags = STARTF_USEFILLATTRIBUTE;
	si2.dwFillAttribute = (DWORD)FOREGROUND_RED;
	si1.lpReserved = NULL;


	if (CreateProcess(
		OS03_02_1,			
		NULL,				
		NULL,				
		NULL,				
		FALSE,				
		CREATE_NEW_CONSOLE,
		NULL,				
		NULL,				
		&si1,				
		&pi1))				
		cout << "[OK] Process OS03_02_1 was created.\n";
	else cout << "[ERROR] Process OS03_02_1 was not created.\n";


	if (CreateProcess(OS03_02_2, NULL, NULL, NULL, FALSE, CREATE_NEW_CONSOLE, NULL, NULL, &si2, &pi2))
		cout << "[OK] Process OS03_02_2 was created.\n\n";
	else cout << "[ERROR] Process OS03_02_2 was not created.\n\n";


	for (short i = 1; i <= 100; ++i)
	{
		cout << i << ". PID = " << GetCurrentProcessId() << "\n";
		Sleep(1000);
	}


	WaitForSingleObject(pi1.hProcess, INFINITE);	// бесконечно будет ожидаться завершение программы до момента, 
	WaitForSingleObject(pi2.hProcess, INFINITE);	// пока оба дочерних процесса не пошлют сигнал о завершении работы
	CloseHandle(pi1.hThread);	// CloseHandle закрывает дескрипторы в структуре PROCESS_INFORMATION
	CloseHandle(pi2.hThread);
	CloseHandle(pi1.hProcess);	// Явно закрываются первичный поток и процесс
	CloseHandle(pi2.hProcess);
	return 0;
}