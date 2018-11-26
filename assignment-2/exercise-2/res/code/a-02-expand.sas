/* TODO: Crear serie Y_t. */
proc expand data=monthly out=annual from=month to=year;
  convert x y z / method=aggregate;
  convert a b c / method=aggregate observed=total;
  id date;
run;
