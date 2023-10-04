#include<iostream>
#include <windows.h>
#include <tlhelp32.h>

int main() {
    HANDLE hSnap;
    PROCESSENTRY32 pe32;
    system("chcp 1251>null");

    hSnap = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);

    if (hSnap == INVALID_HANDLE_VALUE) {
        std::cerr << "Ошибка при создании снимка процессов: " << GetLastError() << std::endl;
        return 1;
    }


    pe32.dwSize = sizeof(PROCESSENTRY32);


    if (!Process32First(hSnap, &pe32)) {
        std::cerr << "Ошибка при получении информации о первом процессе: " << GetLastError() << std::endl;
        CloseHandle(hSnap);
        return 1;
    }


    do {
        std::cout << "ID процесса: " << pe32.th32ProcessID << std::endl;
        std::cout << L"Имя процесса: " << pe32.szExeFile << std::endl;
    } while (Process32Next(hSnap, &pe32));

    CloseHandle(hSnap);

    return 0;
}