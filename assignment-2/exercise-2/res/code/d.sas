data sem4reducido;
  set sem4;
  if _n_ < 118;
run;

proc esm data = sem4reducido outfor = predsea lead = 13;
  id date interval = week4.6;
  forecast tubersem / model = SEASONAL;
run;

proc esm data = sem4reducido outfor = predadd lead = 13;
  id date interval = week4.6;
  forecast tubersem / model = ADDWINTERS;
run;

proc esm data = sem4reducido outfor = predmul lead = 13
    plot = (errors wn forecasts ACF) print = (all states);
  id date interval = week4.6;
  forecast tubersem / model = WINTERS;
run;

data predicseasonal;
	set predsea;
	keep predict;
  rename predict = seasonal;
run;

data predicadd;
  set predadd;
  keep predict;
  rename predict = add;
run;

data predicmult;
  set predmul;
  keep predict;
  rename predict = mult;
run;

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
