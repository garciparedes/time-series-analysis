data trabajo1.espectadoresondas;
	set trabajo1.espectadores;

	t = _n_;

	/*
	t2 = t * t;
	*/
	sin1 = sin((2 * constant('pi') * 1 / 12) * t);
	cos1 = cos((2 * constant('pi') * 1 / 12) * t);

	sin2 = sin((2 * constant('pi') * 2 / 12) * t);
	cos2 = cos((2 * constant('pi') * 2 / 12) * t);

	sin3 = sin((2 * constant('pi') * 3 / 12) * t);
	cos3 = cos((2 * constant('pi') * 3 / 12) * t);

	sin4 = sin((2 * constant('pi') * 4 / 12) * t);
	cos4 = cos((2 * constant('pi') * 4 / 12) * t);

	sin5 = sin((2 * constant('pi') * 5 / 12) * t);
	cos5 = cos((2 * constant('pi') * 5 / 12) * t);

	/* 
	Siempre es cero.
	sin6 = sin((2 * constant('pi') * 6 / 12) * t);
	*/
	cos6 = cos((2 * constant('pi') * 6 / 12) * t);

run;
