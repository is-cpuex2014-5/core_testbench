#include <cstdio>
#include <random>
#include <cstdint>

using namespace std;

const size_t TEST_NUM = 10000000;

int main(void)
{
    random_device seed;
    mt19937 mt (seed());
    uniform_int_distribution<int> dist (INT32_MIN,INT32_MAX);
    for (size_t i = 0; i < TEST_NUM; i++) {
	int32_t a,b;
	bool c;
	a = dist (mt);
	if (i & 1) {
	    b = a;
	} else {
	    b = dist (mt);
	}

	c = a == b;

	printf("%08x\t%08x\t%d\n", a,b,c);
    }

    return 0;
}












