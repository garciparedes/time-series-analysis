proc esm data = EJ2.SEMANAL4 outfor = PREDICT lead = 6;
	id DATE interval = WEEK4.6;
	forecast TURBERSEM / model = WINTERS;
run;
