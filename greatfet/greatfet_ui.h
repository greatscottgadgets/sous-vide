#ifndef GREATFET_UI_H
#define GREATFET_UI_H

#include <stdint.h>

void greatfet_ui_init(void);

void greatfet_ui_setTemperature(uint32_t _temp);
void greatfet_ui_setTime(uint32_t _time);
#endif /* GREATFET_UI_H */
