/*
 * Copyright 2016 Dominic Spill <dominicgs@gmail.com>
 *
 * This file is part of GreatFET.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2, or (at your option)
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; see the file COPYING.  If not, write to
 * the Free Software Foundation, Inc., 51 Franklin Street,
 * Boston, MA 02110-1301, USA.
 */

#include "greatfet_core.h"
#include "greatfet_ui.h"
#include "gpio_lpc.h"
#include "pins.h"
#include <libopencm3/lpc43xx/scu.h>

// Constants from https://github.com/CaptainStouf/raspberry_lcd4x20_I2C
// Which is released under the GPL2 license

// LCD Address
#define ADDRESS 0x27

// commands
#define LCD_CLEARDISPLAY 0x01
#define LCD_RETURNHOME 0x02
#define LCD_ENTRYMODESET 0x04
#define LCD_DISPLAYCONTROL 0x08
#define LCD_CURSORSHIFT 0x10
#define LCD_FUNCTIONSET 0x20
#define LCD_SETCGRAMADDR 0x40
#define LCD_SETDDRAMADDR 0x80

// flags for display entry mode
#define LCD_ENTRYRIGHT 0x00
#define LCD_ENTRYLEFT 0x02
#define LCD_ENTRYSHIFTINCREMENT 0x01
#define LCD_ENTRYSHIFTDECREMENT 0x00

// flags for display on/off control
#define LCD_DISPLAYON 0x04
#define LCD_DISPLAYOFF 0x00
#define LCD_CURSORON 0x02
#define LCD_CURSOROFF 0x00
#define LCD_BLINKON 0x01
#define LCD_BLINKOFF 0x00

// flags for display/cursor shift
#define LCD_DISPLAYMOVE 0x08
#define LCD_CURSORMOVE 0x00
#define LCD_MOVERIGHT 0x04
#define LCD_MOVELEFT 0x00

// flags for function set
#define LCD_8BITMODE 0x10
#define LCD_4BITMODE 0x00
#define LCD_2LINE 0x08
#define LCD_1LINE 0x00
#define LCD_5x10DOTS 0x04
#define LCD_5x8DOTS 0x00

// flags for backlight control
#define LCD_BACKLIGHT 0x08
#define LCD_NOBACKLIGHT 0x00

#define En 0b00000100 // Enable bit
#define Rw 0b00000010 // Read/Write bit
#define Rs 0b00000001 // Register select bit

uint8_t backlight_state = LCD_NOBACKLIGHT;

static struct gpio_t gpio_lcd_d[] = {
	GPIO(1, 9),
	GPIO(1, 2),
	GPIO(1, 1),
	GPIO(2, 12),
	GPIO(1, 3),
	GPIO(1, 5),
	GPIO(1, 4),
	GPIO(2, 14)
};

static struct gpio_t gpio_lcd_rs = GPIO(1, 8);
static struct gpio_t gpio_lcd_rw = GPIO(2, 11);
static struct gpio_t gpio_lcd_en = GPIO(1, 0);

void write_bits(uint8_t byte, bool rs) {
	int i;
	for(i=0; i<8; i++) {
		if(byte&0x1) {
			gpio_set(&gpio_lcd_d[i]);
		} else {
			gpio_clear(&gpio_lcd_d[i]);
		}
		byte >>=1;
	}
	if(rs) {
		gpio_set(&gpio_lcd_rs);
	} else {
		gpio_clear(&gpio_lcd_rs);
	}
	gpio_set(&gpio_lcd_en);
	delay(102000);
	gpio_clear(&gpio_lcd_en);
	delay(20400);
}

void lcd_write(uint8_t byte) {
	write_bits(byte, false);
}

void lcd_write_char(uint8_t byte) {
	write_bits(byte, true);
}

void lcd_clear(void) {
	lcd_write(LCD_CLEARDISPLAY);
	lcd_write(LCD_RETURNHOME);
}

#define CHAR_0 48
static uint64_t temperature = 0;
static uint64_t cook_time = 0;
static bool temperature_changed = false;
static bool time_changed = false;

void draw_screen(void) {
	int group, j, i = 0;
	uint64_t y = temperature;
	char line1[] = {'D', ':', 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
	                0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20};
	char line2_rx[] = {'T', ':', 0x20, 0x20, 0x20, 'V', ':', 0x20,
	                0x20, 0x20, 'A', ':', 0x20, 0x20, 0x20, 0x20};
	char line2_tx[] = {'V', ':', 0x20, 0x20, 0x20, 'A', ':', 0x20,
	                0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20};
	// char freq_str[] = {0x20, 0x20, 0x20, 0x20, 0x20,
	//                    0x20, 0x20, 0x20, 0x20, 0x20};
	char temp_str[] = {0x20, 0x20, 0x20, 0x20, 0x20,
	                   0x20, 0x20, 0x20, 0x20, 0x20};
	char time_str[] = {0x20, 0x20, 0x20, 0x20, 0x20,
	                   0x20, 0x20, 0x20, 0x20, 0x20};
	if(temperature_changed) {
		// Temperature
		while(y) {
			temp_str[i++] = y % 10;
			y = y / 10;
		}
		group = i % 3;
		if(group == 0)
			group = 3;
		j = 2;
		while(i) {
			if(group) {
				line1[j++] = temp_str[--i] + CHAR_0;
				group--;
			} else {
				line1[j++] = ',';
				group = 3;
			}
		}
	}

	lcd_clear();
	lcd_write(0x80);
	for(i=0; i<16; i++) {
		lcd_write_char(line1[i]);
	}
	lcd_write(0xC0);
	
		for(i=0; i<16; i++) {
			lcd_write_char(line2_rx[i]);
		}

}

void greatfet_ui_init(void) {
	int i;
	scu_pinmux(SCU_PINMUX_GPIO1_8, SCU_GPIO_PDN | SCU_CONF_FUNCTION0);
	scu_pinmux(SCU_PINMUX_GPIO2_11, SCU_GPIO_PDN | SCU_CONF_FUNCTION0);
	scu_pinmux(SCU_PINMUX_GPIO1_0, SCU_GPIO_PDN | SCU_CONF_FUNCTION0);
	
	scu_pinmux(SCU_PINMUX_GPIO1_9, SCU_GPIO_PDN | SCU_CONF_FUNCTION0);
	scu_pinmux(SCU_PINMUX_GPIO1_2, SCU_GPIO_PDN | SCU_CONF_FUNCTION0);
	scu_pinmux(SCU_PINMUX_GPIO1_1, SCU_GPIO_PDN | SCU_CONF_FUNCTION0);
	scu_pinmux(SCU_PINMUX_GPIO2_12, SCU_GPIO_PDN | SCU_CONF_FUNCTION0);
	scu_pinmux(SCU_PINMUX_GPIO1_3, SCU_GPIO_PDN | SCU_CONF_FUNCTION0);
	scu_pinmux(SCU_PINMUX_GPIO1_5, SCU_GPIO_PDN | SCU_CONF_FUNCTION0);
	scu_pinmux(SCU_PINMUX_GPIO1_4, SCU_GPIO_PDN | SCU_CONF_FUNCTION0);
	scu_pinmux(SCU_PINMUX_GPIO2_14, SCU_GPIO_PDN | SCU_CONF_FUNCTION0);

	for(i=0; i<8; i++) {
		gpio_output(&gpio_lcd_d[i]);
		gpio_clear(&gpio_lcd_d[i]);
	}

	gpio_output(&gpio_lcd_rs);
	gpio_output(&gpio_lcd_rw);
	gpio_output(&gpio_lcd_en);

	gpio_clear(&gpio_lcd_rs);
	gpio_clear(&gpio_lcd_rw);
	gpio_clear(&gpio_lcd_en);
	const uint8_t data[] = {
		LCD_FUNCTIONSET | LCD_2LINE | LCD_5x8DOTS | LCD_8BITMODE,
		LCD_DISPLAYCONTROL | LCD_DISPLAYON | LCD_BLINKON,
		LCD_CLEARDISPLAY,
		LCD_ENTRYMODESET | LCD_ENTRYLEFT
	};
	for(i=0; i<4; i++)
		lcd_write(data[i]);

	lcd_clear();
	draw_screen();
}

void greatfet_ui_setTemperature(uint64_t _temp) {
	temperature = _temp;
	temperature_changed = true;
	draw_screen();
}

void greatfet_ui_setTime(uint64_t _time) {
	cook_time = _time;
	time_changed = true;
	draw_screen();
}
