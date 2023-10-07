#pragma once
#include<objbase.h>
#include<initguid.h>
// {E18FF541-3939-496B-9E65-32D5BBA62627}
DEFINE_GUID(IID_IAdder,
	0xe18ff541, 0x3939, 0x496b, 0x9e, 0x65, 0x32, 0xd5, 0xbb, 0xa6, 0x26, 0x27);
// {5783269E-B02E-45A9-843F-620F29DEA460}
DEFINE_GUID(IID_IMultiplier,
	0x5783269e, 0xb02e, 0x45a9, 0x84, 0x3f, 0x62, 0xf, 0x29, 0xde, 0xa4, 0x60);


interface IAdder :IUnknown {
	virtual HRESULT __stdcall Add(const double, const double, double &)=0;
	virtual HRESULT __stdcall Sub(const double, const double, double&)=0;
};
interface IMultiplier :IUnknown {
	virtual HRESULT __stdcall Mul(const double, const double, double&)=0;
	virtual HRESULT __stdcall Div(const double, const double y, double&)=0;
};