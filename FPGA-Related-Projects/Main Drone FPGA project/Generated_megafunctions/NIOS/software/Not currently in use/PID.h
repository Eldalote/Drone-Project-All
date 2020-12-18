/*
 * PID.h
 *
 *  Created on: Oct 7, 2019
 *      Author: eldal
 */

#ifndef DRIVERS_PID_H_
#define DRIVERS_PID_H_

#include "com_bus.h"



void PID_set_gains(short gainP, short gainI, short gainD);
void PID_set_integral_limit(signed max, signed min);
void PID_print_internal_values();

#endif /* DRIVERS_PID_H_ */
