/*
 * Sleeping.h
 *
 *  Created on: Aug 27, 2019
 *      Author: eldal
 */

#ifndef DRIVERS_SLEEPING_H_
#define DRIVERS_SLEEPING_H_

#include <system.h>

void msleep(int milliseconds)
{
	usleep(milliseconds * 1000);
}
void secondssleep(int seconds)
{
	usleep(1000000 * seconds);
}


#endif /* DRIVERS_SLEEPING_H_ */
