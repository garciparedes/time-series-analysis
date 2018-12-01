proc esm data = sem4reducido outfor = predsea lead = 13;
  id date interval = week4.6;
  forecast tubersem / model = SEASONAL;
run;

data predicseasonal;
	set predsea;
	keep predict;
  rename predict = seasonal;
run;
