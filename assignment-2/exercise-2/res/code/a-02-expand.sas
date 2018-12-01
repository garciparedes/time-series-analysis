proc expand data = EJ2.SEMANAL out = EJ2.SEMANAL4 from = week.6 to = week4.6 ;
  id DATE;
  convert TUBERSEM / observed = total;
run;
