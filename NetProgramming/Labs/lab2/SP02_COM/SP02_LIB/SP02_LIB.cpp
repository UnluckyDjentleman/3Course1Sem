#include "pch.h"
#include <Unknwn.h>
#include <stdexcept>
#include <iostream>
#include "../SP02_COM/Interfaces.h"

static ULONG cObjects = 0;

#define IERR(x) std::cout<<"error: "<<x<<std::endl;
#define IRES(x,r) std::cout<<x<<r<<std::endl;

static const GUID CLSID_CA =
{ 0xb89dd548, 0xebf1, 0x491f, { 0x9e, 0x9d, 0x59, 0x5f, 0x54, 0x3, 0xfd, 0xaf } };

namespace SP02 {
	SP02LIB Init() {
		IUnknown* pIUnknown = nullptr;
		try {
			if (cObjects == 0) {
				if (!SUCCEEDED(CoInitialize(NULL))) {
					throw std::runtime_error("CoInitialize");
				}
			}
			if (!SUCCEEDED(CoCreateInstance(CLSID_CA, NULL, CLSCTX_INPROC_SERVER, IID_IUnknown, (void**)&pIUnknown))) {
				throw std::runtime_error("CreateInstance");
			}
			InterlockedIncrement(&cObjects);
			return pIUnknown;
		}
		catch (std::runtime_error e) {
			IERR(e.what());
		}
	}
	namespace Adder {
		double Add(SP02LIB h, double x, double y) {
			IAdder* pIAdder = nullptr;
			double z = 0.0;
			try {
				if (!SUCCEEDED(((IUnknown*)h)->QueryInterface(IID_IMultiplier, (void**)&pIAdder))) {
					throw std::runtime_error("QueryInstance");
				}
				if (!SUCCEEDED(pIAdder->Add(x, y, z))) {
					throw std::runtime_error("Add");
				}
			}
			catch (std::runtime_error e) {
				IERR(e.what());
			}
			if (pIAdder == nullptr) {
				pIAdder->Release();
			}
			return z;
		}
		double Sub(SP02LIB h, double x, double y) {
			IAdder* pIAdder = nullptr;
			double z = 0.0;
			try {
				if (!SUCCEEDED(((IUnknown*)h)->QueryInterface(IID_IAdder, (void**)&pIAdder))) {
					throw std::runtime_error("QueryInstance");
				}
				if (!SUCCEEDED(pIAdder->Sub(x, y, z))) {
					throw std::runtime_error("Add");
				}
			}
			catch (std::runtime_error e) {
				IERR(e.what());
			}
			if (pIAdder == nullptr) {
				pIAdder->Release();
			}
			return z;
		}
	}
	namespace Multiplier {
		double Mul(SP02LIB h, double x, double y) {
			IMultiplier* pIMultiplier = nullptr;
			double z = 0.0;
			try {
				if (!SUCCEEDED(((IUnknown*)h)->QueryInterface(IID_IMultiplier, (void**)&pIMultiplier))) {
					throw std::runtime_error("QueryInstance");
				}
				if (!SUCCEEDED(pIMultiplier->Mul(x, y, z))) {
					throw std::runtime_error("Mul");
				}
			}
			catch (std::runtime_error e) {
				IERR(e.what());
			}
			if (pIMultiplier == nullptr) {
				pIMultiplier->Release();
			}
			return z;
		}
		double Div(SP02LIB h, double x, double y) {
			IMultiplier* pIMultiplier = nullptr;
			double z = 0.0;
			try {
				if (!SUCCEEDED(((IUnknown*)h)->QueryInterface(IID_IMultiplier, (void**)&pIMultiplier))) {
					throw std::runtime_error("QueryInstance");
				}
				if (!SUCCEEDED(pIMultiplier->Div(x, y, z))) {
					throw std::runtime_error("Mul");
				}
			}
			catch (std::runtime_error e) {
				IERR(e.what());
			}
			if (pIMultiplier == nullptr) {
				pIMultiplier->Release();
			}
			return z;
		}
	}
	void Dispose(SP02LIB h) {
		((IUnknown*)h)->Release();
		InterlockedDecrement(&cObjects);
		if (cObjects == 0) {
			CoFreeUnusedLibraries();
		}
	}
}
