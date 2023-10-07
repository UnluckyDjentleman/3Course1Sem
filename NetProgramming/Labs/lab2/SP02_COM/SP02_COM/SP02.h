#pragma once
#include <objbase.h>
#include <Unknwn.h>
#include "Interfaces.h"

class SP02 :public IAdder, public IMultiplier {
private:
	ULONG count;
public:
	SP02();
	~SP02();
	virtual HRESULT STDMETHODCALLTYPE QueryInterface(REFIID riid, void** ppv);
	virtual ULONG STDMETHODCALLTYPE AddRef(void);
	virtual ULONG STDMETHODCALLTYPE Release(void);
	HRESULT __stdcall Add(const double, const double, double&);
	HRESULT __stdcall Sub(const double, const double, double&);
	HRESULT __stdcall Mul(const double, const double, double&);
	HRESULT __stdcall Div(const double, const double, double&);
};
