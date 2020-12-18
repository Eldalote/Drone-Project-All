/*
 * Gyroscope.h
 *
 *  Created on: 3 Jul 2019
 *      Author: Jan Mart
 */


#ifndef DRIVERS_GYROSCOPE_H_
#define DRIVERS_GYROSCOPE_H_

#include "Com_bus.h"
#include "Generic_SPI_master.h"
#include <stdbool.h>


/*
 * Addresses and command bits for the L3GD29H registers
 *
 */

#define GYRO_REGADD_READ 0x80
#define GYRO_REGADD_WRITE 0x00
#define GYRO_REGADD_AUTO_INCREMENT 0x40

#define GYRO_REGADD_CTRL1 0x20
#define GYRO_REGADD_CTRL2 0x21
#define GYRO_REGADD_CTRL3 0x22
#define GYRO_REGADD_CTRL4 0x23
#define GYRO_REGADD_CTRL5 0x24

#define GYRO_REGADD_WHO_AM_I 0x0F
#define GYRO_REGADD_REFERENCE 0x25
#define GYRO_REGADD_OUT_TEMP 0x26
#define GYRO_REGADD_STATUS 0x27
#define GYRO_REGADD_LOW_ODR 0x39

#define GYRO_REGADD_X_L 0x28
#define GYRO_REGADD_X_H 0x29
#define GYRO_REGADD_Y_L 0x2A
#define GYRO_REGADD_Y_H 0x2B
#define GYRO_REGADD_Z_L 0x2C
#define GYRO_REGADD_Z_H 0x2D


#define GYRO_OUTPUT_STATUS 0x4
#define GYRO_OUTPUT_DATAX 0x1
#define GYRO_OUTPUT_DATAY 0x2
#define GYRO_OUTPUT_DATAZ 0x3

/*
 *  Data from and for registers
 */
#define GYRO_WHO_AM_I_NORMAL 0xD7

#define GYRO_regdata_CTRL1  0xFF
#define GYRO_regdata_CTRL2  0x27
#define GYRO_regdata_CTRL3  0x08
#define GYRO_regdata_CTRL4  0x00
#define GYRO_regdata_CTRL5  0x12
#define GYRO_regdata_LOW_ODR  0x00





/*
 * Functions
 */

void GYRO_write_single_byte(unsigned raw_register_address, unsigned register_data);
unsigned char GYRO_read_single_byte(unsigned raw_register_address);

unsigned char GYRO_who_am_I();
bool GYRO_write_settings();
unsigned char GYRO_read_status();
char GYRO_read_temperature();
short GYRO_read_dataX();
short GYRO_read_dataY();
short GYRO_read_dataZ();
void GYRO_release();
bool GYRO_setup();
void GYRO_report_data();
void GYRO_print_second_of_data();




#endif /* DRIVERS_GYROSCOPE_H_ */
