EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 13 15
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Cyclone10LP_040:10CL040_F484 U1201
U 5 1 5F4CDD3F
P 5350 600
F 0 "U1201" H 5350 650 35  0000 L CNN
F 1 "10CL040_F484" H 6400 -5325 35  0001 L CNN
F 2 "SamacSys_Parts:BGA484C100P22X22_2300X2300X200" H 6400 -5370 35  0001 L CNN
F 3 "" H 5350 600 50  0001 C CNN
F 4 "TRUE" H 6400 -5415 35  0001 L CNN "SPLIT_INST"
F 5 "(S1+S2+S3+S4+S5+S6+S7+S8+S9+S10+S11+S12+S13)" H 6400 -5460 35  0001 L CNN "SWAP_INFO"
	5    5350 600 
	1    0    0    -1  
$EndComp
$Comp
L Cyclone10LP_040:10CL040_F484 U1201
U 6 1 5F4D5123
P 8250 600
F 0 "U1201" H 8250 650 35  0000 L CNN
F 1 "10CL040_F484" H 9300 -5325 35  0001 L CNN
F 2 "SamacSys_Parts:BGA484C100P22X22_2300X2300X200" H 9300 -5370 35  0001 L CNN
F 3 "" H 8250 600 50  0001 C CNN
F 4 "TRUE" H 9300 -5415 35  0001 L CNN "SPLIT_INST"
F 5 "(S1+S2+S3+S4+S5+S6+S7+S8+S9+S10+S11+S12+S13)" H 9300 -5460 35  0001 L CNN "SWAP_INFO"
	6    8250 600 
	1    0    0    -1  
$EndComp
$Comp
L Cyclone10LP_040:10CL040_F484 U1201
U 7 1 5F4E58F6
P 10500 650
F 0 "U1201" H 10500 700 35  0000 L CNN
F 1 "10CL040_F484" H 11550 -5275 35  0001 L CNN
F 2 "SamacSys_Parts:BGA484C100P22X22_2300X2300X200" H 11550 -5320 35  0001 L CNN
F 3 "" H 10500 650 50  0001 C CNN
F 4 "TRUE" H 11550 -5365 35  0001 L CNN "SPLIT_INST"
F 5 "(S1+S2+S3+S4+S5+S6+S7+S8+S9+S10+S11+S12+S13)" H 11550 -5410 35  0001 L CNN "SWAP_INFO"
	7    10500 650 
	1    0    0    -1  
$EndComp
Text GLabel 1500 650  0    50   Input ~ 0
nRF_CE
Text GLabel 1500 750  0    50   Input ~ 0
nRF_CSn
Text GLabel 1500 850  0    50   Input ~ 0
nRF_SCLK
Wire Wire Line
	1500 650  1650 650 
Wire Wire Line
	1500 750  1650 750 
Wire Wire Line
	1500 850  1650 850 
Text Label 1650 650  0    50   ~ 0
nRF_CE
Text Label 1650 750  0    50   ~ 0
nRF_CSn
Text Label 1650 850  0    50   ~ 0
nRF_SCLK
Wire Wire Line
	10300 2700 10100 2700
Wire Wire Line
	10300 2800 10100 2800
Wire Wire Line
	10300 2900 10100 2900
Text Label 10100 2700 2    50   ~ 0
nRF_CE
Text Label 10100 2800 2    50   ~ 0
nRF_CSn
Text Label 10100 2900 2    50   ~ 0
nRF_SCLK
Wire Wire Line
	1550 2550 1650 2550
Wire Wire Line
	1550 2350 1650 2350
Wire Wire Line
	1550 2150 1650 2150
Wire Wire Line
	1550 1950 1650 1950
Wire Wire Line
	1550 1750 1650 1750
Wire Wire Line
	1550 1550 1650 1550
Wire Wire Line
	1550 1350 1650 1350
Wire Wire Line
	1550 1150 1650 1150
Text Label 1650 2550 0    50   ~ 0
GPIO1-0
Text Label 1650 2350 0    50   ~ 0
GPIO1-2
Text Label 1650 2150 0    50   ~ 0
GPIO1-4
Text Label 1650 1950 0    50   ~ 0
GPIO1-6
Text Label 1650 1750 0    50   ~ 0
GPIO1-8
Text Label 1650 1550 0    50   ~ 0
GPIO1-10
Text Label 1650 1350 0    50   ~ 0
GPIO1-12
Text Label 1650 1150 0    50   ~ 0
GPIO1-14
Wire Wire Line
	1550 2450 1650 2450
Wire Wire Line
	1550 2250 1650 2250
Wire Wire Line
	1550 2050 1650 2050
Wire Wire Line
	1550 1850 1650 1850
Wire Wire Line
	1550 1650 1650 1650
Wire Wire Line
	1550 1450 1650 1450
Wire Wire Line
	1550 1250 1650 1250
Wire Wire Line
	1550 1050 1650 1050
Text Label 1650 2450 0    50   ~ 0
GPIO1-1
Text Label 1650 2250 0    50   ~ 0
GPIO1-3
Text Label 1650 2050 0    50   ~ 0
GPIO1-5
Text Label 1650 1850 0    50   ~ 0
GPIO1-7
Text Label 1650 1650 0    50   ~ 0
GPIO1-9
Text Label 1650 1450 0    50   ~ 0
GPIO1-11
Text Label 1650 1250 0    50   ~ 0
GPIO1-13
Text Label 1650 1050 0    50   ~ 0
GPIO1-15
Text GLabel 1550 2550 0    50   Input ~ 0
GPIO1-0
Text GLabel 1550 2450 0    50   Input ~ 0
GPIO1-1
Text GLabel 1550 2350 0    50   Input ~ 0
GPIO1-2
Text GLabel 1550 2250 0    50   Input ~ 0
GPIO1-3
Text GLabel 1550 2150 0    50   Input ~ 0
GPIO1-4
Text GLabel 1550 2050 0    50   Input ~ 0
GPIO1-5
Text GLabel 1550 1950 0    50   Input ~ 0
GPIO1-6
Text GLabel 1550 1850 0    50   Input ~ 0
GPIO1-7
Text GLabel 1550 1750 0    50   Input ~ 0
GPIO1-8
Text GLabel 1550 1650 0    50   Input ~ 0
GPIO1-9
Text GLabel 1550 1550 0    50   Input ~ 0
GPIO1-10
Text GLabel 1550 1450 0    50   Input ~ 0
GPIO1-11
Text GLabel 1550 1350 0    50   Input ~ 0
GPIO1-12
Text GLabel 1550 1250 0    50   Input ~ 0
GPIO1-13
Text GLabel 1550 1150 0    50   Input ~ 0
GPIO1-14
Text GLabel 1550 1050 0    50   Input ~ 0
GPIO1-15
Wire Wire Line
	8050 2150 7950 2150
Wire Wire Line
	8050 2350 7950 2350
Wire Wire Line
	10300 2100 10200 2100
Wire Wire Line
	10300 1700 10200 1700
Wire Wire Line
	10300 1300 10200 1300
Wire Wire Line
	10300 900  10200 900 
Wire Wire Line
	10300 700  10200 700 
Wire Wire Line
	8050 3750 7950 3750
Text Label 7950 2150 2    50   ~ 0
GPIO1-0
Text Label 7950 2450 2    50   ~ 0
GPIO1-2
Text Label 10200 2100 2    50   ~ 0
GPIO1-4
Text Label 10200 1700 2    50   ~ 0
GPIO1-6
Text Label 10200 1300 2    50   ~ 0
GPIO1-8
Text Label 10200 900  2    50   ~ 0
GPIO1-10
Text Label 10200 700  2    50   ~ 0
GPIO1-12
Text Label 7950 3750 2    50   ~ 0
GPIO1-14
Wire Wire Line
	8050 2050 7950 2050
Wire Wire Line
	8050 2450 7950 2450
Wire Wire Line
	10300 2200 10200 2200
Wire Wire Line
	10300 1800 10200 1800
Wire Wire Line
	10300 1400 10200 1400
Wire Wire Line
	10300 1000 10200 1000
Wire Wire Line
	10300 800  10200 800 
Wire Wire Line
	8050 3650 7950 3650
Text Label 7950 2050 2    50   ~ 0
GPIO1-1
Text Label 7950 2350 2    50   ~ 0
GPIO1-3
Text Label 10200 2200 2    50   ~ 0
GPIO1-5
Text Label 10200 1800 2    50   ~ 0
GPIO1-7
Text Label 10200 1400 2    50   ~ 0
GPIO1-9
Text Label 10200 1000 2    50   ~ 0
GPIO1-11
Text Label 10200 800  2    50   ~ 0
GPIO1-13
Text Label 7950 3650 2    50   ~ 0
GPIO1-15
Wire Wire Line
	1650 3100 1550 3100
Wire Wire Line
	1650 3000 1550 3000
Wire Wire Line
	1650 2900 1550 2900
Wire Wire Line
	1650 2800 1550 2800
Text Label 1650 3100 0    50   ~ 0
DPS_SCLK
Text Label 1650 3000 0    50   ~ 0
DPS_CSn
Text Label 1650 2900 0    50   ~ 0
DPS_MOSI
Text Label 1650 2800 0    50   ~ 0
DPS_MISO
Text GLabel 1550 3100 0    50   Input ~ 0
DPS_SCLK
Text GLabel 1550 3000 0    50   Input ~ 0
DPS_CSn
Text GLabel 1550 2900 0    50   Input ~ 0
DPS_MOSI
Text GLabel 1550 2800 0    50   Input ~ 0
DPS_MISO
Wire Wire Line
	7950 1150 8050 1150
Wire Wire Line
	7950 650  8050 650 
Wire Wire Line
	7950 750  8050 750 
Wire Wire Line
	7950 1250 8050 1250
Text Label 7950 1150 2    50   ~ 0
DPS_SCLK
Text Label 7950 650  2    50   ~ 0
DPS_CSn
Text Label 7950 750  2    50   ~ 0
DPS_MOSI
Text Label 7950 1250 2    50   ~ 0
DPS_MISO
Text GLabel 1550 3600 0    50   Input ~ 0
5v_GPIO_0
Text GLabel 1550 3500 0    50   Input ~ 0
5v_GPIO_1
Text GLabel 1550 3400 0    50   Input ~ 0
5v_GPIO_2
Text GLabel 1550 3300 0    50   Input ~ 0
5v_GPIO_3
Wire Wire Line
	1550 3300 1650 3300
Wire Wire Line
	1550 3400 1650 3400
Wire Wire Line
	1550 3500 1650 3500
Wire Wire Line
	1550 3600 1650 3600
Text Label 1650 3300 0    50   ~ 0
5v_GPIO_3
Text Label 1650 3400 0    50   ~ 0
5v_GPIO_2
Text Label 1650 3500 0    50   ~ 0
5v_GPIO_1
Text Label 1650 3600 0    50   ~ 0
5v_GPIO_0
Wire Wire Line
	5150 3050 5050 3050
Wire Wire Line
	5150 2950 5050 2950
Wire Wire Line
	5150 3350 5050 3350
Wire Wire Line
	5150 3450 5050 3450
Text Label 5050 2950 2    50   ~ 0
5v_GPIO_3
Text Label 5050 3050 2    50   ~ 0
5v_GPIO_2
Text Label 5050 3350 2    50   ~ 0
5v_GPIO_1
Text Label 5050 3450 2    50   ~ 0
5v_GPIO_0
Wire Wire Line
	1550 4100 1650 4100
Wire Wire Line
	1550 4000 1650 4000
Wire Wire Line
	1550 3900 1650 3900
Wire Wire Line
	1550 3800 1650 3800
Text Label 1650 4100 0    50   ~ 0
ADC_CSn
Text Label 1650 4000 0    50   ~ 0
ADC_MOSI
Text Label 1650 3900 0    50   ~ 0
ADC_MISO
Text Label 1650 3800 0    50   ~ 0
ADC_SCLK
Text GLabel 1550 4100 0    50   Input ~ 0
ADC_CSn
Text GLabel 1550 4000 0    50   Input ~ 0
ADC_MOSI
Text GLabel 1550 3900 0    50   Input ~ 0
ADC_MISO
Text GLabel 1550 3800 0    50   Input ~ 0
ADC_SCLK
Wire Wire Line
	5150 2850 5050 2850
Wire Wire Line
	5150 4450 5050 4450
Wire Wire Line
	5150 1650 5050 1650
Wire Wire Line
	5150 1550 5050 1550
Text Label 5050 2850 2    50   ~ 0
ADC_CSn
Text Label 5050 4450 2    50   ~ 0
ADC_MOSI
Text Label 5050 1650 2    50   ~ 0
ADC_MISO
Text Label 5050 1550 2    50   ~ 0
ADC_SCLK
Text Label 1650 4800 0    50   ~ 0
FTDI-ACBUS4
Text Label 1650 4700 0    50   ~ 0
FTDI-ACBUS5
Text Label 1650 4600 0    50   ~ 0
FTDI-ACBUS6
Text Label 1650 4500 0    50   ~ 0
FTDI-ACBUS7
Wire Wire Line
	1650 4800 1550 4800
Wire Wire Line
	1650 4700 1550 4700
Wire Wire Line
	1650 4600 1550 4600
Wire Wire Line
	1650 4500 1550 4500
Text GLabel 1550 4800 0    50   Input ~ 0
FTDI-ACBUS4
Text GLabel 1550 4700 0    50   Input ~ 0
FTDI-ACBUS5
Text GLabel 1550 4600 0    50   Input ~ 0
FTDI-ACBUS6
Text GLabel 1550 4500 0    50   Input ~ 0
FTDI-ACBUS7
Text Label 1650 4400 0    50   ~ 0
FTDI-ACBUS8
Text Label 1650 4300 0    50   ~ 0
FTDI-ACBUS9
Wire Wire Line
	1650 4400 1550 4400
Wire Wire Line
	1650 4300 1550 4300
Text GLabel 1550 4400 0    50   Input ~ 0
FTDI-ACBUS8
Text GLabel 1550 4300 0    50   Input ~ 0
FTDI-ACBUS9
Text Label 5050 650  2    50   ~ 0
FTDI-ACBUS4
Text Label 5050 750  2    50   ~ 0
FTDI-ACBUS5
Text Label 5050 850  2    50   ~ 0
FTDI-ACBUS6
Text Label 5050 950  2    50   ~ 0
FTDI-ACBUS7
Wire Wire Line
	5050 650  5150 650 
Wire Wire Line
	5050 750  5150 750 
Wire Wire Line
	5050 850  5150 850 
Wire Wire Line
	5050 950  5150 950 
Text Label 5050 1250 2    50   ~ 0
FTDI-ACBUS8
Text Label 5050 1350 2    50   ~ 0
FTDI-ACBUS9
Wire Wire Line
	5050 1250 5150 1250
Wire Wire Line
	5050 1350 5150 1350
NoConn ~ 5150 1150
NoConn ~ 5150 1050
NoConn ~ 5150 1450
NoConn ~ 5150 1750
NoConn ~ 5150 1850
NoConn ~ 5150 1950
NoConn ~ 5150 2050
NoConn ~ 5150 2150
NoConn ~ 5150 2250
NoConn ~ 5150 2350
NoConn ~ 5150 2450
NoConn ~ 5150 2550
NoConn ~ 5150 2650
NoConn ~ 5150 2750
NoConn ~ 5150 3150
NoConn ~ 5150 3250
NoConn ~ 5150 3550
NoConn ~ 5150 3650
NoConn ~ 5150 3750
NoConn ~ 5150 3850
NoConn ~ 5150 3950
NoConn ~ 5150 4050
NoConn ~ 5150 4250
NoConn ~ 5150 4350
NoConn ~ 5150 4550
NoConn ~ 8050 1050
NoConn ~ 8050 950 
NoConn ~ 8050 850 
NoConn ~ 8050 1350
NoConn ~ 8050 1450
NoConn ~ 8050 1550
NoConn ~ 8050 1650
NoConn ~ 8050 1750
NoConn ~ 8050 1850
NoConn ~ 8050 1950
NoConn ~ 8050 2250
NoConn ~ 8050 2550
NoConn ~ 8050 2650
NoConn ~ 8050 2750
NoConn ~ 8050 2850
NoConn ~ 8050 2950
NoConn ~ 8050 3050
NoConn ~ 8050 3150
NoConn ~ 8050 3250
NoConn ~ 8050 3350
NoConn ~ 8050 3450
NoConn ~ 8050 3550
NoConn ~ 8050 3950
NoConn ~ 8050 3850
NoConn ~ 8050 4150
NoConn ~ 8050 4250
NoConn ~ 8050 4350
NoConn ~ 8050 4450
NoConn ~ 10300 3800
NoConn ~ 10300 3700
NoConn ~ 10300 3600
NoConn ~ 10300 3500
NoConn ~ 10300 3300
NoConn ~ 10300 3200
NoConn ~ 10300 3100
NoConn ~ 10300 3000
NoConn ~ 10300 2600
NoConn ~ 10300 2500
NoConn ~ 10300 2400
NoConn ~ 10300 2300
NoConn ~ 10300 2000
NoConn ~ 10300 1900
NoConn ~ 10300 1600
NoConn ~ 10300 1500
NoConn ~ 10300 1200
NoConn ~ 10300 1100
$EndSCHEMATC
