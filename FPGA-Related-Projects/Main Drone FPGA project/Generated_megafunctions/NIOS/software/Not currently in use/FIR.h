/*
 * FIR.h
 *
 *  Created on: Oct 11, 2019
 *      Author: eldal
 */

#ifndef DRIVERS_FIR_H_
#define DRIVERS_FIR_H_

#include "Com_bus.h"
/*

FIR filter designed with
http://t-filter.appspot.com

sampling frequency: 800 Hz

fixed point precision: 16 bits

* 0 Hz - 300 Hz
  gain = 1
  desired ripple = 5 dB
  actual ripple = n/a

* 320 Hz - 400 Hz
  gain = 0
  desired attenuation = -40 dB
  actual attenuation = n/a

*/

#define FILTER_TAP_NUM 41

static int filter_taps_gyro[FILTER_TAP_NUM] = {
  1942,
  2243,
  -782,
  -157,
  662,
  -773,
  528,
  -20,
  -552,
  921,
  -867,
  328,
  531,
  -1333,
  1610,
  -1004,
  -566,
  2819,
  -5181,
  6969,
  25133,
  6969,
  -5181,
  2819,
  -566,
  -1004,
  1610,
  -1333,
  531,
  328,
  -867,
  921,
  -552,
  -20,
  528,
  -773,
  662,
  -157,
  -782,
  2243,
  1942
};



void FIR_write_taps_coefficients_gyro();



#endif /* DRIVERS_FIR_H_ */
