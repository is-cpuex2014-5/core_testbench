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
	int32_t a,c;
	char aa[33],cc[33];
	a = dist (mt);

	c = ~a;

	for (int t = 0; t < 32;++t) {
	    aa[31 - t] = a & (1 << t) ? '1' : '0';
	    cc[31 - t] = c & (1 << t) ? '1' : '0';
	}
	aa[32] = '\0';
	cc[32] = '\0';

	printf("%s\t%s\n", aa,cc);
    }

    return 0;
}












