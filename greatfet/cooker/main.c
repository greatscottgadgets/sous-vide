/*
 * This file is part of GreatFET
 */

#include <stddef.h>

#include <libopencm3/cm3/vector.h>
#include <libopencm3/lpc43xx/m4/nvic.h>

#include <greatfet_core.h>

#include <one_wire.h>

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

int main(void) {
	cpu_clock_init();
	cpu_clock_pll1_max_speed();
	pin_setup();
	rtc_init();

	while(true) {
		;
	}

	return 0;
}
