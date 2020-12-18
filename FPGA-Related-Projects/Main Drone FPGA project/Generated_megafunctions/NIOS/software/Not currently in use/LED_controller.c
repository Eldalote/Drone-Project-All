/*
 * LED_controller.c
 *
 *  Created on: 3 Jul 2019
 *      Author: Jan Mart
 */
#include "LED_controller.h"

void LED_clear_all()
{
	com_bus_write(ADDRESS_LED_OUTPUT, 0);
}
void LED_set_all()
{
	com_bus_write(ADDRESS_LED_OUTPUT, 0xFF);
}
unsigned char LED_set(unsigned LED_mask )
{
	if(LED_mask > 0xFF)
	{
		return (unsigned char)com_bus_write_read(ADDRESS_LED_OUTPUT, 0xFF);
	}
	else
	{
		return (unsigned char)com_bus_write_read(ADDRESS_LED_OUTPUT, LED_mask);
	}
}
unsigned char LED_read()
{
	return (unsigned char) com_bus_read(ADDRESS_LED_OUTPUT);
}
