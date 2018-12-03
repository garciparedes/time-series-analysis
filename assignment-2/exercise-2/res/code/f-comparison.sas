/*Comparacion*/

/* Individuales Prediccion (Apartado F)*/
proc print data = NUEVO;
run;

/*Suma Prediccion Cada 4 (ApartadoF) */
proc print data = SEM4F;
run;

/* Prediccion C cada 4 para comparar*/
proc print data = CPRED;
run;
