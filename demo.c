while (n <= how_many) {

        total = 0;

        j = 1;


        while (j <= n) {

            i = 1;

            while (i <= j) {

                total = total + i;

                i = i + 1;

            }

            j = j + 1;

        }

        printf("%d\n", total);

        n = n + 1;

    }