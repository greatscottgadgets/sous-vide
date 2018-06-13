#ifndef GREATFET_UI_H
#define GREATFET_UI_H

#include <rf_path.h>
#include <stdint.h>

void greatfet_ui_init(void) __attribute__((weak));

void greatfet_ui_setTemperature(uint64_t _temp) __attribute__((weak));
void greatfet_ui_setTime(uint64_t _time) __attribute__((weak));
#endif /* GREATFET_UI_H */