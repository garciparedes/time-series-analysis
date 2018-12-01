PROC FORECAST DATA = sem4reducido OUT = RESULfor outest = estad weight = (0.55193, 0.001, 0.37214)
  interval = week4.6 LEAD = 13 OUTRESID ASTART = 567.734169 BSTART = -0.838957480 NSSTART = 2
  METHOD=WINTERS SEASONS=13;
	var tubersem;
run;

data predmultfor;
  set resulfor;
  keep tubersem;
  rename tubersem=predictfor;
run;

data erroresfor;
  merge predmultfor sem4;
  error = tubersem - predictfor;
run;

DATA sumaerroresfor; SET erroresfor;
		IF _N_ >= 118 THEN SSE+error**2;
RUN;

data SSEpfor;
  set sumaerroresfor;
  if _n_=130;
run;

PROC PRINT data=SSEpfor;
run;
