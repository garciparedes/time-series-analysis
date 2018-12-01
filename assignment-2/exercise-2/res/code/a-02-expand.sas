proc expand data=ej2.semanal out=ej2.semanal4 from=week.6 to=week4.6 ;
  id date;
  convert tubersem/ observed=total;
run;
