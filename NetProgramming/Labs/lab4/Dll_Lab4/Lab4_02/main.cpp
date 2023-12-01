#include<string>
#include<sstream>
#include "../Dll_Lab4/pch.h"
#include "../Dll_Lab4/HT.h"

using namespace std;


int main(int argc, char* argv[]) {
	srand(time(NULL));
	try {
#ifdef _WIN64
		HMODULE hmdl = LoadLibrary(L"../x64/Debug/Dll_Lab4.dll");
#else
		HMODULE hmdl = LoadLibrary(L"../Debug/Dll_Lab4.dll");
#endif
		if (!hmdl) {
			throw "Cannot LoadLibrary";
		}
		cout << "Library loaded";
		HT::HTHANDLE* (*Open)(const wchar_t*,bool) = (HT::HTHANDLE * (*)(const wchar_t*, bool))GetProcAddress(hmdl, "Open");
		BOOL(*Insert)(HT::HTHANDLE*, const HT::Element*) = (BOOL(*)(HT::HTHANDLE*, const HT::Element*))GetProcAddress(hmdl, "Insert");
		HT::Element* (*createElementForInsert)(const void*, int, const void*, int) = (HT::Element *(*)(const void*, int, const void*, int))GetProcAddress(hmdl, "createElementForInsert");
		HT::HTHANDLE* ht = Open(L"../files/HTspace.ht", true);
		if (ht) {
			cout << "Opened" << endl;
		}
		else {
			throw "Cannot open FileMapping";
		}
		while (true) {
			int keyGen = rand() % 50;
			string key = to_string(keyGen);
			cout << "Generated Key: " << key << endl;

			HT::Element* elem = createElementForInsert(key.c_str(), key.length() + 1, "0", 2);
			if (Insert(ht, elem)) {
				cout << "element was inserted" << endl;
			}
			else {
				throw "Cannot insert element";
			}
			delete elem;
			Sleep(1000);
		}
		if (!FreeLibrary(hmdl)) {
			throw "Cannot free Library";
		}
		cout << "Free Library"<<endl;
	}
	catch (exception&) {
		cout << "xd";
		return -1;
	}
	catch (const char* e) {
		cout << e << endl;
	}
	return 0;
}