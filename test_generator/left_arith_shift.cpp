#include <cstdio>
#include <random>
#include <cstdint>

using namespace std;


int main(void)
{
  for (int32_t i = INT32_MIN ; i < INT32_MAX; i++) 
    {
      for (int j = 0; j < 32; j++) 
	{
	  int32_t a,b,c;
	  a = i;
	  b = j;
	  c = a << j;

	  printf("%08x\t%08x\t%08x\t%s\t%s\n", a,b,c,"0","00");	
	}
    }


    return 0;
}


