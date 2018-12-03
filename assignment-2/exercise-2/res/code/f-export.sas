/* WORK._F1 es el dataset generado de predicciones para el modelo de winter multiplicativo*/
data NUEVO;
	set WORK._F1;
	if _n_ > 520;
run;

proc print data = NUEVO;
run;
