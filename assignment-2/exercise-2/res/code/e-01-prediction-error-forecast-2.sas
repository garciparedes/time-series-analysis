/* TODO: Calcular SSE_p con proc forecast para modelo 2. */
proc forecast data=past interval=month lead=10 out=pred;
   var sales;
   id date;
run;
