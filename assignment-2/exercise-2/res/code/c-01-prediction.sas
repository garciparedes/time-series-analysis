/* TODO: Realizar predicciones de 6 observaciones siguientes. */
proc esm data=<input-data-set> out=<output-data-set>;
  id <time-ID-variable> interval=<frequency>;
  forecast <time-series-variables>;
run;
