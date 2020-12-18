/*
 * PID.c
 *
 *  Created on: Oct 7, 2019
 *      Author: eldal
 */
#include "PID.h"

void PID_set_gains(short gainP, short gainI, short gainD)
{
	unsigned complete_address_roll, complete_address_pitch;
	complete_address_roll = ADDRESS_ROLL_PID + 0x100;
	complete_address_pitch = ADDRESS_PITCH_PID + 0x100;
	unsigned short data;
	data = (unsigned short) gainP;
	com_bus_write(complete_address_roll, data);
	com_bus_write(complete_address_pitch, data);
	complete_address_roll += 0x100;
	complete_address_pitch += 0x100;
	data = (unsigned short) gainI;
	com_bus_write(complete_address_roll, data);
	com_bus_write(complete_address_pitch, data);
	complete_address_roll += 0x100;
	complete_address_pitch += 0x100;
	data = (unsigned short) gainD;
	com_bus_write(complete_address_roll, data);
	com_bus_write(complete_address_pitch, data);
	complete_address_roll += 0x100;
	complete_address_pitch += 0x100;
}
void PID_set_integral_limit(signed max, signed min)
{
	unsigned complete_address_roll, complete_address_pitch;
	complete_address_roll = ADDRESS_ROLL_PID + 0x400;
	complete_address_pitch = ADDRESS_PITCH_PID + 0x400;
	unsigned data = (unsigned) max;
	com_bus_write(complete_address_roll, data);
	com_bus_write(complete_address_pitch, data);
	complete_address_roll = ADDRESS_ROLL_PID + 0x500;
	complete_address_pitch = ADDRESS_PITCH_PID + 0x500;
	data = (unsigned) min;
	com_bus_write(complete_address_roll, data);
	com_bus_write(complete_address_pitch, data);
}
void PID_print_internal_values()
{
	unsigned setpoint, value, error, D, run_i, output;
	setpoint = com_bus_read(ADDRESS_ROLL_PID + 0x100);
	value = com_bus_read(ADDRESS_ROLL_PID + 0x200);
	error = com_bus_read(ADDRESS_ROLL_PID + 0x300);
	D = com_bus_read(ADDRESS_ROLL_PID + 0x400);
	run_i = com_bus_read(ADDRESS_ROLL_PID + 0x500);
	output = com_bus_read(ADDRESS_ROLL_PID + 0x600);
	//printf("ROLL : Setpoint: %04i, system value: %04i, error: %04i, D: %04i, running I: %04i, output: %04i\n",setpoint,
	//		value, error, D, run_i, output);
	setpoint = com_bus_read(ADDRESS_PITCH_PID + 0x100);
	value = com_bus_read(ADDRESS_PITCH_PID + 0x200);
	error = com_bus_read(ADDRESS_PITCH_PID + 0x300);
	D = com_bus_read(ADDRESS_PITCH_PID + 0x400);
	run_i = com_bus_read(ADDRESS_PITCH_PID + 0x500);
	output = com_bus_read(ADDRESS_PITCH_PID + 0x600);
	printf("PITCH: Setpoint: %04i, system value: %04i, error: %04i, D: %04i, running I: %08i, output: %04i\n",setpoint,
			value, error, D, run_i, output);
}
