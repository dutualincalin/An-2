#include<stdint.h>
#include<stdio.h>
#include<sys/time.h>

#define N (100 * 1000 * 1000)
intmax_t a;

void doSomething(int i)
{
    a += i;
}

void doSomethingElse(int i)
{
    a += i + 2;
}

void doYetSomethingElse(int i)
{
    a += i * 3 + 2;
}

int main()
{
    int i;
    int var;
    long elapsed;
    struct timeval t0, t1;

    printf("Insert an integer:\n");
    scanf("%d", &var);

    gettimeofday(&t0, NULL);
    for (i = 0; i < N; i++)
    {
        if (var % 2 == 0)
            doSomething(i);
        else if (var % 3 == 0)
            doSomethingElse(i);
        else
            doYetSomethingElse(i);
    }
    gettimeofday(&t1, NULL);

    elapsed = (t1.tv_sec - t0.tv_sec)*1000000 + t1.tv_usec - t0.tv_usec;
    printf("[Non-optimized] Computed: %jd in: %ld us\n", a, elapsed);

    a = 0;
    gettimeofday(&t0, NULL);

    for (i = 0; i < N; i = i + 4)
    {
        if (var % 2 == 0){
            doSomething(i);
            doSomething(i + 1);
            doSomething(i + 2);
            doSomething(i + 3);
        }

        else if (var % 3 == 0){
            doSomethingElse(i);
            doSomethingElse(i + 1);
            doSomethingElse(i + 2);
            doSomethingElse(i + 3);
        }

        else{
            doYetSomethingElse(i);
            doYetSomethingElse(i + 1);
            doYetSomethingElse(i + 2);
            doYetSomethingElse(i + 3);
        }

    }

    gettimeofday(&t1, NULL);

    elapsed = (t1.tv_sec - t0.tv_sec)*1000000 + t1.tv_usec - t0.tv_usec;
    printf("[Optimized] Computed: %jd in: %ld us\n", a, elapsed);

    return 0;
}
