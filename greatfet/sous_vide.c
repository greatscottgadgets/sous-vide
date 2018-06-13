/*
 * This file is part of GreatFET
 */


#include <libopencm3/lpc43xx/rtc.h>
#include <libopencm3/lpc43xx/scu.h>

#include <greatfet_core.h>
#include <gpio.h>
#include <gpio_lpc.h>
#include <pins.h>
#include <one_wire.h>

#include "greatfet_ui.h"

// GPIO 2_2 is J2_P8 on greatfet
static struct gpio_t heaters = GPIO(2, 2);
volatile bool sous_vide_mode_enabled = true;

#define MIN_TEMPERATURE 79
#define MAX_TEMPERATURE 90
#define COOK_TIME 3600
#define NOW_SEC ((RTC_HRS * 3600) + (RTC_MIN * 60) + RTC_SEC)
#define DELAY_TIME 40000000

static uint32_t start_time = 0;		
static uint32_t time_elapsed = 0;	
static uint64_t current_temperature = 0;
static uint64_t target_temperature = 85;
static bool timer_started = false;
static bool cook_completed = false;

int16_t read_temperature(void)
{
	int i;
	uint8_t data[9];
	one_wire_init_target();
    one_wire_write(0xCC); // Skip ROM command
    one_wire_write(0x44); // Read temperature
	delay(22500000); // 750 ms for 12 bit temperature conversion
	one_wire_init_target();
    one_wire_write(0xCC); // Skip ROM command
    one_wire_write(0xBE); // Read scratchpad area
	delay(1000);
	for(i=0; i<9; i++) {
		// scratchpad is 9 bytes
		data[i] = one_wire_read();
	}
	one_wire_init_target();
	return data[1] << 8 | data[0];
}

void turn_leds_on(void) {
	led_on(LED1);
	led_on(LED2);
	led_on(LED3);
	led_on(LED4);
}

void turn_leds_off(void) {
	led_off(LED1);
	led_off(LED2);
	led_off(LED3);
	led_off(LED4);
}

void turn_on_heater(void) {
	gpio_write(&heaters, 1);
}

void turn_off_heater(void) {
	gpio_write(&heaters, 0);
}

uint32_t get_start_time(void) {
	return NOW_SEC;
}

uint32_t get_time_elapsed(void) {
	uint32_t current_time = NOW_SEC;
	uint32_t time_elapsed = current_time - start_time;

	return time_elapsed;
}

void done(void) {
	cook_completed = true;
	turn_leds_on();
}

void cooking(void);

void heating_up(void) {
	turn_leds_off();
	turn_on_heater();
	led_on(LED1);

	while(current_temperature < target_temperature && time_elapsed < COOK_TIME) {
		current_temperature = read_temperature();
		current_temperature >>= 4;
		greatfet_ui_setTemperature(current_temperature);

		if(timer_started) {
			turn_leds_off();
			led_on(LED1);
			led_on(LED3);
			// delay(DELAY_TIME);
			time_elapsed = get_time_elapsed();	
		}
		delay(DELAY_TIME);
	}
	if(!timer_started) {
		turn_leds_off();
		start_time = get_start_time();
		timer_started = true;
		target_temperature = 81;	// heat up to 85 initially, 81 for the rest of the cook
		turn_off_heater();
		cooking();
	}
	else if(timer_started && time_elapsed < COOK_TIME) {
		turn_leds_off();
		time_elapsed = get_time_elapsed();
		turn_off_heater();
		cooking();
	}
	else if(timer_started && time_elapsed >= COOK_TIME) {
		turn_leds_off();
		led_on(LED2);
		led_on(LED3);
		turn_off_heater();
		// delay(DELAY_TIME);
		done();
	}
}

void cooking(void) {
	turn_leds_off();
	led_on(LED2);

	while(current_temperature > MIN_TEMPERATURE && time_elapsed < COOK_TIME) {
		time_elapsed = get_time_elapsed();
		current_temperature = read_temperature();
		current_temperature >>= 4;
		greatfet_ui_setTemperature(current_temperature);
		// delay(DELAY_TIME);
	}
	if(time_elapsed >= COOK_TIME) {
		turn_leds_off();
		led_on(LED2);
		led_on(LED4);
		// delay(DELAY_TIME);
		done();
	}
	else if(current_temperature <= MIN_TEMPERATURE) {
		heating_up();
	}
}

void init_cook(void) {
	scu_pinmux(SCU_PINMUX_GPIO2_2, SCU_GPIO_FAST | SCU_CONF_FUNCTION0);
	gpio_output(&heaters); 
	turn_leds_off();
	greatfet_ui_init();

	led_on(LED1);
	led_on(LED2);
	// delay(DELAY_TIME);

	if(!cook_completed) {
		heating_up();
	}
	else {
		done();
	}
}

/* Start the creme brulee cook process
   This is called from the main loop. */
void sous_vide_mode(void) {
	init_cook();
}

