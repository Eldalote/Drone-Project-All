/*
 * System_control_and_flags.c
 *
 *  Created on: Aug 27, 2019
 *      Author: eldal
 */

#include "System_control_and_flags.h"

unsigned Get_system_flags()
{
	return com_bus_read(ADDRESS_SYSTEM_CONTROL_AND_FLAGS);
}
void Set_control_bit(unsigned bit)
{
	if(bit < 32)
	{
		com_bus_write((ADDRESS_SYSTEM_CONTROL_AND_FLAGS + CONTROL_SET_CODE), bit);
	}
}
void Clear_control_bit(unsigned bit)
{
	if(bit < 32)
	{
		com_bus_write(ADDRESS_SYSTEM_CONTROL_AND_FLAGS, bit);
	}
}
void Power_supply_on()
{
	Set_control_bit(POWER_SUPPLY_BIT);
}
void Power_supply_off()
{
	Clear_control_bit(POWER_SUPPLY_BIT);
}
void SC_setpoints_update()
{
	Set_control_bit(SETPOINT_UPDATE_BIT);
	Clear_control_bit(SETPOINT_UPDATE_BIT);
}
void SC_use_calibration()
{
	Set_control_bit(USE_CALIBRATION_BIT);
}
void SC_dont_use_calibration()
{
	Clear_control_bit(USE_CALIBRATION_BIT);
}
