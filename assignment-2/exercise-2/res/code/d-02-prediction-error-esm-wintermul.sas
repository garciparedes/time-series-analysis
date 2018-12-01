proc esm data = sem4reducido outfor = predmul lead = 13
    plot = (errors wn forecasts ACF) print = (all states);
  id date interval = week4.6;
  forecast tubersem / model = WINTERS;
run;

data predicmult;
  set predmul;
  keep predict;
  rename predict = mult;
run;
