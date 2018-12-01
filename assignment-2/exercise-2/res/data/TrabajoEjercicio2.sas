title1 'datos semanales de tuberculosis';
data semanal;
        input tubersem @@;
        date=intnx('week.6','01jan1982'd,_n_-1);
		format date weekdate.;
datalines;
106	132	119	147	160	168	166	160	172	190	167	175	197	108	160	148	202	176	195	155	210	149	192	187	136	148	151	152	125	151	111	124	136	99	143	146	118	129	170	118	152	156	167	165	195	145	160	159	166
161	133	104	113	145	177	191	227	189	159	242	224	202	231	234	115	162	191	215	178	186	170	177	136	245	180	185	164	139	160	165	118	154	120	157	105	133	140	166	151	127	175	137	162	157	184	199	201	217
213 184	233	195	148	109	189	193	171	243	218	259	231	195	209	228	232	243	171	187	234	161	156	172	233	179	216	207	180	190	172	177	219	204	175	168	154	148	149	187	163	133	178	202	237	182	183	243	195
192	186 166	250	216	193	225	156	128	134	222	208	215	178	212	241	169	225	258	170	226	202	162	186	255	193	216	169	229	243	160	211	233	232	204	180	230	219	208	149	151	139	144	131	170	180	172	185	176
252	184	275 325	243	326	266	235	274	204	243	135	153	256	267	258	341	264	310	299	236	312	273	284	206	301	187	320	278	248	281	301	316	291	272	292	323	289	270	303	305	226	207	205	182	205	166	165	263
238	294	189	293 323	264	297	257	248	249	233	224	331	197	176	163	208	215	271	234	239	262	260	260	216	177	258	251	199	186	191	193	238	207	222	245	196	197	173	170	189	185	155	193	153	160	162	165	139
150	131	145	176	143 147	113	164	146	145	125	166	169	161	140	120	119	76	153	204	176	202	184	253	192	211	194	214	195	167	181	207	223	225	178	176	186	210	176	150	235	162	156	196	151	165	163	126	141
125	119	155	119	149	121 148	150	136	109	134	129	151	150	164	120	132	96	155	106	102	84	160	159	195	169	158	202	204	190	165	164	126	174	200	211	177	182	159	198	190	209	149	193	152	196	139	156	134
167	192	119	131	128	139	131 111	131	110	138	149	126	136	162	124	168	155	151	126	81	150	147	90	129	109	149	147	180	165	200	164	183	174	190	151	169	163	136	153	164	135	185	166	149	156	167	174	167
171	187	151	150	138	136	108	112 134	98	112	104	148	170	129	109	138	140	116	148	138	117	184	118	133	113	84	77	121	135	120	138	122	128	171	156	155	185	124	76	150	159	166	137	127	160	153	139	156
187	185	165	165	152	143	158	149	123 104	78	149	108	148	128	132	128	137	135	114	129	109	102	111	122	108	116	133	149	97
;
run;


/*Construimos las serie con los casos de tuberculosis cada cuatro semanas en el fichero d*/
proc expand data=semanal out=sem4 from=week.6 to=week4.6 ; /* cada 4 los suma y pone la fecha correspondinte.*/
id date;
convert tubersem/ observed=total;
run;


/*a) utilizar archivo ondasejercicio2 o modificarlo con tendencia polinomica.*/



/*b*/

proc esm data=sem4 outfor=predicSEASONAL;
  id date interval = week4.6;
  forecast tubersem / model = SEASONAL;
run;

proc esm data=sem4 outfor=predicadd;
  id date interval = week4.6;
  forecast tubersem / model = ADDWINTERS;
run;


proc esm data=sem4 outfor=predicmult;
  id date interval = week4.6;
  forecast tubersem / model = WINTERS;
run;

/*c)*/

proc esm data=sem4 outfor=predic outest=test outstat=estad lead=6  PRINT=(all states)  PLOT=(errors wn forecasts ACF);
id date interval=week4.6;
forecast tubersem / model=WINTERS;
run;

/*d*/



DATA sem4reducido;
  set sem4;
  if _n_ < 119;
run;

proc esm data = sem4reducido outfor = seasonalssep lead = 12;
  id date interval = week4.6;
  forecast tubersem / model = SEASONAL;
run;

proc esm data = sem4reducido outfor = addssep lead = 12;
  id date interval = week4.6;
  forecast tubersem / model = ADDWINTERS;
run;


proc esm data = sem4reducido outfor = multseep lead = 12;
  id date interval = week4.6;
  forecast tubersem / model = WINTERS;
run;


data predicseasonal;
	set predicseasonal;
	keep predict;
  rename predict = seasonal;
run;

data predicadd;
  set predicadd;
  keep predict;
  rename predict = add;
run;

data predicmult;
  set predicmult;
  keep predict;
  rename predict = mult;
run;


data errores;
  merge sem4 predicseasonal predicadd predicmult;
  errorseasonal = tubersem - seasonal;
  erroradd = tubersem - add;
  errormult = tubersem - mult;
run;

DATA sumaerrores;
    SET errores;

    IF _N_ >= 119 THEN SSEseasonal + errorseasonal ** 2;
		IF _N_ >= 119 THEN SSEadd + erroradd ** 2;
		IF _N_ >= 119 THEN SSEmult + errormult ** 2;
RUN;

data SSEp;
  set sumaerrores;
  if _n_ = 130;
run;

PROC PRINT data=SSEp;
run;


/*e)*/

PROC FORECAST DATA=sem4reducido OUT=RESULfor outest=estad	interval=week4.6 /* Los que dan en el d)*/
    LEAD=12 OUTRESID ASTART=565.634875 BSTART=-1.26019420 METHOD=WINTERS
	SEASONS=13;
	id date;
	var tubersem;
RUN;




data predmultfor ; set resulfor;keep tubersem;rename tubersem=predictfor;
run;


data erroresfor; merge predmultfor sem4; error=tubersem-predictfor;
run;
DATA sumaerroresfor; SET erroresfor;
		IF _N_ >= 119 THEN SSE+error**2;

RUN;
data SSEp;set sumaerroresfor;if _n_=130;
PROC PRINT data=SSEp;
run;









/*f)*/

/* sas de ventanas con modelo multiplicativo( el mejor que encontremos) , predecir 6 y comparar con las predecidas en el c) con proc esm.*/
