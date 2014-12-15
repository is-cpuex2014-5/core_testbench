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
	char aa[33],bb[33];
	bool c;
	const int32_t a = dist (mt);
	const int32_t b = dist (mt);

	for (int t = 0; t < 32;++t) {
	    aa[31 - t] = a & (1 << t) ? '1' : '0';
	    bb[31 - t] = b & (1 << t) ? '1' : '0';
	}
	aa[32] = '\0';
	bb[32] = '\0';

	c = a < b;

	printf("%s\t%s\t%d\n", aa,bb,c);
    }

    return 0;
}
