#include<iostream>
#pragma comment(lib, "D:/Sem31/NetProgramming/Labs/lab2/SP02_COM/x64/Debug/SP02_LIB.lib")
#include "../SP02_LIB/SP02_LIB.h"

void main() {
	try {
		SP02LIB h1 = SP02::Init();
		SP02LIB h2 = SP02::Init();

		std::cout << "SP02::Adder::Add(h1, 2, 3) = " << SP02::Adder::Add(h1, 2, 3) << "\n";
		std::cout << "SP02::Adder::Add(h2, 2, 3) = " << SP02::Adder::Add(h2, 2, 3) << "\n";

		std::cout << "SP02::Adder::Sub(h1, 2, 3) = " << SP02::Adder::Sub(h1, 2, 3) << "\n";
		std::cout << "SP02::Adder::Sub(h2, 2, 3) = " << SP02::Adder::Sub(h2, 2, 3) << "\n";

		std::cout << "SP02::Multiplier::Mul(h1, 2, 3) = " << SP02::Multiplier::Mul(h1, 2, 3) << "\n";
		std::cout << "SP02::Multiplier::Mul(h2, 2, 3) = " << SP02::Multiplier::Mul(h2, 2, 3) << "\n";

		std::cout << "SP02::Multiplier::Div(h1, 2, 3) = " << SP02::Multiplier::Div(h1, 2, 3) << "\n";
		std::cout << "SP02::Multiplier::Div(h2, 2, 3) = " << SP02::Multiplier::Div(h2, 2, 3) << "\n";

		SP02::Dispose(h1);
		SP02::Dispose(h2);
	}
	catch (int e) {
		std::cout << "SP02: error = " <<e << std::endl;
	}
}