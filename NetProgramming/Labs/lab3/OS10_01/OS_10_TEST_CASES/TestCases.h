#pragma once
#ifdef _WIN64
#pragma comment(lib, "./../x64/Debug/OS_10_HTAPI.lib")
#endif

#include "../OS_10_HTAPI/pch.h"
#include "../OS_10_HTAPI/HT.h"

namespace TestCase
{
	BOOL test1(HT::HTHANDLE* htHandle);
	BOOL test2(HT::HTHANDLE* htHandle);
	BOOL test3(HT::HTHANDLE* htHandle);
	BOOL test4(HT::HTHANDLE* htHandle);
}