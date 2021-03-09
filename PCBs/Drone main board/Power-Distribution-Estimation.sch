EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 2 15
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text Notes 5550 3150 0    67   ~ 0
Power requirements:\n1v2 (FPGA core): 1.5A estimated. Supply 2A to have margin. Derived from 5v rail. \n       -- 1v2 at 2A is 2.4 watt. 90% regulator efficiency: 2.7 watt input. Around 540mA drain on 5v rail.\n       -- Regulator: AP63200WU-7\n\n2v5 (FPGA PLL): 40mA estimated. Use small LDO, derived from 3v3. 40mA drain on 3v3 rail.\n        -- Regulator: NCP115ASN250T2G\n\n3v3 (FPGA IO, sensors, radio, flash, LEDs, GPIO): Radio combined max 110mA, LEDs max 150mA, \n       -- Sensors: combined less than 20mA, FPGA-IO: 100mA, 2v5LDO: 40mA. Total combined: 380mA. \n       -- With a 1.5A regulator that leaves more and 1amps for the GPIOs. Should be good enough. \n       -- 3v3 at 1.5A is 4.95 watts, 90% efficency: 5.5 watts. 1.1Amps drain on 5v rail.\n       -- Regulator: SC189ZSKTRT\n\n5v (Other power rails, ADC, GPIO): 1v2: 540mA, 3v3: 1.1A, ADC <1mA. Total: 1.65 A. Powered by either \n       -- 2A regulator or DC power plug, even with everything on full power, that leaves 350mA for GPIO.\n       -- Regulator: AP63205WU-7\n\n5v USB (FTDI): Self powered through USB.\n\n\nPower in: 10v 2A From 4-in-1 ESC\nAlternate: 5v from DC plug. Added jumper to enable switching between supplies
$Comp
L power:+5V #PWR0202
U 1 1 5F5DB17B
P 8100 4750
F 0 "#PWR0202" H 8100 4600 50  0001 C CNN
F 1 "+5V" H 8115 4923 50  0000 C CNN
F 2 "" H 8100 4750 50  0001 C CNN
F 3 "" H 8100 4750 50  0001 C CNN
	1    8100 4750
	1    0    0    -1  
$EndComp
$Comp
L Device:Jumper_NC_Dual JP201
U 1 1 5F5DCDBD
P 8100 5000
F 0 "JP201" H 8100 5147 50  0000 C CNN
F 1 "Jumper_NC_Dual" H 8100 5238 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical" H 8100 5000 50  0001 C CNN
F 3 "~" H 8100 5000 50  0001 C CNN
F 4 " ME-100 " H 8100 5000 50  0001 C CNN "MfNr"
	1    8100 5000
	-1   0    0    1   
$EndComp
$Comp
L dk_Barrel-Power-Connectors:PJ-102A J201
U 1 1 5F5E0C37
P 7350 5000
F 0 "J201" H 7100 5150 50  0000 C CNN
F 1 "PJ-102A" H 7150 5100 50  0000 C CNN
F 2 "digikey-footprints:Barrel_Jack_5.5mmODx2.1mmID_PJ-102A" H 7550 5200 60  0001 L CNN
F 3 "https://www.cui.com/product/resource/digikeypdf/pj-102a.pdf" H 7550 5300 60  0001 L CNN
F 4 "PJ-102A" H 7350 5000 50  0001 C CNN "MfNr"
	1    7350 5000
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0201
U 1 1 5F5E9A9C
P 7650 5300
F 0 "#PWR0201" H 7650 5050 50  0001 C CNN
F 1 "GND" H 7655 5127 50  0000 C CNN
F 2 "" H 7650 5300 50  0001 C CNN
F 3 "" H 7650 5300 50  0001 C CNN
	1    7650 5300
	1    0    0    -1  
$EndComp
Wire Wire Line
	7850 5000 7450 5000
Wire Wire Line
	7650 5300 7650 5250
Wire Wire Line
	7650 5200 7450 5200
Text Label 7500 5000 0    50   ~ 0
5v-plug
Wire Wire Line
	8350 5000 8750 5000
Text Label 8400 5000 0    50   ~ 0
5v-regulator
Wire Notes Line
	6850 4500 9100 4500
Wire Notes Line
	9100 4500 9100 5700
Wire Notes Line
	9100 5700 6850 5700
Wire Notes Line
	6850 5700 6850 4500
Text Notes 7200 4500 0    67   ~ 0
5v DC plug and 5v rail jumper
$Sheet
S 950  800  1650 900 
U 5F626889
F0 "5v Power regulator" 67
F1 "5v-power-regulator.sch" 67
F2 "5v-regulator-out" O R 2600 1300 67 
$EndSheet
Wire Wire Line
	2600 1300 3000 1300
Text Label 3000 1300 0    67   ~ 0
5v-regulator
$Sheet
S 950  2050 1650 850 
U 5F63B9F1
F0 "3v3 and 2v5 power regulators" 67
F1 "3v3-2v5-regulator.sch" 67
$EndSheet
$Sheet
S 950  3300 1650 850 
U 5F6564BB
F0 "1v2 power regulator" 67
F1 "1v2-power-regulator.sch" 67
$EndSheet
NoConn ~ 7450 5100
$Comp
L power:PWR_FLAG #FLG0101
U 1 1 5FC9337A
P 7650 5250
F 0 "#FLG0101" H 7650 5325 50  0001 C CNN
F 1 "PWR_FLAG" V 7650 5377 50  0000 L CNN
F 2 "" H 7650 5250 50  0001 C CNN
F 3 "~" H 7650 5250 50  0001 C CNN
	1    7650 5250
	0    -1   -1   0   
$EndComp
Connection ~ 7650 5250
Wire Wire Line
	7650 5250 7650 5200
$Comp
L power:PWR_FLAG #FLG0102
U 1 1 5FC943F0
P 8100 4850
F 0 "#FLG0102" H 8100 4925 50  0001 C CNN
F 1 "PWR_FLAG" V 8100 4978 50  0000 L CNN
F 2 "" H 8100 4850 50  0001 C CNN
F 3 "~" H 8100 4850 50  0001 C CNN
	1    8100 4850
	0    1    1    0   
$EndComp
Wire Wire Line
	8100 4750 8100 4850
Connection ~ 8100 4850
Wire Wire Line
	8100 4850 8100 4900
$EndSCHEMATC
