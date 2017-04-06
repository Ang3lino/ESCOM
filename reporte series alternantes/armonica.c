#include <stdio.h>
#include <math.h>

/* Serie armonica */
int
main (void){
    int i = 0;
    float acum = 0;
    char aux[20];

    printf ("n: ");
    fgets (aux, 20, stdin);
    sscanf (aux, "%d", &n);
    for (i = 1; i < n; i++){
        acum += (1 / n) * pow (-1, n + 1);
    }

    printf ("el resultado %d es: ", n, acum);


    return 0;
}

