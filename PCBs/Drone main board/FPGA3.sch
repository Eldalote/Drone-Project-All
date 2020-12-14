EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 14 15
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
U 8 1 5F4F44FA
P 8250 600
F 0 "U1201" H 8250 650 35  0000 L CNN
F 1 "10CL040_F484" H 9300 -5325 35  0001 L CNN
F 2 "SamacSys_Parts:BGA484C100P22X22_2300X2300X200" H 9300 -5370 35  0001 L CNN
F 3 "" H 8250 600 50  0001 C CNN
F 4 "TRUE" H 9300 -5415 35  0001 L CNN "SPLIT_INST"
F 5 "(S1+S2+S3+S4+S5+S6+S7+S8+S9+S10+S11+S12+S13)" H 9300 -5460 35  0001 L CNN "SWAP_INFO"
	8    8250 600 
	1    0    0    -1  
$EndComp
$Comp
L Cyclone10LP_040:10CL040_F484 U1201
U 9 1 5F5011A2
P 10450 600
F 0 "U1201" H 10450 650 35  0000 L CNN
F 1 "10CL040_F484" H 11500 -5325 35  0001 L CNN
F 2 "SamacSys_Parts:BGA484C100P22X22_2300X2300X200" H 11500 -5370 35  0001 L CNN
F 3 "" H 10450 600 50  0001 C CNN
F 4 "TRUE" H 11500 -5415 35  0001 L CNN "SPLIT_INST"
F 5 "(S1+S2+S3+S4+S5+S6+S7+S8+S9+S10+S11+S12+S13)" H 11500 -5460 35  0001 L CNN "SWAP_INFO"
	9    10450 600 
	1    0    0    -1  
$EndComp
$Comp
L Cyclone10LP_040:10CL040_F484 U1201
U 10 1 5F50A9B4
P 6100 5350
F 0 "U1201" H 6100 5400 35  0000 L CNN
F 1 "10CL040_F484" H 7150 -575 35  0001 L CNN
F 2 "SamacSys_Parts:BGA484C100P22X22_2300X2300X200" H 7150 -620 35  0001 L CNN
F 3 "" H 6100 5350 50  0001 C CNN
F 4 "TRUE" H 7150 -665 35  0001 L CNN "SPLIT_INST"
F 5 "(S1+S2+S3+S4+S5+S6+S7+S8+S9+S10+S11+S12+S13)" H 7150 -710 35  0001 L CNN "SWAP_INFO"
	10   6100 5350
	1    0    0    -1  
$EndComp
$Comp
L Cyclone10LP_040:10CL040_F484 U1201
U 11 1 5F515CFB
P 2050 5200
F 0 "U1201" H 2050 5300 35  0000 L CNN
F 1 "10CL040_F484" H 3100 -725 35  0001 L CNN
F 2 "SamacSys_Parts:BGA484C100P22X22_2300X2300X200" H 3100 -770 35  0001 L CNN
F 3 "" H 2050 5200 50  0001 C CNN
F 4 "TRUE" H 3100 -815 35  0001 L CNN "SPLIT_INST"
F 5 "(S1+S2+S3+S4+S5+S6+S7+S8+S9+S10+S11+S12+S13)" H 3100 -860 35  0001 L CNN "SWAP_INFO"
	11   2050 5200
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint_Small TP1401
U 1 1 5F82D34F
P 1300 5500
F 0 "TP1401" H 1000 5500 50  0000 L CNN
F 1 "TestPoint_Small" H 1348 5455 50  0001 L CNN
F 2 "TestPoint:TestPoint_Pad_D1.0mm" H 1500 5500 50  0001 C CNN
F 3 "~" H 1500 5500 50  0001 C CNN
	1    1300 5500
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint_Small TP1402
U 1 1 5F82EEDE
P 1300 5600
F 0 "TP1402" H 1000 5600 50  0000 L CNN
F 1 "TestPoint_Small" H 1348 5555 50  0001 L CNN
F 2 "TestPoint:TestPoint_Pad_D1.0mm" H 1500 5600 50  0001 C CNN
F 3 "~" H 1500 5600 50  0001 C CNN
	1    1300 5600
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint_Small TP1403
U 1 1 5F832777
P 1300 5700
F 0 "TP1403" H 1000 5700 50  0000 L CNN
F 1 "TestPoint_Small" H 1348 5655 50  0001 L CNN
F 2 "TestPoint:TestPoint_Pad_D1.0mm" H 1500 5700 50  0001 C CNN
F 3 "~" H 1500 5700 50  0001 C CNN
	1    1300 5700
	1    0    0    -1  
$EndComp
Wire Wire Line
	1850 5500 1450 5500
Wire Wire Line
	1850 5600 1300 5600
Wire Wire Line
	1850 5700 1300 5700
$Comp
L Device:R R1402
U 1 1 5F835D50
P 4150 5500
F 0 "R1402" V 4050 5550 50  0000 C CNN
F 1 "10k" V 4150 5500 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 4080 5500 50  0001 C CNN
F 3 "~" H 4150 5500 50  0001 C CNN
F 4 "C25744" V 4150 5500 50  0001 C CNN "LCSC"
	1    4150 5500
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR01402
U 1 1 5F83790A
P 4650 6200
F 0 "#PWR01402" H 4650 5950 50  0001 C CNN
F 1 "GND" H 4800 6150 50  0000 C CNN
F 2 "" H 4650 6200 50  0001 C CNN
F 3 "" H 4650 6200 50  0001 C CNN
	1    4650 6200
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR01404
U 1 1 5F83C41B
P 4250 5200
F 0 "#PWR01404" H 4250 5050 50  0001 C CNN
F 1 "+3.3V" H 4265 5373 50  0000 C CNN
F 2 "" H 4250 5200 50  0001 C CNN
F 3 "" H 4250 5200 50  0001 C CNN
	1    4250 5200
	1    0    0    -1  
$EndComp
Wire Wire Line
	4250 5300 4250 5200
$Comp
L Device:R R1403
U 1 1 5F6C10EB
P 4350 5600
F 0 "R1403" V 4250 5650 50  0000 C CNN
F 1 "10k" V 4350 5600 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 4280 5600 50  0001 C CNN
F 3 "~" H 4350 5600 50  0001 C CNN
F 4 "C25744" V 4350 5600 50  0001 C CNN "LCSC"
	1    4350 5600
	-1   0    0    1   
$EndComp
Wire Wire Line
	4150 5700 4150 5650
Wire Wire Line
	4350 5800 4350 5750
Wire Wire Line
	3400 5800 4350 5800
Wire Wire Line
	4150 5350 4150 5300
Wire Wire Line
	4150 5300 4250 5300
Wire Wire Line
	4350 5450 4350 5300
Wire Wire Line
	4350 5300 4250 5300
Connection ~ 4250 5300
$Comp
L Device:R R1401
U 1 1 5F6C8806
P 1450 5300
F 0 "R1401" V 1350 5300 50  0000 C CNN
F 1 "10k" V 1450 5300 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 1380 5300 50  0001 C CNN
F 3 "~" H 1450 5300 50  0001 C CNN
F 4 "C25744" V 1450 5300 50  0001 C CNN "LCSC"
	1    1450 5300
	-1   0    0    1   
$EndComp
Wire Wire Line
	1450 5450 1450 5500
Connection ~ 1450 5500
Wire Wire Line
	1450 5500 1300 5500
Wire Wire Line
	1450 5150 1450 5100
$Comp
L power:+3.3V #PWR01401
U 1 1 5F6CB36D
P 1450 5100
F 0 "#PWR01401" H 1450 4950 50  0001 C CNN
F 1 "+3.3V" H 1465 5273 50  0000 C CNN
F 2 "" H 1450 5100 50  0001 C CNN
F 3 "" H 1450 5100 50  0001 C CNN
	1    1450 5100
	1    0    0    -1  
$EndComp
Wire Wire Line
	3400 6100 3550 6100
Wire Wire Line
	3400 6200 3550 6200
Wire Wire Line
	3400 6300 3550 6300
Wire Wire Line
	3400 6400 3550 6400
Wire Wire Line
	1600 1450 1500 1450
Text Label 1600 1450 0    50   ~ 0
Conf_flash_CLK
Text Label 1600 1350 0    50   ~ 0
Conf_flash_CSn
Text Label 1600 1250 0    50   ~ 0
Conf_flash_MISO
Text Label 1600 1150 0    50   ~ 0
Conf_flash_MOSI
Text GLabel 1500 1450 0    50   Input ~ 0
Conf_flash_CLK
Text GLabel 1500 1350 0    50   Input ~ 0
Conf_flash_CSn
Text GLabel 1500 1250 0    50   Input ~ 0
Conf_flash_MISO
Text GLabel 1500 1150 0    50   Input ~ 0
Conf_flash_MOSI
Wire Wire Line
	1600 1350 1500 1350
Wire Wire Line
	1600 1250 1500 1250
Wire Wire Line
	1600 1150 1500 1150
Text Label 3550 6100 0    50   ~ 0
Conf_flash_CLK
Text Label 3550 6200 0    50   ~ 0
Conf_flash_MISO
Text Label 3550 6300 0    50   ~ 0
Conf_flash_CSn
Text Label 3550 6400 0    50   ~ 0
Conf_flash_MOSI
NoConn ~ 1850 5800
NoConn ~ 1850 5200
NoConn ~ 1850 5300
Wire Wire Line
	3400 6700 3600 6700
$Comp
L power:GND #PWR01403
U 1 1 5F7198E9
P 3600 6700
F 0 "#PWR01403" H 3600 6450 50  0001 C CNN
F 1 "GND" H 3750 6650 50  0000 C CNN
F 2 "" H 3600 6700 50  0001 C CNN
F 3 "" H 3600 6700 50  0001 C CNN
	1    3600 6700
	1    0    0    -1  
$EndComp
Wire Wire Line
	3400 6800 4550 6800
Wire Wire Line
	4550 6800 4550 6600
Wire Wire Line
	3400 6600 4550 6600
Connection ~ 4550 6600
Wire Wire Line
	4550 6600 4550 6550
Wire Wire Line
	3400 6900 4550 6900
Wire Wire Line
	4550 6900 4550 6800
Connection ~ 4550 6800
$Comp
L Eldalote-Power:VCCA #PWR01405
U 1 1 5F727E62
P 4550 6550
F 0 "#PWR01405" H 4550 6400 50  0001 C CNN
F 1 "VCCA" H 4565 6723 50  0000 C CNN
F 2 "" H 4550 6550 50  0001 C CNN
F 3 "" H 4550 6550 50  0001 C CNN
	1    4550 6550
	1    0    0    -1  
$EndComp
Wire Wire Line
	3400 5200 3500 5200
Wire Wire Line
	3400 5300 3500 5300
Wire Wire Line
	3400 5400 3500 5400
Wire Wire Line
	3400 5500 3500 5500
Text Label 3500 5200 0    50   ~ 0
JTAG_TCK
Text Label 3500 5300 0    50   ~ 0
JTAG_TMS
Text Label 3500 5400 0    50   ~ 0
JTAG_TDI
Text Label 3500 5500 0    50   ~ 0
JTAG_TDO
Wire Wire Line
	1600 950  1500 950 
Wire Wire Line
	1600 850  1500 850 
Wire Wire Line
	1600 750  1500 750 
Wire Wire Line
	1600 650  1500 650 
Text Label 1600 950  0    50   ~ 0
JTAG_TCK
Text Label 1600 850  0    50   ~ 0
JTAG_TMS
Text Label 1600 750  0    50   ~ 0
JTAG_TDI
Text Label 1600 650  0    50   ~ 0
JTAG_TDO
Text GLabel 1500 950  0    50   Input ~ 0
JTAG_TCK
Text GLabel 1500 850  0    50   Input ~ 0
JTAG_TMS
Text GLabel 1500 750  0    50   Input ~ 0
JTAG_TDI
Text GLabel 1500 650  0    50   Input ~ 0
JTAG_TDO
Text Label 3650 5700 0    50   ~ 0
~CONFIG
Text Label 3650 5800 0    50   ~ 0
~STATUS
Text Label 1400 5500 0    50   ~ 0
CONF_DONE
Text Label 1400 5600 0    50   ~ 0
INIT_DONE
Text Label 1400 5700 0    50   ~ 0
CRC_ERROR
Text GLabel 1500 1650 0    50   Input ~ 0
nRF_MOSI
Text GLabel 1500 1750 0    50   Input ~ 0
nRF_MISO
Text GLabel 1500 1850 0    50   Input ~ 0
nRF_IRQ
Wire Wire Line
	1500 1650 1600 1650
Wire Wire Line
	1500 1750 1600 1750
Wire Wire Line
	1500 1850 1600 1850
Text Label 1600 1650 0    50   ~ 0
nRF_MOSI
Text Label 1600 1750 0    50   ~ 0
nRF_MISO
Text Label 1600 1850 0    50   ~ 0
nRF_IRQ
Wire Wire Line
	8050 2050 7750 2050
Wire Wire Line
	8050 1650 7750 1650
Wire Wire Line
	8050 1750 7750 1750
Text Label 7750 1650 2    50   ~ 0
nRF_MOSI
Text Label 7750 1750 2    50   ~ 0
nRF_IRQ
Text Label 7750 2050 2    50   ~ 0
nRF_MISO
$Comp
L Device:R R1404
U 1 1 5F985C02
P 4650 6050
F 0 "R1404" V 4550 6100 50  0000 C CNN
F 1 "10k" V 4650 6050 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 4580 6050 50  0001 C CNN
F 3 "~" H 4650 6050 50  0001 C CNN
F 4 "C25744" V 4650 6050 50  0001 C CNN "LCSC"
	1    4650 6050
	-1   0    0    1   
$EndComp
Text Label 3650 5900 0    50   ~ 0
~CE
Wire Wire Line
	1500 3550 1600 3550
Wire Wire Line
	1600 3450 1500 3450
Wire Wire Line
	1600 3350 1500 3350
Wire Wire Line
	1600 3250 1500 3250
Wire Wire Line
	1600 3150 1500 3150
Wire Wire Line
	1600 3050 1500 3050
Wire Wire Line
	1600 2950 1500 2950
Wire Wire Line
	1600 2850 1500 2850
Wire Wire Line
	1600 2750 1500 2750
Wire Wire Line
	1600 2650 1500 2650
Wire Wire Line
	1600 2550 1500 2550
Wire Wire Line
	1600 2450 1500 2450
Wire Wire Line
	1600 2350 1500 2350
Wire Wire Line
	1600 2250 1500 2250
Wire Wire Line
	1600 2150 1500 2150
Wire Wire Line
	1600 2050 1500 2050
Text Label 1600 3550 0    50   ~ 0
GPIO2-0
Text Label 1600 3450 0    50   ~ 0
GPIO2-1
Text Label 1600 3350 0    50   ~ 0
GPIO2-2
Text Label 1600 3250 0    50   ~ 0
GPIO2-3
Text Label 1600 3150 0    50   ~ 0
GPIO2-4
Text Label 1600 3050 0    50   ~ 0
GPIO2-5
Text Label 1600 2950 0    50   ~ 0
GPIO2-6
Text Label 1600 2850 0    50   ~ 0
GPIO2-7
Text Label 1600 2750 0    50   ~ 0
GPIO2-8
Text Label 1600 2650 0    50   ~ 0
GPIO2-9
Text Label 1600 2550 0    50   ~ 0
GPIO2-10
Text Label 1600 2450 0    50   ~ 0
GPIO2-11
Text Label 1600 2350 0    50   ~ 0
GPIO2-12
Text Label 1600 2250 0    50   ~ 0
GPIO2-13
Text Label 1600 2150 0    50   ~ 0
GPIO2-14
Text Label 1600 2050 0    50   ~ 0
GPIO2-15
Text GLabel 1500 3550 0    50   Input ~ 0
GPIO2-0
Text GLabel 1500 3450 0    50   Input ~ 0
GPIO2-1
Text GLabel 1500 3350 0    50   Input ~ 0
GPIO2-2
Text GLabel 1500 3250 0    50   Input ~ 0
GPIO2-3
Text GLabel 1500 3150 0    50   Input ~ 0
GPIO2-4
Text GLabel 1500 3050 0    50   Input ~ 0
GPIO2-5
Text GLabel 1500 2950 0    50   Input ~ 0
GPIO2-6
Text GLabel 1500 2850 0    50   Input ~ 0
GPIO2-7
Text GLabel 1500 2750 0    50   Input ~ 0
GPIO2-8
Text GLabel 1500 2650 0    50   Input ~ 0
GPIO2-9
Text GLabel 1500 2550 0    50   Input ~ 0
GPIO2-10
Text GLabel 1500 2450 0    50   Input ~ 0
GPIO2-11
Text GLabel 1500 2350 0    50   Input ~ 0
GPIO2-12
Text GLabel 1500 2250 0    50   Input ~ 0
GPIO2-13
Text GLabel 1500 2150 0    50   Input ~ 0
GPIO2-14
Text GLabel 1500 2050 0    50   Input ~ 0
GPIO2-15
Wire Wire Line
	10250 1550 10150 1550
Wire Wire Line
	10150 1450 10250 1450
Wire Wire Line
	1750 6300 1850 6300
Wire Wire Line
	10150 1350 10250 1350
Wire Wire Line
	7950 2250 8050 2250
Wire Wire Line
	7950 2150 8050 2150
Wire Wire Line
	7950 2750 8050 2750
Wire Wire Line
	7950 2650 8050 2650
Wire Wire Line
	7950 2950 8050 2950
Wire Wire Line
	7950 2850 8050 2850
Wire Wire Line
	7950 3350 8050 3350
Wire Wire Line
	7950 3250 8050 3250
Wire Wire Line
	7950 3750 8050 3750
Wire Wire Line
	7950 3650 8050 3650
Wire Wire Line
	7950 3950 8050 3950
Wire Wire Line
	7950 3850 8050 3850
Text Label 10150 1550 2    50   ~ 0
GPIO2-0
Text Label 10150 1450 2    50   ~ 0
GPIO2-1
Text Label 1750 6300 2    50   ~ 0
GPIO2-2
Text Label 10150 1350 2    50   ~ 0
GPIO2-3
Text Label 7950 2250 2    50   ~ 0
GPIO2-4
Text Label 7950 2150 2    50   ~ 0
GPIO2-5
Text Label 7950 2750 2    50   ~ 0
GPIO2-6
Text Label 7950 2650 2    50   ~ 0
GPIO2-7
Text Label 7950 2950 2    50   ~ 0
GPIO2-8
Text Label 7950 2850 2    50   ~ 0
GPIO2-9
Text Label 7950 3350 2    50   ~ 0
GPIO2-10
Text Label 7950 3250 2    50   ~ 0
GPIO2-11
Text Label 7950 3750 2    50   ~ 0
GPIO2-12
Text Label 7950 3650 2    50   ~ 0
GPIO2-13
Text Label 7950 3950 2    50   ~ 0
GPIO2-14
Text Label 7950 3850 2    50   ~ 0
GPIO2-15
Wire Wire Line
	3400 5900 4650 5900
Wire Wire Line
	3400 5700 4150 5700
$Comp
L power:+3.3V #PWR0126
U 1 1 5FC5A588
P 7800 5650
F 0 "#PWR0126" H 7800 5500 50  0001 C CNN
F 1 "+3.3V" H 7815 5823 50  0000 C CNN
F 2 "" H 7800 5650 50  0001 C CNN
F 3 "" H 7800 5650 50  0001 C CNN
	1    7800 5650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0127
U 1 1 5FC5A9AD
P 7800 6100
F 0 "#PWR0127" H 7800 5850 50  0001 C CNN
F 1 "GND" H 7950 6050 50  0000 C CNN
F 2 "" H 7800 6100 50  0001 C CNN
F 3 "" H 7800 6100 50  0001 C CNN
	1    7800 6100
	1    0    0    -1  
$EndComp
Wire Wire Line
	8050 6050 7800 6050
Wire Wire Line
	7800 6050 7800 6100
Wire Wire Line
	8050 5750 7800 5750
Wire Wire Line
	7800 5750 7800 5650
$Comp
L Eldalote-General:SiT2001B1-S2-33E-50 X1401
U 1 1 5FC5708A
P 8200 5400
F 0 "X1401" H 8200 5300 50  0000 C CNN
F 1 "SiT2001B1-S2-33E-50" H 8600 5200 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23-5_HandSoldering" H 8200 5400 50  0001 C CNN
F 3 "" H 8200 5400 50  0001 C CNN
	1    8200 5400
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C?
U 1 1 5FC6FE63
P 7800 5900
AR Path="/5F4399E1/5FC6FE63" Ref="C?"  Part="1" 
AR Path="/5F48BB5C/5FC6FE63" Ref="C1401"  Part="1" 
F 0 "C1401" H 7892 5946 50  0000 L CNN
F 1 "100nF" H 7892 5855 50  0000 L CNN
F 2 "Inductor_SMD:L_0402_1005Metric" H 7800 5900 50  0001 C CNN
F 3 "~" H 7800 5900 50  0001 C CNN
F 4 "" H 7800 5900 50  0001 C CNN "DigiKey"
F 5 "" H 7800 5900 50  0001 C CNN "Mouser"
F 6 "C1525" H 7800 5900 50  0001 C CNN "LCSC"
	1    7800 5900
	1    0    0    -1  
$EndComp
Wire Wire Line
	7800 5750 7800 5800
Connection ~ 7800 5750
Wire Wire Line
	7800 6000 7800 6050
Connection ~ 7800 6050
$Comp
L Device:R R?
U 1 1 5FC89410
P 9150 5500
AR Path="/5F439B8E/5FC89410" Ref="R?"  Part="1" 
AR Path="/5F48BB5C/5FC89410" Ref="R1405"  Part="1" 
F 0 "R1405" H 9220 5546 50  0000 L CNN
F 1 "10K" H 9220 5455 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 9080 5500 50  0001 C CNN
F 3 "~" H 9150 5500 50  0001 C CNN
F 4 "" H 9150 5500 50  0001 C CNN "Mouser"
F 5 "" H 9150 5500 50  0001 C CNN "DigiKey"
F 6 "C25744" H 9150 5500 50  0001 C CNN "LCSC"
	1    9150 5500
	1    0    0    -1  
$EndComp
Wire Wire Line
	9150 5650 9150 5750
Wire Wire Line
	9150 5750 8700 5750
$Comp
L power:+3.3V #PWR01406
U 1 1 5FC8F34A
P 9150 5300
F 0 "#PWR01406" H 9150 5150 50  0001 C CNN
F 1 "+3.3V" H 9165 5473 50  0000 C CNN
F 2 "" H 9150 5300 50  0001 C CNN
F 3 "" H 9150 5300 50  0001 C CNN
	1    9150 5300
	1    0    0    -1  
$EndComp
Wire Wire Line
	9150 5300 9150 5350
Wire Wire Line
	8700 6050 9000 6050
Text Label 9000 6050 0    50   ~ 0
FPGA-CLOCK-50
Text Label 5800 5700 2    50   ~ 0
FPGA-CLOCK-50
Wire Wire Line
	5900 5700 5800 5700
NoConn ~ 1850 6000
NoConn ~ 1850 6100
NoConn ~ 1850 6200
NoConn ~ 1850 6400
NoConn ~ 1850 6500
NoConn ~ 1850 6600
NoConn ~ 5900 5400
NoConn ~ 5900 5500
NoConn ~ 5900 5600
NoConn ~ 5900 5800
NoConn ~ 5900 5900
NoConn ~ 5900 6000
NoConn ~ 5900 6100
NoConn ~ 5900 6200
NoConn ~ 5900 6300
NoConn ~ 5900 6400
NoConn ~ 5900 6500
NoConn ~ 5900 6600
NoConn ~ 5900 6700
NoConn ~ 5900 6800
NoConn ~ 5900 6900
Wire Notes Line
	7500 4950 9800 4950
Wire Notes Line
	9800 4950 9800 6400
Wire Notes Line
	9800 6400 7500 6400
Wire Notes Line
	7500 6400 7500 4950
Text Notes 8250 5100 0    50   ~ 0
Clock Generator
NoConn ~ 8050 650 
NoConn ~ 8050 750 
NoConn ~ 8050 850 
NoConn ~ 8050 950 
NoConn ~ 8050 1050
NoConn ~ 8050 1150
NoConn ~ 8050 1250
NoConn ~ 8050 1350
NoConn ~ 8050 1450
NoConn ~ 8050 1550
NoConn ~ 8050 1850
NoConn ~ 8050 1950
NoConn ~ 8050 2350
NoConn ~ 8050 2450
NoConn ~ 8050 2550
NoConn ~ 8050 3050
NoConn ~ 8050 3150
NoConn ~ 8050 3450
NoConn ~ 8050 3550
NoConn ~ 8050 4050
NoConn ~ 8050 4150
NoConn ~ 8050 4250
NoConn ~ 8050 4450
NoConn ~ 8050 4550
NoConn ~ 8050 4650
NoConn ~ 8050 4750
NoConn ~ 10250 650 
NoConn ~ 10250 750 
NoConn ~ 10250 850 
NoConn ~ 10250 950 
NoConn ~ 10250 1050
NoConn ~ 10250 1150
NoConn ~ 10250 1250
NoConn ~ 10250 1650
NoConn ~ 10250 1750
NoConn ~ 10250 1850
NoConn ~ 10250 1950
NoConn ~ 10250 2050
NoConn ~ 10250 2150
NoConn ~ 10250 2250
NoConn ~ 10250 2350
NoConn ~ 10250 2450
NoConn ~ 10250 2550
NoConn ~ 10250 2650
NoConn ~ 10250 2750
NoConn ~ 10250 2850
NoConn ~ 10250 2950
NoConn ~ 10250 3050
NoConn ~ 10250 3150
NoConn ~ 10250 3250
NoConn ~ 10250 3350
NoConn ~ 10250 3450
NoConn ~ 10250 3550
NoConn ~ 10250 3650
NoConn ~ 10250 3850
NoConn ~ 10250 3950
NoConn ~ 10250 4050
NoConn ~ 10250 4150
$EndSCHEMATC
