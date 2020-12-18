/*
 * tuning.h
 *
 *  Created on: Oct 11, 2019
 *      Author: eldal
 */

#ifndef TUNING_H_
#define TUNING_H_

#include "BNO055.h"
#include "CB_output.h"
#include "PID.h"





int TUNE_gain_P;
int TUNE_gain_I;
int TUNE_gain_D;
static int TUNE_safe_P = 1000;
static int TUNE_safe_I = 5;
static int TUNE_safe_D = 100;
int TUNE_neutral_setpoint;

void TUNE_setup(int P, int I, int D, int neutral);
void TUNE_oscillate();
void TUNE_manual();
void TUNE_manual_stepped();
void TUNE_stepped(int change_p, int change_i, int change_d, int stepcount);
void TUNE_report(int setpoint);
void TUNE_report_simple(int sample_time, int sample_number);
void TUNE_slow_change_setpoint(int start, int end, int stepcount, int steptime);

#endif /* TUNING_H_ */
