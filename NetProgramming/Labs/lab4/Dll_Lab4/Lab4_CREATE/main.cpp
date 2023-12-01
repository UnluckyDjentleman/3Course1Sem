#define _CRT_SECURE_NO_WARNINGS
#include<iostream>
#include<wchar.h>
#include<Windows.h>
#include<sstream>
#pragma comment(lib, "../x64/Debug/Dll_Lab4.lib")

#include "../Dll_Lab4/HT.h"

using namespace std;

wchar_t* fromCharToWchar(const char* str) {
	wchar_t* res = new wchar_t[strlen(str) + 1];
	mbstowcs(res, str, strlen(str) + 1);
	return res;
}


int main(int argc, char* argv[]) {
	try {
		if (argc != 6) {
			throw "Invalid command line arguments";
		}
		HT::HTHANDLE* htHandle;
		htHandle = HT::Create(stoi(argv[1]), stoi(argv[2]), stoi(argv[3]), stoi(argv[4]), fromCharToWchar(argv[5]));
		if (htHandle) {
			cout << "HT-Storage Created filename ";
			wcout << htHandle->FileName;
			cout<< " snapshotinterval " << htHandle->SecSnapshotInterval <<
				" capacity " << htHandle->Capacity << " maxkeylength " << htHandle->MaxKeyLength << " maxdatalegth " << htHandle->MaxPayloadLength << endl;
			HT::Close(htHandle);
		}
		else {
			throw "Cannot Create FileMapping";
		}
	}
	catch (const exception&) {
		cout << "Lab4_CREATE ended up with error" << endl;
		return -1;
	}
	return 0;
}