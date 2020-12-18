/*
 * CB_output.c
 *
 *  Created on: Aug 27, 2019
 *      Author: eldal
 */
#include "CB_output.h"

void CBO_set_pitch_and_roll_throttle(unsigned short pitch_throttle, unsigned short roll_throttle)
{
	com_bus_write(ADDRESS_THROTTLE_OUTPUT, (roll_throttle + 1070)*0x10000 + (pitch_throttle + 1070));
}
void CBO_set_pitch_and_roll_setpoints(short pitch_setpoint, short roll_setpoint)
{
	unsigned short roll, pitch;
	roll = (unsigned short) (roll_setpoint * 16);
	pitch = (unsigned short) (pitch_setpoint * 16);
	com_bus_write(ADDRESS_SETPOINTS_OUTPUT, (roll * 0x10000) + pitch);
	SC_setpoints_update();
}
void CBO_set_pitch_and_roll_setpoints_precise(short pitch_setpoint, short roll_setpoint)
{
	unsigned short roll, pitch;
	roll = (unsigned short) (roll_setpoint);
	pitch = (unsigned short) (pitch_setpoint);
	com_bus_write(ADDRESS_SETPOINTS_OUTPUT, (roll * 0x10000) + pitch);
	SC_setpoints_update();
}

void CBO_generic_output(unsigned short address, unsigned data)
{
	com_bus_write(address, data);
}
