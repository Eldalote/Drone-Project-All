/*
 * FIR.c
 *
 *  Created on: Oct 11, 2019
 *      Author: eldal
 */
#include "FIR.h"

void FIR_write_taps_coefficients_gyro()
{
	for(int i = 0; i < FILTER_TAP_NUM; i++)
	{
		com_bus_write(ADDRESS_FIR_GYRO_X + (i *0x100), filter_taps_gyro[i]);
		com_bus_write(ADDRESS_FIR_GYRO_Y + (i *0x100), filter_taps_gyro[i]);
	}
}

