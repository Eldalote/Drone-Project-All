/*
 * CB_output.h
 *
 *  Created on: Aug 27, 2019
 *      Author: eldal
 */

#ifndef DRIVERS_CB_OUTPUT_H_
#define DRIVERS_CB_OUTPUT_H_

#include "Com_bus.h"
#include "System_control_and_flags.h"



void CBO_set_pitch_and_roll_throttle(unsigned short pitch_throttle, unsigned short roll_throttle);
void CBO_set_pitch_and_roll_setpoints(short pitch_setpoint, short roll_setpoint);
void CBO_set_pitch_and_roll_setpoints_precise(short pitch_setpoint, short roll_setpoint);
void CBO_generic_output(unsigned short address, unsigned data);

#endif /* DRIVERS_CB_OUTPUT_H_ */
