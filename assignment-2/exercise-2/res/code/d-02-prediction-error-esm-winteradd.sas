proc esm data = sem4reducido outfor = predadd lead = 13;
  id date interval = week4.6;
  forecast tubersem / model = ADDWINTERS;
run;

data predicadd;
  set predadd;
  keep predict;
  rename predict = add;
run;
