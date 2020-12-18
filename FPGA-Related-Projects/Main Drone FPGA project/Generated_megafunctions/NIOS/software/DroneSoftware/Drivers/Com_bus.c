/*
 * Com_bus.c
 *
 *  Created on: 27 Jun 2019
 *      Author: Jan Mart
 */

#include "Com_bus.h"

void com_bus_write(unsigned address, unsigned data)
{
	ALT_CI_NIOS_FPGA_COM(1, address, data);
}

unsigned com_bus_read(unsigned address)
{
	return (unsigned) ALT_CI_NIOS_FPGA_COM(0, address, 0);
}

unsigned com_bus_write_read(unsigned address, unsigned data)
{
	return (unsigned) ALT_CI_NIOS_FPGA_COM(2, address, data);
}


