
#include <thread>
#include <Windows.h>
#include<iostream>
using namespace std;

int main()
{
	for (short i = 1; i <= 10000; ++i)
	{
		cout << "PID: " << GetCurrentProcessId() << "\n";
		cout << "TID: " << GetCurrentThreadId() << "\n";
		Sleep(1000);
	}
	//Áÿðíàöê³ - õóÿñîñ
	return 0;

}