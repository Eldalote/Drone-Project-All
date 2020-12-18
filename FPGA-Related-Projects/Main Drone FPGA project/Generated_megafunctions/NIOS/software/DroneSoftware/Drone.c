
#include <stdio.h>
#include "Drivers.h"
#include <stdbool.h>




int main()
{
	printf("Serial connection made \n");


	unsigned data, status_reg, lost_packets, testbyte, states;

	unsigned full_read, transfer_number, master_out, slave_out;
	unsigned spi_counter = 0;
	unsigned master_arr[33], slave_arr[33];
	unsigned bytes_counter = 0;

	for(int i = 0; i <100 ; i++)
	{
		com_bus_write(0x0001, i);

		msleep(10);
		full_read = com_bus_read(0x0001);
		transfer_number = full_read & 0xFF0000;
		transfer_number /= 0x10000;

		master_out = full_read & 0xFF00;
		master_out /= 0x100;
		slave_out = full_read & 0xFF;
		if(transfer_number < 33)
		{
			master_arr[transfer_number] = master_out;
			slave_arr[transfer_number] = slave_out;
			if(transfer_number == 0)
			{
				printf("Transfer nr %i: \nMaster: ", spi_counter);
				spi_counter++;
				for(int j = 0; j < bytes_counter; j++)
				{
					if(j == 0)
						printf("Command: ");
					else
						printf("Byte: ");

					printf("0x%02X, ", master_arr[j]);
				}

				printf("\nSlave: ");
				for(int j = 0; j < bytes_counter; j++)
				{
					if(j == 0)
						printf("Status: ");
					else
						printf("Byte: ");

					printf("0x%02X, ", slave_arr[j]);
				}
				printf("\n\n");
				bytes_counter = transfer_number + 1;
				msleep(100);
			}
			else
			{
				bytes_counter = transfer_number + 1;
			}
		}




	}



	while(true)
	{



		/*
		data = com_bus_read(0x0008);
		states = data & 0xFF000000;
		states /= 0x1000000;
		status_reg = data & 0xFF0000;
		status_reg /= 0x10000;
		lost_packets = data & 0xFF00;
		lost_packets /= 0x100;
		testbyte = data & 0xFF;
		printf("Status: %2X, Lost Packets: %3i, TestByte: %3i, State: %2X\n", status_reg, lost_packets, testbyte, states);
		msleep(500);
		*/

	}

	return 0;
}
