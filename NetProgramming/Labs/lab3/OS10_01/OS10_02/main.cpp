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

		HT::Element* HTe = HT::Get(ht1, new HT::Element("key", 4));
		if (HTe)
			cout << "-- get: success" << endl;
		else
			throw "-- get: error";

		HT::print(HTe);

		if (HT::Update(ht1, HTe, "newPayload", 11))
			cout << "-- update: success" << endl;
		else
			throw "-- update: error";

		if (HT::Snap(ht1))
			cout << "-- snapSync: success" << endl;
		else
			throw "-- snap: error";

		HTe = HT::Get(ht1, new HT::Element("key", 4));
		if (HTe)
			cout << "-- get: success" << endl;
		else
			throw "-- get: error";

		HT::print(HTe);

		SleepEx(3000, TRUE);

		if (HT::Delete(ht1, HTe))
			cout << "-- remove: success" << endl;
		else
			throw "-- remove: error";

		HTe = HT::Get(ht1, new HT::Element("key", 4));
		if (HTe)
			cout << "-- get: success" << endl;
		else
			throw "-- get: error";
	}
	catch (const char* msg)
	{
		cout << msg << endl;

		if (ht1 != nullptr)
			cout << HT::GetLastError(ht1) << endl;
	}

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
}