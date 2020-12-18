/*
 * Com_bus.h
 *
 *  Created on: 27 Jun 2019
 *      Author: Jan Mart
 */



#ifndef COM_BUS_H_
#define COM_BUS_H_

#include "Com_bus_codes.h"
#include <system.h>

void com_bus_write(unsigned address, unsigned data);
unsigned com_bus_read(unsigned address);
unsigned com_bus_write_read(unsigned address, unsigned data);


#endif /* COM_BUS_H_ */
