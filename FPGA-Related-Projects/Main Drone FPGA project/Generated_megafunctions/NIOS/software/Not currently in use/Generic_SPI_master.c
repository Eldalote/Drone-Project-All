#include "Generic_SPI_master.h"

int GSPIM_check_ready(unsigned master_address)
{
	unsigned complete_address;
	unsigned result;
	complete_address = master_address + GSPIM_CHECK_READY;
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
	return -2;
}

bool GSPIM_wait_untill_ready(unsigned master_address)
{
	int result;
	while(true)
	{
		result = GSPIM_check_ready(master_address);
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

void GSPIM_write_single_byte(unsigned master_address, unsigned register_address, unsigned register_byte)
{
	if(GSPIM_wait_untill_ready(master_address)== false) //Always wait till the master is ready
	{
		printf("The SPI master has been released already. Cannot write byte.\n");
		return; // If the wait till ready returned false, then the SPI master has already been released.
	}

	unsigned complete_address = master_address + GSPIM_WRITE_COMMAND;
	com_bus_write(complete_address, register_address);
	com_bus_write(complete_address, register_byte);
}
unsigned char GSPIM_read_single_byte(unsigned master_address, unsigned register_address)
{
	if(GSPIM_wait_untill_ready(master_address)== false) //Always wait till the master is ready
	{
		printf("The SPI master has been released already. Cannot write byte.\n");
		return 0; // If the wait till ready returned false, then the SPI master has already been released.
	}


	com_bus_write(master_address, register_address);
	GSPIM_wait_untill_ready(master_address);
	return (unsigned char) com_bus_read(master_address);
}

