#include "pch.h"
#include "OperFactory.h"
ULONG g_lObjs = 0;
ULONG g_lLocks = 0;
OperFactory::OperFactory() {
	m_lRef = 1;
}
OperFactory::~OperFactory(){}

HRESULT STDMETHODCALLTYPE OperFactory::QueryInterface(REFIID riid, void** ppv) {
	HRESULT rc = S_OK;
	*ppv = NULL;
	if (riid == IID_IUnknown) *ppv = (IUnknown*)this;
	else if (riid == IID_IClassFactory) *ppv = (IClassFactory*)this;
	else rc = E_NOINTERFACE;
	if (rc == S_OK) this->AddRef();
	return rc;
}
ULONG STDMETHODCALLTYPE OperFactory::AddRef(void) {
	InterlockedIncrement(&m_lRef);
	return this->m_lRef;
}
ULONG STDMETHODCALLTYPE OperFactory::Release(void) {
	ULONG count = this->m_lRef;
	if((count=InterlockedDecrement((LONG*)&(this->m_lRef)))==0) delete this;
	return count;
}
HRESULT STDMETHODCALLTYPE OperFactory::LockServer(BOOL b) {
	if (b) InterlockedIncrement((LONG*)&g_lLocks);
	else InterlockedDecrement((LONG*)&g_lLocks);
	return S_OK;
}
HRESULT STDMETHODCALLTYPE OperFactory::CreateInstance(IUnknown* pUO, const IID& iid, void** ppv) {
	HRESULT rc = E_UNEXPECTED;
	SP02* sp02;
	if (pUO != NULL) rc = CLASS_E_NOAGGREGATION;
	else if ((sp02 = new SP02()) == NULL) rc = E_OUTOFMEMORY;
	else {
		rc = sp02->QueryInterface(iid, ppv);
		sp02->Release();
	}
	return rc;
}