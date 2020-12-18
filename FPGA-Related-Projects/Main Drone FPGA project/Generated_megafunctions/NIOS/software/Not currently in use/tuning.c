/*
 * tuning.c
 *
 *  Created on: Oct 11, 2019
 *      Author: eldal
 */

#include "tuning.h"


void TUNE_setup(int P, int I, int D, int neutral)
{
	TUNE_gain_P = P;
	TUNE_gain_I = I;
	TUNE_gain_D = D;
	TUNE_neutral_setpoint = neutral;
	PID_set_gains(P,I,D);
	CBO_set_pitch_and_roll_setpoints(neutral, 0);

}
void TUNE_oscillate()
{
	/*
	CBO_set_pitch_and_roll_setpoints(10 + TUNE_neutral_setpoint, 0);
	TUNE_report(10);
	CBO_set_pitch_and_roll_setpoints(-10 + TUNE_neutral_setpoint, 0);
	TUNE_report(-10);
	CBO_set_pitch_and_roll_setpoints(10 + TUNE_neutral_setpoint, 0);
	TUNE_report(10);
	CBO_set_pitch_and_roll_setpoints(0 + TUNE_neutral_setpoint, 0);
	TUNE_report(0);
	*/
	TUNE_slow_change_setpoint(0 + TUNE_neutral_setpoint, 10 + TUNE_neutral_setpoint, 20, 50);
	TUNE_report(10);
	TUNE_slow_change_setpoint(10 + TUNE_neutral_setpoint, -10 + TUNE_neutral_setpoint, 40, 50);
	TUNE_report(-10);
	TUNE_slow_change_setpoint(-10 + TUNE_neutral_setpoint, 10 + TUNE_neutral_setpoint, 40, 50);
	TUNE_report(10);
	TUNE_slow_change_setpoint(10 + TUNE_neutral_setpoint, 0 + TUNE_neutral_setpoint, 20, 50);
	TUNE_report(0);

}
void TUNE_manual()
{
	char yesno;
	printf("Want to change the PID settings? Y/N.\n");
	scanf("%c", &yesno);
	if(yesno == 'Y' || yesno == 'y')
	{
		printf("Okay. New P gain?: ");
		scanf("%d", &TUNE_gain_P);
		printf("New I gain?: ");
		scanf("%d", &TUNE_gain_I);
		printf("New D gain?: ");
		scanf("%d", &TUNE_gain_D);
		printf("Right. Setting new PID gains: %04i, %04i, %04i.\n", TUNE_gain_P, TUNE_gain_I, TUNE_gain_D);
		PID_set_gains(TUNE_gain_P, TUNE_gain_I, TUNE_gain_D);


	}
	else if (yesno == 'N' || yesno == 'n')
	{
		printf("Okay, continuing without changes.\n");
	}
	else
	{
		printf("Error. Read: %c\n", yesno);
	}
	scanf("%c", &yesno);
}
void TUNE_manual_stepped()
{
	printf("Enter starting values for PID.\n");
	int man_p, man_i, man_d, step_p, step_i, step_d, step_nr;
	char yesno[2];
	scanf("%d%d%d", &man_p, &man_i, &man_d);
	scanf("%*c");
	printf("You entered: %i, %i, %i. Is this correct? y/n.\n", man_p, man_i, man_d);
	scanf("%c", &yesno);
	if(yesno[0] == 'y' || yesno[0] == 'Y')
	{

		printf("Enter the stepsizes for the PID:\n");
		scanf("%d%d%d", &step_p, &step_i, &step_d);
		scanf("%*c");
		printf("How many steps?\n");
		scanf("%d", &step_nr);
		scanf("%*c");
		printf("Starting\n");
		TUNE_gain_P = man_p;
		TUNE_gain_I = man_i;
		TUNE_gain_D = man_d;
		PID_set_gains(TUNE_gain_P, TUNE_gain_I, TUNE_gain_D);
		TUNE_stepped(step_p, step_i, step_d, step_nr);
		TUNE_gain_P = TUNE_safe_P;
		TUNE_gain_I = TUNE_safe_I;
		TUNE_gain_D = TUNE_safe_D;
		PID_set_gains(TUNE_gain_P, TUNE_gain_I, TUNE_gain_D);
		printf("Returning to safe. Hit enter when done with data.");
		scanf("%c", &yesno);
		scanf("%*c");
	}
	else
	{
		printf("Returning\n");
		return;
	}


}
void TUNE_stepped(int change_p, int change_i, int change_d, int stepcount)
{
	printf("Step 0: \n------------------------------------------------------------------\n");
	TUNE_oscillate();
	for(int i = 0; i < stepcount; i++)
	{
		printf("Step %i: \n------------------------------------------------------------------\n", i+1);
		TUNE_gain_P += change_p;
		TUNE_gain_I += change_i;
		TUNE_gain_D += change_d;
		PID_set_gains(TUNE_gain_P, TUNE_gain_I, TUNE_gain_D);
		TUNE_oscillate();
	}
}
void TUNE_report(int setpoint)
{
	short pitch;
	int error;
	printf("Setpoint is: %4i. Gains are: P: %07i, I: %07i, D: %07i. Results:\n", setpoint, TUNE_gain_P, TUNE_gain_I, TUNE_gain_D);
	printf("time:    0250ms,   0500ms,   0750ms,   1000ms,   1250ms,   1500ms,   1750ms,   2000ms,   2500ms,   3000ms.\n");
	printf("Error: ");
	msleep(250);
	pitch = BNO_get_pitch();
	error = ((setpoint + TUNE_neutral_setpoint) *16) - pitch;
	printf("%4i/%3i, ", error, error/16);
	msleep(250);
	pitch = BNO_get_pitch();
	error = ((setpoint + TUNE_neutral_setpoint) *16) - pitch;
	printf("%4i/%3i, ", error, error/16);
	msleep(250);
	pitch = BNO_get_pitch();
	error = ((setpoint + TUNE_neutral_setpoint) *16) - pitch;
	printf("%4i/%3i, ", error, error/16);
	msleep(250);
	pitch = BNO_get_pitch();
	error = ((setpoint + TUNE_neutral_setpoint) *16) - pitch;
	printf("%4i/%3i, ", error, error/16);
	msleep(250);
	pitch = BNO_get_pitch();
	error = ((setpoint + TUNE_neutral_setpoint) *16) - pitch;
	printf("%4i/%3i, ", error, error/16);
	msleep(250);
	pitch = BNO_get_pitch();
	error = ((setpoint + TUNE_neutral_setpoint) *16) - pitch;
	printf("%4i/%3i, ", error, error/16);
	msleep(250);
	pitch = BNO_get_pitch();
	error = ((setpoint + TUNE_neutral_setpoint) *16) - pitch;
	printf("%4i/%3i, ", error, error/16);
	msleep(250);
	pitch = BNO_get_pitch();
	error = ((setpoint + TUNE_neutral_setpoint) *16) - pitch;
	printf("%4i/%3i, ", error, error/16);
	msleep(500);
	pitch = BNO_get_pitch();
	error = ((setpoint + TUNE_neutral_setpoint) *16) - pitch;
	printf("%4i/%3i, ", error, error/16);
	msleep(500);
	pitch = BNO_get_pitch();
	error = ((setpoint + TUNE_neutral_setpoint) *16) - pitch;
	printf("%4i/%3i,\n", error, error/16);

}
void TUNE_report_simple(int sample_time, int sample_number)
{

}
void TUNE_slow_change_setpoint(int start, int end, int stepcount, int steptime)
{
	int change = (end - start) * 16;
	int stepsize = change / stepcount;
	int setpoint = start * 16;
	for(int i = 0;i < stepcount;i++)
	{
		setpoint += stepsize;
		CBO_set_pitch_and_roll_setpoints_precise(setpoint, 0);
		msleep(steptime);
	}

}
