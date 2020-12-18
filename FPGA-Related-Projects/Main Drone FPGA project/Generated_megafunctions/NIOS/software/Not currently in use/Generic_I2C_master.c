/*
 * Generic_I2C_master.c
 *
 *  Created on: Sep 3, 2019
 *      Author: eldal
 */
#include "Generic_I2C_master.h"


int GI2CM_check_ready(unsigned master_address)
{
	unsigned complete_address;
		unsigned result;
		complete_address = master_address + I2C_CHECK_READY;
		result = com_bus_read(complete_address);
		if (result == 0x100)
		{
			return 0;
		}
		if(result == 0x200)
		{
			return 1;
		}
		if (result == 0x201)
		{
			return -1;
		}
		printf("?");
		return -2;
}
bool GI2CM_wait_untill_ready(unsigned master_address)
{
	int result;
	while(true)
	{
		result = GI2CM_check_ready(master_address);
		if(result == -1)
		{
			return false;
		}
		if(result == 1)
		{
			return true;
		}
		usleep(10);
	}
}
void GI2CM_write_single_byte(unsigned master_address, unsigned I2C_address, unsigned register_address, unsigned register_byte)
{
	if(GI2CM_wait_untill_ready(master_address)== false) //Always wait till the master is ready
		{
			printf("The I2C master has been released already. Cannot write byte.\n");
			return; // If the wait till ready returned false, then the I2C master has already been released.
		}

		unsigned complete_address = master_address + I2C_WRITE_COMMAND;
		unsigned complete_message = (I2C_address * I2C_I2C_ADDRESS_MULTIPLIER) +
				(register_address * I2C_REGISTER_ADDRESS_MULTIPLIER) +
				(register_byte * I2C_DATA_MULTIPLIER);
		com_bus_write(complete_address, complete_message);

}
unsigned char GI2CM_read_single_byte(unsigned master_address, unsigned I2C_address, unsigned register_address)
{
	if(GI2CM_wait_untill_ready(master_address)== false) //Always wait till the master is ready
	{
		printf("The I2C master has been released already. Cannot write byte.\n");
		return 0; // If the wait till ready returned false, then the I2C master has already been released.
	}

	unsigned complete_address = master_address + I2C_READ_COMMAND;
	unsigned complete_message = (I2C_address * I2C_I2C_ADDRESS_MULTIPLIER) +
			(register_address * I2C_REGISTER_ADDRESS_MULTIPLIER);
	com_bus_write(complete_address, complete_message);
	GI2CM_wait_untill_ready(master_address);
	return (unsigned char) com_bus_read(master_address);

}
bool GI2CM_read_X_bytes(unsigned master_address, unsigned I2C_address, unsigned register_address, unsigned X)
{
	if(GI2CM_wait_untill_ready(master_address)== false) //Always wait till the master is ready
	{
		printf("The I2C master has been released already. Cannot write byte.\n");
		return 0; // If the wait till ready returned false, then the I2C master has already been released.
	}
	if(X > 16)
	{
		return false;
	}
	if(X > 0)
	{
		X--;
	}
	unsigned complete_address = master_address + I2C_READ_COMMAND + (X * I2C_BYTE_TO_READ_MULTIPLIER);
	unsigned complete_message = (I2C_address * I2C_I2C_ADDRESS_MULTIPLIER) + (register_address * I2C_REGISTER_ADDRESS_MULTIPLIER);
	com_bus_write(complete_address, complete_message);
	GSPIM_wait_untill_ready(master_address);
	return true;

}
unsigned char GI2CM_check_byte_X(unsigned master_address, unsigned X)
{
	unsigned complete_address = master_address + (X * I2C_BYTE_TO_READ_MULTIPLIER);
	return (unsigned char) com_bus_read(complete_address);
}

