#ifdef _WIN64
#pragma comment(lib,"./../x64/Debug/OS_10_HTAPI.lib")
#endif

#include"../OS_10_HTAPI/HT.h";
#include"../OS_10_HTAPI/pch.h";
#include <iostream>

using namespace std;
int main()
{
	HT::HTHANDLE* ht1 = nullptr;
	HT::HTHANDLE* ht2 = nullptr;
#pragma region ht1
	try
	{
		cout << "##############ht1################" << endl;
		ht1 = HT::Create(1000, 3, 10, 256, L"./files/HTspace.HT");
		if (ht1)
			cout << "-- create: success" << endl;
		else
			throw "-- create: error";

		if (HT::Insert(ht1, new HT::Element("key", 4, "payload", 8)))
			cout << "-- insert: success" << endl;
		else
			throw "-- insert: error";
	}
	catch (const char* msg)
	{
		cout << msg << endl;

		if (ht1 != nullptr)
			cout << HT::GetLastError(ht1) << endl;
	}
#pragma endregion

#pragma region ht2
	try
	{
		ht2 = HT::Open(L"./files/HTspace.HT");
		if (ht2)
			cout << "-- open: success" << endl;
		else
			throw "-- open: error";
		cout << "ht2: " << ht2->Addr << endl;

		HT::Element* hte = HT::Get(ht1, new HT::Element("key", 4));
		if (hte)
			cout << "-- get: success" << endl;
		else
			throw "-- get: error";

		HT::print(hte);
	}
	catch (const char* msg)
	{
		cout << msg << endl;
		if (ht1 != nullptr)
			cout << HT::GetLastError(ht1) << endl;
	}
#pragma endregion
	try
	{
		if (ht1 != nullptr)
			if (HT::Close(ht1))
				cout << "-- close: success" << endl;
			else
				throw "-- close: error";
	}
	catch (const char* msg)
	{
		cout << msg << endl;
	}
	try
	{
		if (ht2 != nullptr)
			if (HT::Close(ht2))
				cout << "-- close: success" << endl;
			else
				throw "-- close: error";
	}
	catch (const char* msg)
	{
		cout << msg << endl;
	}
}