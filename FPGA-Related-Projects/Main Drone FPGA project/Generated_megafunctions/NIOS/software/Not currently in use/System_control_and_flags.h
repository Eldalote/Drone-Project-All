/*
 * System_control_and_flags.h
 *
 *  Created on: Aug 27, 2019
 *      Author: eldal
 */

#ifndef DRIVERS_SYSTEM_CONTROL_AND_FLAGS_H_
#define DRIVERS_SYSTEM_CONTROL_AND_FLAGS_H_

#include "Com_bus.h"

#define CONTROL_SET_CODE 0x4000

#define POWER_SUPPLY_BIT 0
#define SETPOINT_UPDATE_BIT 1
#define USE_CALIBRATION_BIT 2

unsigned Get_system_flags();
void Set_control_bit(unsigned bit);
void Clear_control_bit(unsigned bit);
void Power_supply_on();
void Power_supply_off();
void SC_setpoints_update();
void SC_use_calibration();
void SC_dont_use_calibration();



#endif /* DRIVERS_SYSTEM_CONTROL_AND_FLAGS_H_ */
