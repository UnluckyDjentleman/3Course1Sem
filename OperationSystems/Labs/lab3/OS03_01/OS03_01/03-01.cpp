#include<iostream>
#include<Windows.h>
void main() {
	for (short i = 1; i <= 10000; i++) {
		std::cout << i << ". " << GetCurrentProcessId() << std::endl;
		Sleep(1000);
	}
}