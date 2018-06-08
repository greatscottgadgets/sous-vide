# State LED Indicators

1. 1, 2	ON	- in init state, moving to heating up or done state

2. 1 	ON 	- in heating_up state, timer not started

3. 1, 3	ON 	- in heating_up state, timer started

4. 2, 3	ON 	- in heating_up state, cook completed, moving to done state

5. 2 	ON 	- in cooking state, temp is above min threshold, cook is not complete

6. 2, 4	ON 	- in cooking state, cook is complete, moving to done state

7. ALL 	ON 	- in done state, waiting for reset in init

Without delays, states 1, 4, and 6 will not be visible as they indicate a transition between states.