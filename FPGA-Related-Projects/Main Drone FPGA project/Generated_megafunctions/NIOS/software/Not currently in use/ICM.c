/*
 * ICM.c
 *
 *  Created on: Jan 31, 2020
 *      Author: eldal
 */
#include "ICM.h"

void ICM_write_single_byte(unsigned raw_register_address, unsigned register_data)
{
	GSPIM_write_single_byte(ADDRESS_ICM, raw_register_address, register_data);
}
unsigned char ICM_read_single_byte(unsigned raw_register_address)
{
	unsigned completed_register_address = raw_register_address + ICM_REGADD_READ;
	return GSPIM_read_single_byte(ADDRESS_ICM, completed_register_address);
}
unsigned char ICM_who_am_I(bool silent)
{
	unsigned char result = ICM_read_single_byte(ICM_REGADD_WHO_AM_I); //Get the data of byte 1(0)
	if(!silent)
	{
		if (result == ICM_WHO_AM_I_NORMAL)//If it matches expectations
		{
			printf("Confirmed to be the ICM20948 sensor by WHO AM I\n");
		}
		else//if it doesn't
		{
			printf("ICM20948 WHO AM I error. Expected %X, got %X.\n", ICM_WHO_AM_I_NORMAL, result);
		}
	}
	return result;
}
bool ICM_write_settings()
{
	if(GSPIM_wait_untill_ready(ADDRESS_ICM)== false) //Always wait till the master is ready
	{
		printf("The ICM20948 SPI master has been released already. Cannot write setting data.\n");
		return false; // If the wait till ready returned false, then the SPI master has already been released.
	}
	if(ICM_who_am_I(true) != ICM_WHO_AM_I_NORMAL)
		return false;

	ICM_page_select(0);

	ICM_write_single_byte(ICM_REGADD_LP_CONFIG, ICM_REGDAT_LP_CONFIG);

	usleep(50000);

	ICM_page_select(2);
	usleep(100);

	ICM_write_single_byte(ICM_REGADD_GYRO_CONFIG_1, ICM_REGDAT_GYRO_CONFIG_1);
	ICM_write_single_byte(ICM_REGADD_ACC_CONFIG, ICM_REGDAT_ACC_CONFIG);

	ICM_page_select(0);
	usleep(100);

	ICM_write_single_byte(ICM_REGADD_INT_PIN_CONF, ICM_REGDAT_INT_PIN_CONF);
	ICM_write_single_byte(ICM_REGADD_INT_ENABLE_1, ICM_REGDAT_INT_ENABLE_1);
	ICM_write_single_byte(ICM_REGADD_PWR_MANAGEMENT_1, ICM_REGDAT_PWR_MANAGEMENT_1);
	ICM_write_single_byte(ICM_REGADD_LP_CONFIG, ICM_REGDAT_LP_CONFIG);

	return true;
}
unsigned char ICM_get_data_status()
{
	return ICM_read_single_byte(ICM_REGADD_DATA_RDY_STATUS);
}
void ICM_get_data()
{
	unsigned short gyro_x;
	unsigned short gyro_y;
	unsigned short gyro_z;
	unsigned short acc_x;
	unsigned short acc_y;
	unsigned short acc_z;
	unsigned short temp;
	char address = ICM_REGADD_READ_START;

	acc_x = ICM_read_single_byte(address) * 0x100;
	address++;
	acc_x += ICM_read_single_byte(address);
	address++;

	acc_y = ICM_read_single_byte(address)* 0x100;
	address++;
	acc_y += ICM_read_single_byte(address);
	address++;

	acc_z = ICM_read_single_byte(address)* 0x100;
	address++;
	acc_z += ICM_read_single_byte(address);
	address++;

	gyro_x = ICM_read_single_byte(address)* 0x100;
	address++;
	gyro_x += ICM_read_single_byte(address);
	address++;

	gyro_y = ICM_read_single_byte(address)* 0x100;
	address++;
	gyro_y += ICM_read_single_byte(address);
	address++;

	gyro_z = ICM_read_single_byte(address)* 0x100;
	address++;
	gyro_z += ICM_read_single_byte(address);
	address++;

	temp = ICM_read_single_byte(address)* 0x100;
	address++;
	temp += ICM_read_single_byte(address);
	address++;

	ICM_gyro_x = (short) gyro_x;
	ICM_gyro_y = (short) gyro_y;
	ICM_gyro_z = (short) gyro_z;
	ICM_acc_x = (short) acc_x;
	ICM_acc_y = (short) acc_y;
	ICM_acc_z = (short) acc_z;
	ICM_temp = (short) temp;
}
void ICM_print_data()
{
	printf("Gyroscope: X: %i, Y: %i, Z: %i\n", ICM_gyro_x, ICM_gyro_y, ICM_gyro_z);
	printf("Accelerometer: X: %i, Y: %i, Z: %i\n", ICM_acc_x, ICM_acc_y, ICM_acc_z);
	printf("Temperature: %i\n", ICM_temp);
}
void ICM_release()
{
	if(GSPIM_wait_untill_ready(ADDRESS_ICM)== false) //Always wait till the master is ready
	{
		printf("The Gyroscope SPI master has been released already. Cannot release again.\n");
		return;// If the wait till ready returned false, then the SPI master has already been released.
	}
	unsigned complete_address = ADDRESS_ICM + GSPIM_RELEASE_COMMAND;
	com_bus_write(complete_address,0);
}
bool ICM_init()
{
	return false;
}
void ICM_page_select(char page)
{
	ICM_write_single_byte(ICM_REGADD_PAGE_SELECT, page * ICM_PAGE_SELECT_MULTIPLIER);
}


