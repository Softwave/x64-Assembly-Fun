#include <iostream>

extern "C" unsigned long long DoubleSub(int doubleIn);
extern "C" unsigned long long SquareSub(int squareIn);
extern "C" unsigned long long FactorialSub(int fIn);
extern "C" unsigned long long SquareRootSub(int sRoot);

extern "C" unsigned long long FibonacciSub(int fibInput);

int main(void)
{
	int dIn = 23; 
	int factIn = 5; 
	std::cout << dIn << " doubled is: " << DoubleSub(dIn) << std::endl; 
	std::cout << dIn << " squared is: " << SquareSub(dIn) << std::endl;

	std::cout << factIn << " factorial is: " << FactorialSub(factIn) << std::endl; 

	int sqrRoot = 25; 
	std::cout << "The square root of " << sqrRoot << " is: " << SquareRootSub(sqrRoot) << std::endl; 

	int fibIn = 92;
	//

	for (int i = 1; i <= fibIn; i++)
	{
		std::cout << "Fibonacci number " << i << " is: " << FibonacciSub(i) << std::endl; 
	}

	return 0; 
}

