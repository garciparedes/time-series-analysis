proc forecast data = SEM4 OUT = RESULFOR outest = ESTAD weight = (0.55193, 0.001, 0.37214)
    interval = week4.6 LEAD = 13 OUTRESID start = 117 astart = 567.734169 bstart = -0.838957480
    method = WINTERS seasons = 13;
	var TUBERSEM;
run;

data ssepfore;
  set RESULfor;
  IF _TYPE_= 'RESIDUAL' AND (_N_ >= 118)
  THEN SUM2 + tubersem * tubersem;
run;

PROC PRINT data = ssepfore;
run;
