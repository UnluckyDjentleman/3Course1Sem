#pragma once
#include<Unknwn.h>

extern ULONG g_ServerLocks;

class OperFactory :public IClassFactory {
protected:
	ULONG m_lRef;
public:
	OperFactory();
	~OperFactory();

	virtual HRESULT STDMETHODCALLTYPE QueryInterface(REFIID riid, void** ppv);
	virtual ULONG STDMETHODCALLTYPE AddRef(void);
	virtual ULONG STDMETHODCALLTYPE Release(void);

	virtual HRESULT STDMETHODCALLTYPE CreateInstance(IUnknown* pUO, const IID& iid, void** ppv);
	virtual HRESULT STDMETHODCALLTYPE LockServer(BOOL b);
};