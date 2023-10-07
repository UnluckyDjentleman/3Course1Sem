#include<iostream>
#include<Unknwn.h>
#include"../SP02_COM/Interfaces.h";

using std::cout;

#define IERR(x) std::cout<<"error: "<<x<<std::endl;
#define IRES(x,r) std::cout<<x<<r<<std::endl;

IAdder* iadder = nullptr;
IMultiplier* imultiplier = nullptr;

static const GUID CLSID_CA =
{ 0xb89dd548, 0xebf1, 0x491f, { 0x9e, 0x9d, 0x59, 0x5f, 0x54, 0x3, 0xfd, 0xaf } };

int main() {
	IUnknown* iunknown = NULL;
	CoInitialize(NULL);
	HRESULT hr0 = CoCreateInstance(CLSID_CA, NULL, CLSCTX_INPROC_SERVER, IID_IUnknown, (void**)&iunknown);
	if (SUCCEEDED(hr0))
	{
		std::cout << "CoCreateInstance succeeded" << std::endl;
		if (SUCCEEDED(iunknown->QueryInterface(IID_IAdder, (void**)&iadder)))
		{
			{
				double z = 0.0;
				if (!SUCCEEDED(iadder->Add(2.0, 3.0, z))) { IERR("IAdder::Add"); }
				else IRES("IAdder::Add = ", z);
			}
			{
				double z = 0.0;
				if (!SUCCEEDED(iadder->Sub(2.0, 3.0, z))) { IERR("IAdder::Sub"); }
				else IRES("IAdder::Sub = ", z);
			}
			if (SUCCEEDED(iadder->QueryInterface(IID_IMultiplier, (void**)&imultiplier)))
			{
				{
					double z = 0.0;
					if (!SUCCEEDED(imultiplier->Mul(2.0, 3.0, z))) { IERR("IMultiplier::Mul"); }
					else IRES("Multiplier::Mul = ", z);
				}
				{
					double z = 0.0;
					if (!SUCCEEDED(imultiplier->Div(2.0, 3.0, z))) { IERR("IMultiplier::Div"); }
					else IRES("IMultiplier::Div = ", z);
				}
				if (SUCCEEDED(imultiplier->QueryInterface(IID_IAdder, (void**)&iadder)))
				{
					double z = 0.0;
					if (!SUCCEEDED(iadder->Add(2.0, 3.0, z))) { IERR("IAdder::Add"); }
					else IRES("IAdder::Add = ", z);
					iadder->Release();
				}
				else  IERR("IMultiplier->IAdder");
				imultiplier->Release();
			}
			else IERR("IAdder->IMultiplier");
			iadder->Release();
		}
		else  IERR("IAdder");
	}
	else  std::cout << "CoCreateInstance error" << std::endl;
	iunknown->Release();
	CoFreeUnusedLibraries();                   // завершение работы с библиотекой      

	return 0;
}
