/*
 * Generic_SPI_header.h
 *
 *  Created on: Jul 9, 2019
 *      Author: eldal
 */

#ifndef DRIVERS_GENERIC_SPI_MASTER_H_
#define DRIVERS_GENERIC_SPI_MASTER_H_

#include <stdbool.h>
#include "Com_bus.h"
#include <stdio.h>


#define GSPIM_BYTES_TO_WRITE_MULTIPLIER 0x100
#define GSPIM_BYTE_TO_READ_MULTIPLIER 0x100
#define GSPIM_CHECK_READY 0x1000
#define GSPIM_WRITE_COMMAND 0x2000
#define GSPIM_READ_COMMAND 0x0
#define GSPIM_RELEASE_COMMAND 0x4000


int GSPIM_check_ready(unsigned master_address);
bool GSPIM_wait_untill_ready(unsigned master_address);
void GSPIM_write_single_byte(unsigned master_address, unsigned register_address, unsigned register_byte);
unsigned char GSPIM_read_single_byte(unsigned master_address, unsigned register_address);



#endif /* DRIVERS_GENERIC_SPI_MASTER_H_ */
