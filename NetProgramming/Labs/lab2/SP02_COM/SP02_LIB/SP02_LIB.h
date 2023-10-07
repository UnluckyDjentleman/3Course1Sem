#pragma once
typedef void* SP02LIB;

namespace SP02 {
	SP02LIB Init();
	namespace Adder {
		double Add(SP02LIB h, double x, double y);
		double Sub(SP02LIB h, double x, double y);
	}
	namespace Multiplier {
		double Mul(SP02LIB h, double x, double y);
		double Div(SP02LIB h, double x, double y);
	}
	void Dispose(SP02LIB h);
}