#include <cstdio>
#include <random>
#include <cstdint>

using namespace std;


int main(void)
{
  for (uint32_t i = 0 ; i < UINT32_MAX; i++) 
    {
      for (int j = 0; j < 32; j++) 
	{
	  uint32_t a,b,c;
	  a = i;
	  b = j;
	  c = a << j;
	  
	  printf("%08x\t%08x\t%08x\t%s\t%s\n", a,b,c,"0","01");	
	}
    }

    return 0;
}


