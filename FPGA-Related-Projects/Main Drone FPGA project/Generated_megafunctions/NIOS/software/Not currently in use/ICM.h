/*
 * ICM.h
 *
 *  Created on: Jan 31, 2020
 *      Author: eldal
 */

#ifndef DRIVERS_ICM_H_
#define DRIVERS_ICM_H_

#include "Com_bus.h"
#include "Generic_SPI_master.h"
#include <stdbool.h>

#define ICM_REGADD_READ 0x80

#define ICM_REGADD_WHO_AM_I 0x00
#define ICM_WHO_AM_I_NORMAL 0xEA

#define ICM_REGADD_DATA_RDY_STATUS 0x74
#define ICM_REGADD_READ_START 0x2D

#define ICM_REGADD_LP_CONFIG 0x05
#define ICM_REGDAT_LP_CONFIG 0x00

#define ICM_REGADD_PWR_MANAGEMENT_1 0x06
#define ICM_REGDAT_PWR_MANAGEMENT_1 0x01

#define ICM_REGADD_INT_PIN_CONF 0x0F
#define ICM_REGDAT_INT_PIN_CONF 0x02

#define ICM_REGADD_INT_ENABLE_1 0x11
#define ICM_REGDAT_INT_ENABLE_1 0x01

#define ICM_REGADD_GYRO_CONFIG_1 0x01
#define ICM_REGDAT_GYRO_CONFIG_1 0x04

#define ICM_REGADD_ACC_CONFIG 0x20
#define ICM_REGDAT_ACC_CONFIG 0x02

#define ICM_REGADD_PAGE_SELECT 0x7F
#define ICM_PAGE_SELECT_MULTIPLIER 0x10

short ICM_gyro_x;
short ICM_gyro_y;
short ICM_gyro_z;
short ICM_acc_x;
short ICM_acc_y;
short ICM_acc_z;
short ICM_temp;

void ICM_write_single_byte(unsigned raw_register_address, unsigned register_data);
unsigned char ICM_read_single_byte(unsigned raw_register_address);


unsigned char ICM_who_am_I(bool silent);
bool ICM_write_settings();
unsigned char ICM_get_data_status();
void ICM_get_data();
void ICM_print_data();
void ICM_release();
bool ICM_init();
void ICM_page_select(char page);

#endif /* DRIVERS_ICM_H_ */
