/*
 * Generic_I2C_master.h
 *
 *  Created on: Sep 3, 2019
 *      Author: eldal
 */

#ifndef DRIVERS_GENERIC_I2C_MASTER_H_
#define DRIVERS_GENERIC_I2C_MASTER_H_

#include "Com_bus.h"
#include <stdbool.h>
#include <stdio.h>


#define I2C_WRITE_COMMAND 0
#define I2C_READ_COMMAND 0x2000
#define I2C_CHECK_READY 0x1000
#define I2C_RELEASE_COMMAND 0x4000
#define I2C_BYTE_TO_READ_MULTIPLIER 0X100
#define I2C_I2C_ADDRESS_MULTIPLIER 0x10000
#define I2C_REGISTER_ADDRESS_MULTIPLIER 0x100
#define I2C_DATA_MULTIPLIER 0x1

int GI2CM_check_ready(unsigned master_address);
bool GI2CM_wait_untill_ready(unsigned master_address);
void GI2CM_write_single_byte(unsigned master_address, unsigned I2C_address, unsigned register_address, unsigned register_byte);
unsigned char GI2CM_read_single_byte(unsigned master_address, unsigned I2C_address, unsigned register_address);
bool GI2CM_read_X_bytes(unsigned master_address, unsigned I2C_address, unsigned register_address, unsigned X);
unsigned char GI2CM_check_byte_X(unsigned master_address, unsigned X);

#endif /* DRIVERS_GENERIC_I2C_MASTER_H_ */
