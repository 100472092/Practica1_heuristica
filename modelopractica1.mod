#
# Giapetto's problem
#
# This finds the optimal solution for maximizing Giapetto's profit
#

/* set of toys */
set PARKING;
set DISTRITO;
/* parameters */
param Tiempo_parking_distrito {i in PARKING}{j in DISTRITO};
param Total_llamadas_distrito {j in DISTRITO};
param max_horas_parking 
/* decision variables */
var llamadas_parking {i in PARKING}{j in DISTRITO} >=0; 

/* objective function */
minimize: sum{i in TOY} sum{j in DISTRITO} Tiempo_parking_distrito[i][j]*llamadas_parking[i][j];

/* Constraints */
s.t. Llamadas : sum{i in DISTRITO} llamadas_parking[i] <= 10000;
s.t. Tiempo_distrito: sum{i in PARKING} sum {j in DISTRITO} llamadas_parking[i][j] = Total_llamadas_distrito[j];
s.t. max_llamadas {i in PARKING}{j in DISTRITO}: llamadas_parking[i][j] * (max_horas_parking - Tiempo_parking_distrito[i][j]) >= 0;
s.t. no_supera_50%_del_resto {i in PARKING}: sum {j in DISTRITO} llamadas_parking[i][j] <= 1.5 * sum{j in DISTRITO} * llamadas_parking[i][j];

end;
