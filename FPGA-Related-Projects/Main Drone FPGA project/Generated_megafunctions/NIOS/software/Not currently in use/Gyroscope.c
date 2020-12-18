/*
 * Gyroscope.c
 *
 *  Created on: 3 Jul 2019
 *      Author: Jan Mart
 */

#include "Gyroscope.h"


void GYRO_write_single_byte(unsigned raw_register_address, unsigned register_data)
{
	GSPIM_write_single_byte(ADDRESS_GYRO, raw_register_address, register_data);
}
unsigned char GYRO_read_single_byte(unsigned raw_register_address)
{
	unsigned completed_register_address = raw_register_address + GYRO_REGADD_READ;
	return GSPIM_read_single_byte(ADDRESS_GYRO, completed_register_address);
}


unsigned char GYRO_who_am_I()
{
	unsigned char result = GYRO_read_single_byte(GYRO_REGADD_WHO_AM_I); //Get the data of byte 1(0)
	if (result == GYRO_WHO_AM_I_NORMAL)//If it matches expectations
	{
		printf("Confirmed to be the L3GD20H gyroscope by WHO AM I\n");
	}
	else//if it doesn't
	{
		printf("WHO AM I error. Expected %x, got %i.\n", GYRO_WHO_AM_I_NORMAL, result);
	}
	return result;

}

bool GYRO_write_settings()
{

	if(GSPIM_wait_untill_ready(ADDRESS_GYRO)== false) //Always wait till the master is ready
	{
		printf("The Gyroscope SPI master has been released already. Cannot write setting data.\n");
		return false; // If the wait till ready returned false, then the SPI master has already been released.
	}
	GYRO_write_single_byte(GYRO_REGADD_CTRL1, GYRO_regdata_CTRL1);
	GYRO_write_single_byte(GYRO_REGADD_CTRL2, GYRO_regdata_CTRL2);
	GYRO_write_single_byte(GYRO_REGADD_CTRL3, GYRO_regdata_CTRL3);
	GYRO_write_single_byte(GYRO_REGADD_CTRL4, GYRO_regdata_CTRL4);
	GYRO_write_single_byte(GYRO_REGADD_CTRL5, GYRO_regdata_CTRL5);
	GYRO_write_single_byte(GYRO_REGADD_LOW_ODR, GYRO_regdata_LOW_ODR);
	return true;
}
unsigned char GYRO_read_status()
{
	if(GSPIM_wait_untill_ready(ADDRESS_GYRO)== false) //Always wait till the master is ready
	{
		//printf("The Gyroscope SPI master has been released already.\n");
		return com_bus_read(ADDRESS_GYRO + (GYRO_OUTPUT_STATUS * 0x100)); // If the wait till ready returned false, then the SPI master has already been released. Read from output
	}
	return GYRO_read_single_byte(GYRO_REGADD_STATUS);
}
char GYRO_read_temperature()
{
	if(GSPIM_wait_untill_ready(ADDRESS_GYRO)== false) //Always wait till the master is ready
	{
		printf("The Gyroscope SPI master has been released already.\n");
		return 0; // If the wait till ready returned false, then the SPI master has already been released.
	}
	return (char)GYRO_read_single_byte(GYRO_REGADD_OUT_TEMP);
}
short GYRO_read_dataX()
{
	if(GSPIM_wait_untill_ready(ADDRESS_GYRO)== false) //Always wait till the master is ready
	{
		//printf("The Gyroscope SPI master has been released already. Switching to released mode reading.\n");
		return (short) com_bus_read(ADDRESS_GYRO + (GYRO_OUTPUT_DATAX *0x100)); // If the wait till ready returned false, then the SPI master has already been released. Read from output
	}
	unsigned char lower = GYRO_read_single_byte(GYRO_REGADD_X_L);
	unsigned char higher = GYRO_read_single_byte(GYRO_REGADD_X_H);

	return (short) lower + (higher * 0x100);
}
short GYRO_read_dataY()
{
	if(GSPIM_wait_untill_ready(ADDRESS_GYRO)== false) //Always wait till the master is ready
	{
		//printf("The Gyroscope SPI master has been released already. Switching to released mode reading.\n");
		return (short)com_bus_read(ADDRESS_GYRO + (0x100 * GYRO_OUTPUT_DATAY)); // If the wait till ready returned false, then the SPI master has already been released. Read from output
	}


	unsigned char lower = GYRO_read_single_byte(GYRO_REGADD_Y_L);
	unsigned char higher = GYRO_read_single_byte(GYRO_REGADD_Y_H);

	return (short) lower + (higher * 0x100);
}
short GYRO_read_dataZ()
{
	if(GSPIM_wait_untill_ready(ADDRESS_GYRO)== false) //Always wait till the master is ready
	{
		//printf("The Gyroscope SPI master has been released already. Switching to released mode reading.\n");
		return (short)com_bus_read(ADDRESS_GYRO + (0x100 * GYRO_OUTPUT_DATAZ)); // If the wait till ready returned false, then the SPI master has already been released. Read from output
	}
	unsigned char lower = GYRO_read_single_byte(GYRO_REGADD_Z_L);
	unsigned char higher = GYRO_read_single_byte(GYRO_REGADD_Z_H);

	return (short) lower + (higher * 0x100);
}
void GYRO_release()
{
	if(GSPIM_wait_untill_ready(ADDRESS_GYRO)== false) //Always wait till the master is ready
		{
			printf("The Gyroscope SPI master has been released already. Cannot release again.\n");
			return;// If the wait till ready returned false, then the SPI master has already been released.
		}
	unsigned complete_address = ADDRESS_GYRO + GSPIM_RELEASE_COMMAND;
	com_bus_write(complete_address,0);
}
bool GYRO_setup()
{
	if(GSPIM_wait_untill_ready(ADDRESS_GYRO)== false) //Always wait till the master is ready
	{
		printf("The Gyroscope SPI master has been released already. Cannot procede with setup.\n");
		return false;// If the wait till ready returned false, then the SPI master has already been released.
	}
	if(GYRO_who_am_I() != GYRO_WHO_AM_I_NORMAL)
	{
		printf("Unknown SPI slave, cannot continue with setup \n");
		return false;
	}
	char temp;
	unsigned status = GYRO_read_status();
	printf("Pre-setup status is: %x\nStarting with setup...\n", status);
	if(!GYRO_write_settings())
	{
		return false;
	}
	usleep(10000);
	status = GYRO_read_status();
	temp = (char)GYRO_read_temperature();
	printf("Post-setup status is: %x, Temp is: %i\nSetup complete.\n", status, temp);

	return true;
}
void GYRO_report_data()
{

	short dataX, dataY, dataZ;
	dataX = GYRO_read_dataX();
	dataY = GYRO_read_dataY();
	dataZ = GYRO_read_dataZ();
	printf("Data X: %05i, Data Y: %05i, Data Z: %05i \n", dataX, dataY, dataZ);



	/*
	int running_total = 0;
	int average = 0;
	short dataX;
	unsigned short abs_dataX;
	for(int i = 0; i < 800; i++)
	{
		dataX = GYRO_read_dataX();
		if(dataX < 0)
		{
			abs_dataX = dataX *-1;
		}
		else
		{
			abs_dataX = dataX;
		}
		running_total += dataX;
		average += abs_dataX;
		usleep(1250);
	}
	average = running_total /800;
	printf("Total value of measured X after 1 second: %i, average value of measurements: %i \n", running_total, average);
	*/


}

void GYRO_print_second_of_data()
{
	short datax[800], datay[800], dataz[800];
	for(int i = 0; i < 800; i++)
	{
		datax[i] = GYRO_read_dataX();
		datay[i] = GYRO_read_dataY();
		dataz[i] = GYRO_read_dataZ();
		usleep(1250);
	}
	for(int i = 0; i < 800; i++)
	{
		printf("I: %i X: %i Y: %i Z: %i\n", i, datax[i], datay[i], dataz[i]);
	}
}
