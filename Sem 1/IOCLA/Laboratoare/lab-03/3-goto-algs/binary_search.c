#include <stdio.h>

void main(void)
{
	int v[] =  {1, 2, 15, 51, 53, 66, 202, 7000};
	int dest = v[2]; /* 15 */
	int start = 0;
	int end = sizeof(v) / sizeof(int) - 1;
	int mid = (start + end)/2;

	if(dest == v[mid])
		goto Good_Ending;

	if(dest < v[mid])
		goto BSL;

	goto BSH;

BSL:
	end = mid;
	mid = (end + start)/2;

	if(dest == v[mid])
		goto Good_Ending;

	if(start == end)
		goto Bad_Ending;

	if(dest < v[mid])
		goto BSL;

	goto BSH;

BSH:
	start = mid;
	mid = (end + start)/2;

	if(dest == v[mid])
		goto Good_Ending;

	if(start == end)
		goto Bad_Ending;

	if(dest < v[mid])
		goto BSL;

	goto BSH;

Good_Ending:
	printf("Numarul %d se afla pe pozitia %d in vector\n", dest, mid + 1);
	return;

Bad_Ending:
	printf("Numarul %d nu a fost gasit\n", dest);
	return;./
}
