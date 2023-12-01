#ifdef _WIN64
#pragma comment(lib,"../x64/Debug/Dll_Lab4.lib")
#else
#pragma comment(lib,"../Debug/Dll_Lab4.lib")
#endif

#include<string>
#include<sstream>
#include "../Dll_Lab4/pch.h"
#include "../Dll_Lab4/HT.h"

using namespace std;


int main(int argc, char* argv[]) {
	srand(time(NULL));
	try {
		HT::HTHANDLE* ht = HT::Open(L"../files/HTspace.ht", true);
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
			HT::Element* elem = new HT::Element(key.c_str(), key.length() + 1);
			if (HT::Delete(ht, elem)) {
				cout << "Deleted element"<<endl;
			}
			else {
				cout << "Retry to delete" << endl;
			}
			delete elem;
			Sleep(1000);
		}
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