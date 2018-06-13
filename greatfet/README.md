# State LED Indicators

a) 1, 2	ON	- in init state, moving to heating up or done state

b) 1 	ON 	- in heating_up state, timer not started

c) 1, 3	ON 	- in heating_up state, timer started

d) 2, 3	ON 	- in heating_up state, cook completed, moving to done state

e) 2 	ON 	- in cooking state, temp is above min threshold, cook is not complete

f) 2, 4	ON 	- in cooking state, cook is complete, moving to done state

g) ALL 	ON 	- in done state, waiting for reset in init

Without delays, states a), d), and f) will not be visible as they indicate a transition between states.
