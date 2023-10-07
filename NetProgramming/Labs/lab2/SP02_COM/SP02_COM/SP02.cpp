#include "pch.h"


SP02::SP02() : count(1) {};
SP02::~SP02() {};

HRESULT STDMETHODCALLTYPE SP02::QueryInterface(REFIID riid, void** ppv) {
	HRESULT rc = S_OK;
	*ppv = NULL;
	if (riid == IID_IAdder||riid==IID_IUnknown) {
		*ppv = (IAdder*)this;
	}
	else if (riid == IID_IMultiplier) {
		*ppv = (IMultiplier*)this;
	}
	else {
		rc = E_NOINTERFACE;
	}
	if (rc == S_OK) this->AddRef();
	return rc;
}
ULONG STDMETHODCALLTYPE SP02::AddRef(void) {
	InterlockedIncrement(&count);
	return this->count;
}
ULONG STDMETHODCALLTYPE SP02::Release(void) {
	InterlockedDecrement(&count);
	return this->count;
}
HRESULT __stdcall SP02::Add(const double x, const double y, double& z) {
	z = x + y;
	return S_OK;
}
HRESULT __stdcall SP02::Div(const double x, const double y, double& z) {
	z = x / y;
	return S_OK;
}
HRESULT __stdcall SP02::Sub(const double x, const double y, double& z) {
	z = x - y;
	return S_OK;
}
HRESULT __stdcall SP02::Mul(const double x, const double y, double& z) {
	z = x * y;
	return S_OK;
}

