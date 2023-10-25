#include "TestCases.h"
#include<iostream>
using namespace std;
int main() {
	try {
		HT::HTHANDLE* ht = HT::Create(100, 3, 10, 256, L"./files/HTspace.HT");
		if (TestCase::test1(ht)) {
			cout << "=========TestCase1 is passed============"<<endl;
		}
		else {
			cout << "===========TestCase1 is failed=============" << endl;
		}
		if (TestCase::test2(ht)) {
			cout << "=========TestCase2 is passed============" << endl;
		}
		else {
			cout << "=========TestCase2 is failed============" << endl;
		}
		if (TestCase::test3(ht)) {
			cout << "=========TestCase3 is passed============" << endl;
		}
		else {
			cout << "=========TestCase3 is failed============" << endl;
		}
		if (TestCase::test4(ht)) {
			cout << "=========TestCase4 is passed============" << endl;
		}
		else {
			cout << "=========TestCase4 is failed============" << endl;
		}
	}
	catch (const char* msg) {
		cout << msg << endl;
	}
}