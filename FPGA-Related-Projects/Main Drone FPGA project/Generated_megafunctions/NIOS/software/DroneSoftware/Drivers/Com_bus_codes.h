/*
 * Com_bus_codes.h
 *
 *  Created on: 27 Jun 2019
 *      Author: Jan Mart
 */

#ifndef COM_BUS_CODES_H_
#define COM_BUS_CODES_H_

/*
 * Addresses:
 */

#define ADDRESS_LED_OUTPUT 0x01
#define ADDRESS_GYRO 0x02
#define ADDRESS_ICM 0x02
#define ADDRESS_SYSTEM_CONTROL_AND_FLAGS 0x03
#define ADDRESS_BNO055 0x04
#define ADDRESS_ROLL_PID 0x05
#define ADDRESS_PITCH_PID 0x06
#define ADDRESS_PULSE_COUNTER 0x07

#define ADDRESS_SETPOINTS_OUTPUT 0xF0
#define ADDRESS_THROTTLE_OUTPUT 0xF1
#define ADDRESS_FIR_GYRO_X 0xF2
#define ADDRESS_FIR_GYRO_Y 0xF3
#define ADDRESS_SLEW_LIMIT 0xF4

#endif /* COM_BUS_CODES_H_ */
