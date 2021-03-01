EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 3 15
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text HLabel 8250 3450 2    67   Output ~ 0
5v-regulator-out
$Comp
L SamacSys_Parts:AP63205WU-7 U301
U 1 1 5F62701B
P 4300 3200
F 0 "U301" H 4800 3475 50  0000 C CNN
F 1 "AP63205WU-7" H 4800 3384 50  0000 C CNN
F 2 "SOT95P280X100-6N" H 5150 3300 50  0001 L CNN
F 3 "https://www.diodes.com/assets/Datasheets/AP63200-AP63201-AP63203-AP63205.pdf" H 5150 3200 50  0001 L CNN
F 4 "Switching Voltage Regulators DCDC Conv HV Buck TSOT26 T&R 3K" H 5150 3100 50  0001 L CNN "Description"
F 5 "AP63205WU-7" H 4300 3200 50  0001 C CNN "MfNr"
	1    4300 3200
	1    0    0    -1  
$EndComp
$Comp
L Device:L L301
U 1 1 5F6280C9
P 6300 3450
F 0 "L301" V 6490 3450 50  0000 C CNN
F 1 "4.7uH 2.6ADC" V 6399 3450 50  0000 C CNN
F 2 "Eldalote-footprints:L_5030_TAIYO_YUDEN" H 6300 3450 50  0001 C CNN
F 3 "~" H 6300 3450 50  0001 C CNN
F 4 "NRS5030T4R7MMGJ" V 6300 3450 50  0001 C CNN "MfNR"
	1    6300 3450
	0    -1   -1   0   
$EndComp
$Comp
L Device:C_Small C302
U 1 1 5F628DE0
P 5400 3300
F 0 "C302" H 5492 3346 50  0000 L CNN
F 1 "100nF 25v" H 5492 3255 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 5400 3300 50  0001 C CNN
F 3 "~" H 5400 3300 50  0001 C CNN
F 4 "CL21B104KACNNNC" H 5400 3300 50  0001 C CNN "MfNr"
	1    5400 3300
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C301
U 1 1 5F629D01
P 3750 3300
F 0 "C301" H 3842 3346 50  0000 L CNN
F 1 "10uF 25v" H 3842 3255 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 3750 3300 50  0001 C CNN
F 3 "~" H 3750 3300 50  0001 C CNN
F 4 "CL21A106KAYNNNG" H 3750 3300 50  0001 C CNN "MfNr"
	1    3750 3300
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C303
U 1 1 5F62A1BB
P 7050 3600
F 0 "C303" H 6800 3650 50  0000 L CNN
F 1 "22uF 25v" H 6600 3550 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 7050 3600 50  0001 C CNN
F 3 "~" H 7050 3600 50  0001 C CNN
F 4 "CL21A226MAQNNNE" H 7050 3600 50  0001 C CNN "MfNr"
	1    7050 3600
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C304
U 1 1 5F62AF34
P 7250 3600
F 0 "C304" H 7342 3646 50  0000 L CNN
F 1 "22uF 25v" H 7342 3555 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 7250 3600 50  0001 C CNN
F 3 "~" H 7250 3600 50  0001 C CNN
F 4 "CL21A226MAQNNNE" H 7250 3600 50  0001 C CNN "MfNr"
	1    7250 3600
	1    0    0    -1  
$EndComp
Wire Wire Line
	5300 3450 5400 3450
Wire Wire Line
	5400 3400 5400 3450
Connection ~ 5400 3450
Wire Wire Line
	5400 3450 6150 3450
Wire Wire Line
	5400 3200 5400 3150
Wire Wire Line
	5400 3150 5300 3150
Wire Wire Line
	4300 3150 4250 3150
Wire Wire Line
	3750 3150 3750 3200
Wire Wire Line
	3750 3150 3300 3150
Connection ~ 3750 3150
Wire Wire Line
	4300 3450 4250 3450
Wire Wire Line
	4250 3450 4250 3150
Connection ~ 4250 3150
Wire Wire Line
	4250 3150 3750 3150
Wire Wire Line
	3750 3400 3750 3900
Wire Wire Line
	6450 3450 6550 3450
Wire Wire Line
	7050 3450 7050 3500
Connection ~ 7050 3450
Wire Wire Line
	7050 3450 7250 3450
Wire Wire Line
	7250 3450 7250 3500
Connection ~ 7250 3450
Wire Wire Line
	7250 3450 8250 3450
Wire Wire Line
	7050 3700 7050 3900
Wire Wire Line
	7250 3700 7250 3900
Wire Wire Line
	5300 3600 6550 3600
Wire Wire Line
	6550 3600 6550 3450
Connection ~ 6550 3450
Wire Wire Line
	6550 3450 7050 3450
$Comp
L power:+10V #PWR0301
U 1 1 5F62DA8E
P 3300 3150
F 0 "#PWR0301" H 3300 3000 50  0001 C CNN
F 1 "+10V" H 3315 3323 50  0000 C CNN
F 2 "" H 3300 3150 50  0001 C CNN
F 3 "" H 3300 3150 50  0001 C CNN
	1    3300 3150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0302
U 1 1 5F62DFB0
P 3750 3900
F 0 "#PWR0302" H 3750 3650 50  0001 C CNN
F 1 "GND" H 3755 3727 50  0000 C CNN
F 2 "" H 3750 3900 50  0001 C CNN
F 3 "" H 3750 3900 50  0001 C CNN
	1    3750 3900
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0303
U 1 1 5F62E4B9
P 4800 3900
F 0 "#PWR0303" H 4800 3650 50  0001 C CNN
F 1 "GND" H 4805 3727 50  0000 C CNN
F 2 "" H 4800 3900 50  0001 C CNN
F 3 "" H 4800 3900 50  0001 C CNN
	1    4800 3900
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0304
U 1 1 5F62E6DC
P 7050 3900
F 0 "#PWR0304" H 7050 3650 50  0001 C CNN
F 1 "GND" H 7055 3727 50  0000 C CNN
F 2 "" H 7050 3900 50  0001 C CNN
F 3 "" H 7050 3900 50  0001 C CNN
	1    7050 3900
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0305
U 1 1 5F62EA06
P 7250 3900
F 0 "#PWR0305" H 7250 3650 50  0001 C CNN
F 1 "GND" H 7255 3727 50  0000 C CNN
F 2 "" H 7250 3900 50  0001 C CNN
F 3 "" H 7250 3900 50  0001 C CNN
	1    7250 3900
	1    0    0    -1  
$EndComp
Text Label 5350 3150 0    50   ~ 0
5v_BST
Text Label 5650 3450 0    50   ~ 0
5v_SW
$EndSCHEMATC
