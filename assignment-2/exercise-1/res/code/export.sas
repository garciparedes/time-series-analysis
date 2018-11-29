PROC EXPORT DATA= EJ1.espectadores 
            OUTFILE= "F:\trabajo2\ejercicio1\data\espectadores.csv" 
            DBMS=CSV REPLACE;
     PUTNAMES=YES;
RUN;


PROC EXPORT DATA= EJ1.indicesparams 
            OUTFILE= "F:\trabajo2\ejercicio1\data\indicesparams.csv" 
            DBMS=CSV REPLACE;
     PUTNAMES=YES;
RUN;


PROC EXPORT DATA= EJ1.indicespredict 
            OUTFILE= "F:\trabajo2\ejercicio1\data\indicespredic.csv" 
            DBMS=CSV REPLACE;
     PUTNAMES=YES;
RUN;


PROC EXPORT DATA= EJ1.ondas
            OUTFILE= "F:\trabajo2\ejercicio1\data\ondas.csv" 
            DBMS=CSV REPLACE;
     PUTNAMES=YES;
RUN;


PROC EXPORT DATA= EJ1.ondascompletasparams
            OUTFILE= "F:\trabajo2\ejercicio1\data\ondascompletasparams.csv" 
            DBMS=CSV REPLACE;
     PUTNAMES=YES;
RUN;


PROC EXPORT DATA= EJ1.ondascompletaspredict
            OUTFILE= "F:\trabajo2\ejercicio1\data\ondascompletaspredict.csv" 
            DBMS=CSV REPLACE;
     PUTNAMES=YES;
RUN;

PROC EXPORT DATA= EJ1.ondassignificativasparams
            OUTFILE= "F:\trabajo2\ejercicio1\data\ondassignificativasparams.csv" 
            DBMS=CSV REPLACE;
     PUTNAMES=YES;
RUN;


PROC EXPORT DATA= EJ1.ondassignificativaspredict
            OUTFILE= "F:\trabajo2\ejercicio1\data\ondassignificativaspredict.csv" 
            DBMS=CSV REPLACE;
     PUTNAMES=YES;
RUN;

