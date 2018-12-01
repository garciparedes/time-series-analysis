proc esm data = EJ2.SEMANAL4 plot = (errors wn forecasts ACF) print = (all states);
  id DATE interval = WEEK4.6;
  forecast TUBERSEM / model = SEASONAL;
run;
