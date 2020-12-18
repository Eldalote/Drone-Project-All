/*
 * BNO055.h
 *
 *  Created on: Sep 3, 2019
 *      Author: eldal
 */

#ifndef DRIVERS_BNO055_H_
#define DRIVERS_BNO055_H_

#include "Generic_I2C_master.h"

#define I2C_BNO055_I2C_ADDRESS 0x28

#define ACC_GYR_OFFSET_X_LSB 0x00
#define ACC_GYR_OFFSET_X_MSB 0x00
#define ACC_GYR_OFFSET_Y_LSB 0x00
#define ACC_GYR_OFFSET_Y_MSB 0x00
#define ACC_GYR_OFFSET_Z_LSB 0x00
#define ACC_GYR_OFFSET_Z_MSB 0x00

#define MAG_GYR_OFFSET_X_LSB 0x00
#define MAG_GYR_OFFSET_X_MSB 0x00
#define MAG_GYR_OFFSET_Y_LSB 0x00
#define MAG_GYR_OFFSET_Y_MSB 0x00
#define MAG_GYR_OFFSET_Z_LSB 0x00
#define MAG_GYR_OFFSET_Z_MSB 0x00

#define BNO_GYR_OFFSET_X_LSB 0x00
#define BNO_GYR_OFFSET_X_MSB 0x00
#define BNO_GYR_OFFSET_Y_LSB 0x00
#define BNO_GYR_OFFSET_Y_MSB 0x00
#define BNO_GYR_OFFSET_Z_LSB 0x00
#define BNO_GYR_OFFSET_Z_MSB 0x00

#define BNO_ACC_RADIUS_LSB 0xE8
#define BNO_ACC_RADIUS_MSB 0x03
#define BNO_MAG_RADIUS_LSB 0x00
#define BNO_MAG_RADIUS_MSB 0x00



void BNO_write_single_byte(unsigned register_address, unsigned register_data);
unsigned char BNO_read_single_byte(unsigned register_address);

bool BNO_wait_until_ready();
bool BNO_who_am_I();
bool BNO_write_settings();
unsigned char BNO_get_register_page();
void BNO_set_register_page(unsigned pagenr );
void BNO_write_and_verify(unsigned register_address, unsigned register_data);
void BNO_set_operation_mode(unsigned mode);
void BNO_get_calibration_results();
void BNO_get_temperature();
void BNO_get_selftest_results();
void BNO_get_system_status();
void BNO_set_temperature_source(unsigned source);
void BNO_print_calibration_data();
void BNO_set_preset_calibration_data();
void BNO_set_unit_selection(unsigned selection);
void BNO_print_heading();
void BNO_print_pitch();
void BNO_print_roll();
void BNO_print_euler();
void BNO_print_quaternions();
void BNO_print_linear_accelerations();
void BNO_release_control();
short BNO_get_pitch();

#endif /* DRIVERS_BNO055_H_ */
