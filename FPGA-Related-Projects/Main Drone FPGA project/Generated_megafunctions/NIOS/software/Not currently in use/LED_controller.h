/*
 * LED_controller.h
 *
 *  Created on: 3 Jul 2019
 *      Author: Jan Mart
 */


#ifndef DRIVERS_LED_CONTROLLER_H_
#define DRIVERS_LED_CONTROLLER_H_

#include "Com_bus.h"


void LED_clear_all();
void LED_set_all();
unsigned char LED_set(unsigned LED_mask );
unsigned char LED_read();




#endif /* DRIVERS_LED_CONTROLLER_H_ */
