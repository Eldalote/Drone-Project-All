/*
 * BNO055.c
 *
 *  Created on: Sep 3, 2019
 *      Author: eldal
 */


#include "BNO055.h"


void BNO_write_single_byte(unsigned register_address, unsigned register_data)
{
	GI2CM_write_single_byte(ADDRESS_BNO055, I2C_BNO055_I2C_ADDRESS, register_address, register_data);

}
unsigned char BNO_read_single_byte(unsigned register_address)
{
	unsigned char temp = GI2CM_read_single_byte(ADDRESS_BNO055, I2C_BNO055_I2C_ADDRESS, register_address);
	return temp;
}

bool BNO_who_am_I()
{
	unsigned char reg_page = BNO_get_register_page();
	if(reg_page > 0)
	{
		if(reg_page == 1)
		{
			BNO_set_register_page(0x00);
		}
		else
		{
			printf("Invalid register page value. Cannot verify BNO055 chip.\n");
			return false;
		}
	}
	if(BNO_read_single_byte(0)== 0xA0)
	{
		printf("Verified BNO055 chip by reading WHO AM I register (value: 0xA0)\n");
		return true;
	}
	else
	{
		printf("Could not verify BNO055 chip by reading WHO AM I register. (Value: 0x%02X)\n", BNO_read_single_byte(0));
		return false;
	}

}

unsigned char BNO_get_register_page()
{
	return BNO_read_single_byte(0x07);
}
void BNO_set_register_page(unsigned pagenr )
{

	if(pagenr == 1)
	{
		BNO_write_single_byte(0x07, 1);
	}
	else if (pagenr == 0)
	{
		BNO_write_single_byte(0x07, 0);
	}
	else
	{
		printf("Invalid page number! \n");
		return;
	}

}
bool BNO_write_settings()
{
	if(BNO_who_am_I() == false)
	{
		printf("Could not proceed with settings due to WHO AM I error.\n");
		return false;
	}
	BNO_set_register_page(0x00);
	BNO_set_operation_mode(0x00);
	BNO_set_preset_calibration_data();
	BNO_set_operation_mode(0x0C);
	msleep(500);
	if(BNO_read_single_byte(0x39) == 0x05)
	{
		return true;
	}
	else
	{
		BNO_get_system_status();
		return false;
	}

}
void BNO_write_and_verify(unsigned register_address, unsigned register_data)
{
	unsigned char temp1, temp2;
	temp1 = BNO_read_single_byte(register_address);
	BNO_write_single_byte(register_address, register_data);
	temp2 = BNO_read_single_byte(register_address);
	printf("Verified writing:\nPre-write value: 0x%02X, Written value: 0x%02X, post-write value: 0x%02X\n",temp1, register_data, temp2);

}
void BNO_set_operation_mode(unsigned mode)
{
	BNO_set_register_page(0);
	unsigned char temp1, temp2;
	temp1 = BNO_read_single_byte(0x3D);
	BNO_write_single_byte(0x3D, mode);
	temp2 = BNO_read_single_byte(0x3D);
	printf("Wrote mode 0x%02X to BNO. Pre-write value: 0x%02X, post write: 0x%02X\n", mode, temp1, temp2);
}
void BNO_get_calibration_results()
{
	BNO_set_register_page(0);
	unsigned char cal_dat = BNO_read_single_byte(0x35);
	if(cal_dat == 0xFF)
	{
		printf("All calibration complete.\n");
		return;
	}
	if((cal_dat & 0x30) == 0x30)
	{
		printf("Gyroscope calibration done. ");
	}
	else
	{
		printf("Gyroscope calibration NOT done. ");
	}
	if((cal_dat & 0x0C) == 0x0C)
	{
		printf("Accelerometer calibration done. ");
	}
	else
	{
		printf("Accelerometer calibration NOT done. ");
	}
	if((cal_dat & 0x03) == 0x03)
	{
		printf("Magnetometer calibration done.\n");
	}
	else
	{
		printf("Magnetometer calibration NOT done.\n");
	}
}
void BNO_get_temperature()
{
	BNO_set_register_page(0);
	unsigned char temp = BNO_read_single_byte(0x34);
	if(BNO_read_single_byte(0x40) == 0)
	{
		printf("Temperature measured. From accelerator: %03i°C.\n", temp);
	}
	else
	{
		printf("Temperature measured. From Gyroscope: %03i°C.\n", temp);
	}




}
void BNO_get_selftest_results()
{
	BNO_set_register_page(0);
	unsigned char selftest = BNO_read_single_byte(0x36);
	if(selftest == 0x0F)
	{
		printf("Self test all cleared.\n");
		return;
	}
	if(selftest & 0x01 == 0)
	{
		printf("Accelerometer self test failed!\n");
	}
	if(selftest & 0x02 == 0)
	{
		printf("Magnetometer self test failed!\n");
	}
	if(selftest & 0x04 == 0)
	{
		printf("Gyroscope self test failed!\n");
	}
	if(selftest & 0x08 == 0)
	{
		printf("MCU self test failed!\n");
	}
}
void BNO_get_system_status()
{
	BNO_set_register_page(0);
	unsigned char status = BNO_read_single_byte(0x39);
	if(status == 0x00)
		printf("System idle.\n");
	if(status == 0x02)
		printf("System initialising peripherals.\n");
	if(status == 0x03)
		printf("System initialisation.\n");
	if(status == 0x04)
		printf("System executing self test.\n");
	if(status == 0x05)
		printf("System running in fusion mode.\n");
	if(status == 0x06)
		printf("System running without fusion mode.\n");
	if(status == 0x01)
	{
		printf("System Error! ");
		unsigned char error = BNO_read_single_byte(0x3A);
		if(error == 0x00)
			printf("No error? Somehow?\n");
		if(error == 0x01)
			printf("Peripheral initialisation error.\n");
		if(error == 0x02)
			printf("System initialisation error.\n");
		if(error == 0x03)
			printf("Self test result failed.\n");
		if(error == 0x04)
			printf("Register map value out of range.\n");
		if(error == 0x05)
			printf("Register map address out of range.\n");
		if(error == 0x06)
			printf("Register map write error.\n");
		if(error == 0x07)
			printf("BNO low power mode not available for selected operation mode.\n");
		if(error == 0x08)
			printf("Accelerometer power mode not available.\n");
		if(error == 0x09)
			printf("Fusion algorithm configuration error.\n");
		if(error == 0x0A)
			printf("Sensor configuration error.\n");
	}
}
void BNO_set_temperature_source(unsigned source)
{
	BNO_write_single_byte(0x40, source);
}
void BNO_print_calibration_data()
{
	unsigned char address = 0x55;
	unsigned char reg_value;
	while(true)
	{
		reg_value = BNO_read_single_byte(address);
		printf("Value for register 0x%02X is: 0x%02X\n", address, reg_value);
		if(address == 0x6A)
			return;
		address++;
	}
}
void BNO_set_preset_calibration_data()
{
	unsigned char address = 0x55;
	BNO_write_single_byte(address, ACC_GYR_OFFSET_X_LSB);
	address++;
	BNO_write_single_byte(address, ACC_GYR_OFFSET_X_MSB);
	address++;
	BNO_write_single_byte(address, ACC_GYR_OFFSET_Y_LSB);
	address++;
	BNO_write_single_byte(address, ACC_GYR_OFFSET_Y_MSB);
	address++;
	BNO_write_single_byte(address, ACC_GYR_OFFSET_Z_LSB);
	address++;
	BNO_write_single_byte(address, ACC_GYR_OFFSET_Z_MSB);
	address++;

	BNO_write_single_byte(address, MAG_GYR_OFFSET_X_LSB);
	address++;
	BNO_write_single_byte(address, MAG_GYR_OFFSET_X_MSB);
	address++;
	BNO_write_single_byte(address, MAG_GYR_OFFSET_Y_LSB);
	address++;
	BNO_write_single_byte(address, MAG_GYR_OFFSET_Y_MSB);
	address++;
	BNO_write_single_byte(address, MAG_GYR_OFFSET_Z_LSB);
	address++;
	BNO_write_single_byte(address, MAG_GYR_OFFSET_Z_MSB);
	address++;

	BNO_write_single_byte(address, BNO_GYR_OFFSET_X_LSB);
	address++;
	BNO_write_single_byte(address, BNO_GYR_OFFSET_X_MSB);
	address++;
	BNO_write_single_byte(address, BNO_GYR_OFFSET_Y_LSB);
	address++;
	BNO_write_single_byte(address, BNO_GYR_OFFSET_Y_MSB);
	address++;
	BNO_write_single_byte(address, BNO_GYR_OFFSET_Z_LSB);
	address++;
	BNO_write_single_byte(address, BNO_GYR_OFFSET_Z_MSB);
	address++;

	BNO_write_single_byte(address, BNO_ACC_RADIUS_LSB);
	address++;
	BNO_write_single_byte(address, BNO_ACC_RADIUS_MSB);
	address++;
	BNO_write_single_byte(address, BNO_MAG_RADIUS_LSB);
	address++;
	BNO_write_single_byte(address, BNO_MAG_RADIUS_MSB);
}
void BNO_set_unit_selection(unsigned selection)
{
	BNO_write_single_byte(0x3B, selection);
}
void BNO_print_heading()
{
	short heading;
	if(BNO_wait_until_ready())
	{
		unsigned char heading_lsb, heading_msb;
		heading_lsb = BNO_read_single_byte(0x1A);
		heading_msb = BNO_read_single_byte(0x1B);
		unsigned short heading_unsigned = heading_lsb + (heading_msb *0x100);
		heading = (short) heading_unsigned;
	}
	else
	{
		heading = (short) com_bus_read(ADDRESS_BNO055 + 0x100);
	}

	short heading_degrees = heading / 16;
	printf("Heading is: %03i degrees. ", heading_degrees);
}
void BNO_print_pitch()
{
	short pitch;
	if(BNO_wait_until_ready())
	{
		unsigned char pitch_lsb, pitch_msb;
		pitch_lsb = BNO_read_single_byte(0x1E);
		pitch_msb = BNO_read_single_byte(0x1F);
		unsigned short pitch_unsigned = pitch_lsb + (pitch_msb *0x100);
		pitch = (short) pitch_unsigned;
	}
	else
	{
		pitch = (short) com_bus_read(ADDRESS_BNO055 + 0x300);
	}
	short pitch_degrees = pitch /16;
	printf("Pitch is: %03i degrees. ", pitch_degrees);
}
void BNO_print_roll()
{
	short roll;
	if(BNO_wait_until_ready())
	{
		unsigned char roll_lsb, roll_msb;
		roll_lsb = BNO_read_single_byte(0x1C);
		roll_msb = BNO_read_single_byte(0x1D);
		unsigned short roll_unsigned = roll_lsb + (roll_msb *0x100);
		roll = (short) roll_unsigned;
	}
	else
	{
		roll = (short) com_bus_read(ADDRESS_BNO055 + 0x200);
	}
	short roll_degrees = roll /16;
	printf("Roll is: %03i degrees.\n", roll_degrees);
}
void BNO_print_euler()
{
	BNO_print_heading();
	BNO_print_pitch();
	BNO_print_roll();
}
void BNO_print_quaternions()
{
	short quat_w, quat_x, quat_y, quat_z;
	quat_w = (short)(BNO_read_single_byte(0x20) + (0x100 * BNO_read_single_byte(0x21)));
	quat_x = (short)(BNO_read_single_byte(0x22) + (0x100 * BNO_read_single_byte(0x23)));
	quat_y = (short)(BNO_read_single_byte(0x24) + (0x100 * BNO_read_single_byte(0x25)));
	quat_z = (short)(BNO_read_single_byte(0x26) + (0x100 * BNO_read_single_byte(0x27)));
	printf("W = %04i, X = %04i, Y = %04i, Z = %04i\n", quat_w /10, quat_x /10, quat_y/10, quat_z/10);
}
void BNO_print_linear_accelerations()
{
	short lin_x, lin_y, lin_z;
	if(BNO_wait_until_ready())
	{
		lin_x = (short) (BNO_read_single_byte(0x28) + (0x100 * BNO_read_single_byte(0x29)));
		lin_y = (short) (BNO_read_single_byte(0x2A) + (0x100 * BNO_read_single_byte(0x2B)));
		lin_z = (short) (BNO_read_single_byte(0x2C) + (0x100 * BNO_read_single_byte(0x2D)));
	}
	else
	{
		lin_x = (short) com_bus_read(ADDRESS_BNO055 + 0x400);
		lin_y = (short) com_bus_read(ADDRESS_BNO055 + 0x500);
		lin_z = (short) com_bus_read(ADDRESS_BNO055 + 0x600);
	}

	printf("X = %04i, Y = %04i, Z = %04i\n", lin_x, lin_y, lin_z);
}
bool BNO_wait_until_ready()
{
	return GI2CM_wait_untill_ready(ADDRESS_BNO055);
}
void BNO_release_control()
{
	if(BNO_wait_until_ready())
		com_bus_write(ADDRESS_BNO055 + 0x4000, 0);
}

short BNO_get_pitch()
{
	short pitch;
	if(BNO_wait_until_ready())
	{
		unsigned char pitch_lsb, pitch_msb;
		pitch_lsb = BNO_read_single_byte(0x1E);
		pitch_msb = BNO_read_single_byte(0x1F);
		unsigned short pitch_unsigned = pitch_lsb + (pitch_msb *0x100);
		pitch = (short) pitch_unsigned;
	}
	else
	{
		pitch = (short) com_bus_read(ADDRESS_BNO055 + 0x300);
	}
	return pitch;
}
