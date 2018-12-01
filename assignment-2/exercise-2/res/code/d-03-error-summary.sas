data errores;
  merge sem4 predicseasonal predicadd predicmult;
  errorseasonal = tubersem - seasonal;
  erroradd = tubersem - add;
  errormult = tubersem - mult;
run;

data sumaerrores;
    set errores;
    if _N_ >= 118 then SSEseasonal + errorseasonal ** 2;
    if _N_ >= 118 then SSEadd + erroradd ** 2;
    if _N_ >= 118 then SSEmult + errormult ** 2;
run;

data SSEpd;
  set sumaerrores;
  if _n_ = 130;
run;

proc print data = SSEpd;
run;
