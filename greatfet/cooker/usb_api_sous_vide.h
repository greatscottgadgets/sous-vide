/*
 * This file is part of GreatFET
 */

#ifndef __USB_API_SOUS_VIDE_H__
#define __USB_API_SOUS_VIDE_H__

#include <greatfet_core.h>
#include <usb_type.h>
#include <usb_request.h>

extern volatile bool sous_vide_mode_enabled;

void init(void);
void heating_up();
void cooking();
void done(void);
void turn_on_heater(void);
void turn_off_heater(void);
uint32_t get_start_time(void);
uint32_t get_time_elapsed();
void turn_leds_on(void);
void turn_leds_off(void);

void sous_vide_mode(void);

usb_request_status_t usb_vendor_request_sous_vide_start(
	usb_endpoint_t* const endpoint, const usb_transfer_stage_t stage);


#endif /*__USB_API_SOUS_VIDE_H__*/
