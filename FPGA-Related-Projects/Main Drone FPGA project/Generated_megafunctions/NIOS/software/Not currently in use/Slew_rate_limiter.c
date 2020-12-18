/*
 * Slew_rate_limiter.c
 *
 *  Created on: Oct 30, 2019
 *      Author: eldal
 */
#include "Slew_rate_limiter.h"

void SLEW_set_rates(int out, int in)
{
	com_bus_write(ADDRESS_SLEW_LIMIT, out);
	com_bus_write(ADDRESS_SLEW_LIMIT + 0x100, in);
}

