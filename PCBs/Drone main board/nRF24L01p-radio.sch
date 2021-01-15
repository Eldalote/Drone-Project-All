EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 8 15
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
L Connector:Conn_Coaxial J801
U 1 1 5F3A6795
P 9050 3500
F 0 "J801" H 9150 3475 50  0000 L CNN
F 1 "SMA" H 9150 3384 50  0000 L CNN
F 2 "Connector_Coaxial:SMA_Samtec_SMA-J-P-X-ST-EM1_EdgeMount" H 9050 3500 50  0001 C CNN
F 3 " ~" H 9050 3500 50  0001 C CNN
F 4 "CON-SMA-EDGE-S-ND " H 9050 3500 50  0001 C CNN "DigiKey"
F 5 "223-CON-SMA-EDGE-S " H 9050 3500 50  0001 C CNN "Mouser"
	1    9050 3500
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0805
U 1 1 5F3AE5F7
P 2250 4350
F 0 "#PWR0805" H 2250 4100 50  0001 C CNN
F 1 "GND" H 2255 4177 50  0000 C CNN
F 2 "" H 2250 4350 50  0001 C CNN
F 3 "" H 2250 4350 50  0001 C CNN
	1    2250 4350
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR0804
U 1 1 5F3AEB37
P 2200 2050
F 0 "#PWR0804" H 2200 1900 50  0001 C CNN
F 1 "+3.3V" H 2215 2223 50  0000 C CNN
F 2 "" H 2200 2050 50  0001 C CNN
F 3 "" H 2200 2050 50  0001 C CNN
	1    2200 2050
	1    0    0    -1  
$EndComp
Wire Wire Line
	2300 2150 2200 2150
Connection ~ 2200 2150
Wire Wire Line
	2100 4250 2100 4350
Wire Wire Line
	2100 4350 2200 4350
Wire Wire Line
	2200 4250 2200 4350
Connection ~ 2200 4350
Wire Wire Line
	2200 4350 2250 4350
Wire Wire Line
	2300 4250 2300 4350
Wire Wire Line
	2300 4350 2250 4350
Connection ~ 2250 4350
Wire Wire Line
	2400 4250 2400 4350
Wire Wire Line
	2400 4350 2300 4350
Connection ~ 2300 4350
Text GLabel 1500 1000 0    50   Input ~ 0
nRF_SCLK
Text GLabel 1500 1450 0    50   Input ~ 0
nRF_CE
Text GLabel 1500 1300 0    50   Input ~ 0
nRF_CSn
Text GLabel 1500 1200 0    50   Input ~ 0
nRF_MOSI
Text GLabel 1500 1550 0    50   Input ~ 0
nRF_IRQ
$Comp
L Device:C_Small C804
U 1 1 5F3B646B
P 3050 4850
F 0 "C804" H 2958 4804 50  0000 R CNN
F 1 "15pF" H 2958 4895 50  0000 R CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 3088 4700 50  0001 C CNN
F 3 "~" H 3050 4850 50  0001 C CNN
F 4 " C1548" H 3050 4850 50  0001 C CNN "LCSC"
	1    3050 4850
	-1   0    0    1   
$EndComp
Wire Wire Line
	3450 4350 3400 4350
Wire Wire Line
	3050 4350 3100 4350
$Comp
L power:GND #PWR0807
U 1 1 5F3BA5BD
P 3050 5000
F 0 "#PWR0807" H 3050 4750 50  0001 C CNN
F 1 "GND" H 3055 4827 50  0000 C CNN
F 2 "" H 3050 5000 50  0001 C CNN
F 3 "" H 3050 5000 50  0001 C CNN
	1    3050 5000
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0810
U 1 1 5F3C485B
P 3450 5000
F 0 "#PWR0810" H 3450 4750 50  0001 C CNN
F 1 "GND" H 3455 4827 50  0000 C CNN
F 2 "" H 3450 5000 50  0001 C CNN
F 3 "" H 3450 5000 50  0001 C CNN
	1    3450 5000
	1    0    0    -1  
$EndComp
Wire Wire Line
	2800 3950 3100 3950
Wire Wire Line
	3100 3950 3100 4350
Wire Wire Line
	3400 3750 2800 3750
Wire Wire Line
	3400 3750 3400 4350
$Comp
L Device:C_Small C802
U 1 1 5F3C72EA
P 1700 2450
F 0 "C802" H 1792 2496 50  0000 L CNN
F 1 "1nF" H 1792 2405 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 1738 2300 50  0001 C CNN
F 3 "~" H 1700 2450 50  0001 C CNN
F 4 "" H 1700 2450 50  0001 C CNN "JLC Part Nr"
F 5 " C1523" H 1700 2450 50  0001 C CNN "LCSC"
	1    1700 2450
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C803
U 1 1 5F3C8FDB
P 2550 2450
F 0 "C803" H 2642 2496 50  0000 L CNN
F 1 "10nF" H 2642 2405 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 2588 2300 50  0001 C CNN
F 3 "~" H 2550 2450 50  0001 C CNN
F 4 "" H 2550 2450 50  0001 C CNN "JLC Part Nr"
F 5 " C15195" H 2550 2450 50  0001 C CNN "LCSC"
	1    2550 2450
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0806
U 1 1 5F3CE72C
P 2550 2550
F 0 "#PWR0806" H 2550 2300 50  0001 C CNN
F 1 "GND" H 2555 2377 50  0000 C CNN
F 2 "" H 2550 2550 50  0001 C CNN
F 3 "" H 2550 2550 50  0001 C CNN
	1    2550 2550
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0803
U 1 1 5F3CEE43
P 1700 2550
F 0 "#PWR0803" H 1700 2300 50  0001 C CNN
F 1 "GND" H 1705 2377 50  0000 C CNN
F 2 "" H 1700 2550 50  0001 C CNN
F 3 "" H 1700 2550 50  0001 C CNN
	1    1700 2550
	1    0    0    -1  
$EndComp
Wire Wire Line
	2200 2150 2200 2650
Wire Wire Line
	2300 2150 2300 2650
Wire Wire Line
	2550 2150 2300 2150
Connection ~ 2300 2150
$Comp
L Device:R_Small R801
U 1 1 5F3D2B6B
P 1100 3950
F 0 "R801" H 1159 3996 50  0000 L CNN
F 1 "22K" H 1159 3905 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 1100 3950 50  0001 C CNN
F 3 "~" H 1100 3950 50  0001 C CNN
F 4 "" H 1100 3950 50  0001 C CNN "JLC Part Nr"
F 5 " C25768" H 1100 3950 50  0001 C CNN "LCSC"
	1    1100 3950
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0801
U 1 1 5F3D402C
P 1100 4150
F 0 "#PWR0801" H 1100 3900 50  0001 C CNN
F 1 "GND" H 1105 3977 50  0000 C CNN
F 2 "" H 1100 4150 50  0001 C CNN
F 3 "" H 1100 4150 50  0001 C CNN
	1    1100 4150
	1    0    0    -1  
$EndComp
Wire Wire Line
	1600 3750 1100 3750
Wire Wire Line
	1100 3750 1100 3850
Wire Wire Line
	1100 4050 1100 4150
$Comp
L Device:C_Small C801
U 1 1 5F3D5E30
P 1500 4200
F 0 "C801" H 1592 4246 50  0000 L CNN
F 1 "33nF" H 1592 4155 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 1500 4200 50  0001 C CNN
F 3 "~" H 1500 4200 50  0001 C CNN
F 4 "C21117" H 1500 4200 50  0001 C CNN "LCSC"
	1    1500 4200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0802
U 1 1 5F3D6C5F
P 1500 4350
F 0 "#PWR0802" H 1500 4100 50  0001 C CNN
F 1 "GND" H 1505 4177 50  0000 C CNN
F 2 "" H 1500 4350 50  0001 C CNN
F 3 "" H 1500 4350 50  0001 C CNN
	1    1500 4350
	1    0    0    -1  
$EndComp
Wire Wire Line
	1500 4350 1500 4300
Wire Wire Line
	1500 4100 1500 3950
Wire Wire Line
	1500 3950 1600 3950
Wire Wire Line
	1700 2150 1700 2350
Wire Wire Line
	2550 2150 2550 2350
Wire Wire Line
	3050 5000 3050 4950
Wire Wire Line
	3050 4350 3050 4750
Wire Wire Line
	3450 5000 3450 4950
Wire Wire Line
	3450 4350 3450 4750
$Comp
L Device:L_Small L801
U 1 1 5F3E4643
P 3050 3250
F 0 "L801" H 3098 3296 50  0000 L CNN
F 1 "8.2nH" H 3098 3205 50  0000 L CNN
F 2 "Inductor_SMD:L_0402_1005Metric" H 3050 3250 50  0001 C CNN
F 3 "~" H 3050 3250 50  0001 C CNN
F 4 "" H 3050 3250 50  0001 C CNN "JLC Part Nr"
F 5 " C16208" H 3050 3250 50  0001 C CNN "LCSC"
	1    3050 3250
	1    0    0    -1  
$EndComp
$Comp
L Device:L_Small L802
U 1 1 5F3ECD72
P 3350 3150
F 0 "L802" V 3535 3150 50  0000 C CNN
F 1 "2.7nH" V 3444 3150 50  0000 C CNN
F 2 "Inductor_SMD:L_0402_1005Metric" H 3350 3150 50  0001 C CNN
F 3 "~" H 3350 3150 50  0001 C CNN
F 4 "" H 3350 3150 50  0001 C CNN "JLC Part Nr"
F 5 " C27123" H 3350 3150 50  0001 C CNN "LCSC"
	1    3350 3150
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2800 3150 3050 3150
Wire Wire Line
	3050 3150 3250 3150
Connection ~ 3050 3150
Wire Wire Line
	2800 3350 3050 3350
$Comp
L power:GND #PWR0811
U 1 1 5F3F78AF
P 4050 2950
F 0 "#PWR0811" H 4050 2700 50  0001 C CNN
F 1 "GND" H 4055 2777 50  0000 C CNN
F 2 "" H 4050 2950 50  0001 C CNN
F 3 "" H 4050 2950 50  0001 C CNN
	1    4050 2950
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C808
U 1 1 5F3F67A4
P 4250 2800
F 0 "C808" H 4158 2754 50  0000 R CNN
F 1 "4.7pF" H 4158 2845 50  0000 R CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 4288 2650 50  0001 C CNN
F 3 "~" H 4250 2800 50  0001 C CNN
F 4 "" V 4250 2800 50  0001 C CNN "JLC Part Nr"
F 5 " C1569" H 4250 2800 50  0001 C CNN "LCSC"
	1    4250 2800
	-1   0    0    1   
$EndComp
$Comp
L Device:C_Small C806
U 1 1 5F3F5913
P 3800 2800
F 0 "C806" H 3708 2754 50  0000 R CNN
F 1 "2.2nF" H 3708 2845 50  0000 R CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 3838 2650 50  0001 C CNN
F 3 "~" H 3800 2800 50  0001 C CNN
F 4 "" V 3800 2800 50  0001 C CNN "JLC Part Nr"
F 5 " C1531" H 3800 2800 50  0001 C CNN "LCSC"
	1    3800 2800
	-1   0    0    1   
$EndComp
Wire Wire Line
	3800 2700 4250 2700
Wire Wire Line
	4250 2900 4250 2950
Wire Wire Line
	4250 2950 4050 2950
Wire Wire Line
	3800 2900 3800 2950
Wire Wire Line
	3800 2950 4050 2950
Connection ~ 4050 2950
Connection ~ 3800 2700
Wire Wire Line
	4600 2700 4250 2700
Connection ~ 4250 2700
Wire Wire Line
	4600 2700 4600 3150
Wire Wire Line
	3250 2700 3250 2950
Wire Wire Line
	3250 2700 3800 2700
$Comp
L Device:L_Small L803
U 1 1 5F419F10
P 3650 3500
F 0 "L803" V 3835 3500 50  0000 C CNN
F 1 "3.9nH" V 3744 3500 50  0000 C CNN
F 2 "Inductor_SMD:L_0402_1005Metric" H 3650 3500 50  0001 C CNN
F 3 "~" H 3650 3500 50  0001 C CNN
F 4 "" H 3650 3500 50  0001 C CNN "JLC Part Nr"
F 5 " C14033" H 3650 3500 50  0001 C CNN "LCSC"
	1    3650 3500
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3500 3350 3050 3350
Connection ~ 3050 3350
$Comp
L Device:C_Small C809
U 1 1 5F41DD47
P 4100 3650
F 0 "C809" H 4008 3604 50  0000 R CNN
F 1 "1.0pF" H 4008 3695 50  0000 R CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 4138 3500 50  0001 C CNN
F 3 "~" H 4100 3650 50  0001 C CNN
F 4 "1276-1095-1-ND" H 4100 3650 50  0001 C CNN "DigiKey"
F 5 "187-CL10C010BB8NNNC" H 4100 3650 50  0001 C CNN "Mouser"
	1    4100 3650
	-1   0    0    1   
$EndComp
$Comp
L Device:C_Small C807
U 1 1 5F41F548
P 3950 3500
F 0 "C807" V 3721 3500 50  0000 C CNN
F 1 "1.5pF" V 3812 3500 50  0000 C CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 3988 3350 50  0001 C CNN
F 3 "~" H 3950 3500 50  0001 C CNN
F 4 "311-1737-1-ND" V 3950 3500 50  0001 C CNN "DigiKey"
F 5 "603-CC603BRNPO9BN1R5" V 3950 3500 50  0001 C CNN "Mouser"
	1    3950 3500
	0    1    1    0   
$EndComp
Wire Wire Line
	3500 3350 3500 3500
Wire Wire Line
	3500 3500 3550 3500
Wire Wire Line
	3750 3500 3850 3500
Wire Wire Line
	4050 3500 4100 3500
Wire Wire Line
	4100 3500 4100 3550
$Comp
L power:GND #PWR0812
U 1 1 5F42F3BF
P 4100 3750
F 0 "#PWR0812" H 4100 3500 50  0001 C CNN
F 1 "GND" H 4105 3577 50  0000 C CNN
F 2 "" H 4100 3750 50  0001 C CNN
F 3 "" H 4100 3750 50  0001 C CNN
	1    4100 3750
	1    0    0    -1  
$EndComp
Connection ~ 4100 3500
$Comp
L Device:C_Small C810
U 1 1 5F48FD25
P 6350 3000
F 0 "C810" H 6258 2954 50  0000 R CNN
F 1 "220pF" H 6258 3045 50  0000 R CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 6388 2850 50  0001 C CNN
F 3 "~" H 6350 3000 50  0001 C CNN
F 4 "" V 6350 3000 50  0001 C CNN "JLC Part Nr"
F 5 " C1530" H 6350 3000 50  0001 C CNN "LCSC"
	1    6350 3000
	-1   0    0    1   
$EndComp
Wire Wire Line
	6350 2900 6350 2850
$Comp
L power:GND #PWR0816
U 1 1 5F4A4F28
P 6350 3100
F 0 "#PWR0816" H 6350 2850 50  0001 C CNN
F 1 "GND" H 6355 2927 50  0000 C CNN
F 2 "" H 6350 3100 50  0001 C CNN
F 3 "" H 6350 3100 50  0001 C CNN
	1    6350 3100
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C813
U 1 1 5F4BFEA5
P 7250 3600
F 0 "C813" H 7158 3554 50  0000 R CNN
F 1 "0.3pF" H 7158 3645 50  0000 R CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 7288 3450 50  0001 C CNN
F 3 "~" H 7250 3600 50  0001 C CNN
F 4 "712-1300-1-ND " H 7250 3600 50  0001 C CNN "DigiKey"
F 5 "609-251R14S0R3AV4T " H 7250 3600 50  0001 C CNN "Mouser"
	1    7250 3600
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR0821
U 1 1 5F539E70
P 7250 3700
F 0 "#PWR0821" H 7250 3450 50  0001 C CNN
F 1 "GND" H 7255 3527 50  0000 C CNN
F 2 "" H 7250 3700 50  0001 C CNN
F 3 "" H 7250 3700 50  0001 C CNN
	1    7250 3700
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0827
U 1 1 5F54A320
P 9050 3700
F 0 "#PWR0827" H 9050 3450 50  0001 C CNN
F 1 "GND" H 9055 3527 50  0000 C CNN
F 2 "" H 9050 3700 50  0001 C CNN
F 3 "" H 9050 3700 50  0001 C CNN
	1    9050 3700
	1    0    0    -1  
$EndComp
Wire Wire Line
	1700 2150 2100 2150
Wire Wire Line
	2100 2650 2100 2150
Connection ~ 2100 2150
Wire Wire Line
	2100 2150 2200 2150
Wire Wire Line
	2200 2050 2200 2150
Text GLabel 1500 1100 0    50   Input ~ 0
nRF_MISO
Wire Wire Line
	2800 2950 3250 2950
Text Label 3350 2700 0    50   ~ 0
VDD_PA
Wire Wire Line
	1600 2950 1500 2950
Wire Wire Line
	1600 3050 1500 3050
Wire Wire Line
	1600 3150 1500 3150
Wire Wire Line
	1600 3250 1500 3250
Wire Wire Line
	1600 3450 1500 3450
Wire Wire Line
	1600 3550 1500 3550
Text Label 1500 2950 2    50   ~ 0
MOSI
Text Label 1500 3050 2    50   ~ 0
MISO
Text Label 1500 3150 2    50   ~ 0
SCLK
Text Label 1500 3250 2    50   ~ 0
~CS
Text Label 1500 3450 2    50   ~ 0
CE
Text Label 1500 3550 2    50   ~ 0
IRQ
Text Label 1600 1200 0    50   ~ 0
MOSI
Text Label 1600 1100 0    50   ~ 0
MISO
Text Label 1600 1000 0    50   ~ 0
SCLK
Text Label 1600 1300 0    50   ~ 0
~CS
Text Label 1600 1450 0    50   ~ 0
CE
Text Label 1600 1550 0    50   ~ 0
IRQ
Wire Notes Line
	600  600  2500 600 
Wire Notes Line
	2500 600  2500 1750
Wire Notes Line
	2500 1750 600  1750
Wire Notes Line
	600  1750 600  600 
Text Notes 1000 800  0    118  ~ 0
Sheet IO
Wire Wire Line
	3450 3150 4600 3150
$Comp
L Device:Crystal_GND24_Small X801
U 1 1 5F60AD74
P 3250 4350
F 0 "X801" H 3550 4400 50  0000 L CNN
F 1 "16MHz" H 3500 4300 50  0000 L CNN
F 2 "Crystal:Crystal_SMD_3225-4Pin_3.2x2.5mm" H 3250 4350 50  0001 C CNN
F 3 "~" H 3250 4350 50  0001 C CNN
F 4 "C13738" H 3250 4350 50  0001 C CNN "LCSC"
	1    3250 4350
	1    0    0    -1  
$EndComp
Wire Wire Line
	3400 4350 3350 4350
Connection ~ 3400 4350
Wire Wire Line
	3100 4350 3150 4350
Connection ~ 3100 4350
$Comp
L power:GND #PWR0808
U 1 1 5F615159
P 3250 4500
F 0 "#PWR0808" H 3250 4250 50  0001 C CNN
F 1 "GND" H 3255 4327 50  0000 C CNN
F 2 "" H 3250 4500 50  0001 C CNN
F 3 "" H 3250 4500 50  0001 C CNN
	1    3250 4500
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0809
U 1 1 5F6155A3
P 3350 4000
F 0 "#PWR0809" H 3350 3750 50  0001 C CNN
F 1 "GND" H 3355 3827 50  0000 C CNN
F 2 "" H 3350 4000 50  0001 C CNN
F 3 "" H 3350 4000 50  0001 C CNN
	1    3350 4000
	1    0    0    -1  
$EndComp
Wire Wire Line
	3250 4450 3250 4500
Wire Wire Line
	3250 4250 3250 3950
Wire Wire Line
	3250 3950 3350 3950
Wire Wire Line
	3350 3950 3350 4000
$Comp
L Device:C_Small C805
U 1 1 5F639C62
P 3450 4850
F 0 "C805" H 3358 4804 50  0000 R CNN
F 1 "15pF" H 3358 4895 50  0000 R CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 3488 4700 50  0001 C CNN
F 3 "~" H 3450 4850 50  0001 C CNN
F 4 " C1548" H 3450 4850 50  0001 C CNN "LCSC"
	1    3450 4850
	-1   0    0    1   
$EndComp
Wire Wire Line
	4550 3600 4850 3600
Wire Wire Line
	5450 3600 5150 3600
Wire Wire Line
	4550 3900 4850 3900
Text Label 4550 3900 0    50   ~ 0
CE
Text Label 4550 3600 0    50   ~ 0
VDD_PA
$Comp
L Device:R R802
U 1 1 5F3E1CFD
P 5000 3600
F 0 "R802" V 4900 3600 50  0000 C CNN
F 1 "1K" V 5000 3600 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 5000 3600 50  0001 C CNN
F 3 "~" H 5000 3600 50  0001 C CNN
F 4 "" H 5000 3600 50  0001 C CNN "JLC Part Nr"
F 5 " C11702" H 5000 3600 50  0001 C CNN "LCSC"
	1    5000 3600
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R803
U 1 1 5F44984A
P 5000 3900
F 0 "R803" V 5100 3900 50  0000 C CNN
F 1 "1K" V 5000 3900 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 5000 3900 50  0001 C CNN
F 3 "~" H 5000 3900 50  0001 C CNN
F 4 "" H 5000 3900 50  0001 C CNN "JLC Part Nr"
F 5 " C11702" H 5000 3900 50  0001 C CNN "LCSC"
	1    5000 3900
	0    -1   -1   0   
$EndComp
$Comp
L SamacSys_Parts:2450LP14A100T FL801
U 1 1 5FE5E5C6
P 7750 3550
F 0 "FL801" H 8150 3825 50  0000 C CNN
F 1 "2450LP14A100T" H 8150 3734 50  0000 C CNN
F 2 "SamacSys_Parts:2450LP14A100T" H 8800 3650 50  0001 L CNN
F 3 "https://componentsearchengine.com/Datasheets/1/2450LP14A100T.pdf" H 8800 3550 50  0001 L CNN
F 4 "Signal Conditioning LOW PASS FILTER 2.4GHz" H 8800 3450 50  0001 L CNN "Description"
F 5 "712-1129-1-ND " H 7750 3550 50  0001 C CNN "DigiKey"
F 6 "609-2450LP14A100T " H 7750 3550 50  0001 C CNN "Mouser"
	1    7750 3550
	1    0    0    -1  
$EndComp
Connection ~ 7250 3500
Wire Wire Line
	7250 3500 7750 3500
Wire Wire Line
	8550 3500 8850 3500
$Comp
L power:GND #PWR0128
U 1 1 5FE7873D
P 8150 4150
F 0 "#PWR0128" H 8150 3900 50  0001 C CNN
F 1 "GND" H 8155 3977 50  0000 C CNN
F 2 "" H 8150 4150 50  0001 C CNN
F 3 "" H 8150 4150 50  0001 C CNN
	1    8150 4150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0130
U 1 1 5FE78C8B
P 6150 4500
F 0 "#PWR0130" H 6150 4250 50  0001 C CNN
F 1 "GND" H 6155 4327 50  0000 C CNN
F 2 "" H 6150 4500 50  0001 C CNN
F 3 "" H 6150 4500 50  0001 C CNN
	1    6150 4500
	1    0    0    -1  
$EndComp
Wire Wire Line
	6150 4500 6150 4350
Connection ~ 6150 4350
Wire Wire Line
	8000 4050 8100 4050
Connection ~ 8100 4050
Wire Wire Line
	8100 4050 8150 4050
Connection ~ 8200 4050
Wire Wire Line
	8200 4050 8300 4050
Wire Wire Line
	8150 4150 8150 4050
Connection ~ 8150 4050
Wire Wire Line
	8150 4050 8200 4050
Text Label 5250 3600 0    50   ~ 0
TXEN
Text Label 5200 3900 0    50   ~ 0
RXEN
Wire Wire Line
	5150 3900 5400 3900
Wire Wire Line
	5400 3900 5400 3700
Wire Wire Line
	5400 3700 5450 3700
Wire Wire Line
	4100 3500 5450 3500
Wire Wire Line
	1500 1000 1600 1000
Wire Wire Line
	1500 1100 1600 1100
Wire Wire Line
	1500 1200 1600 1200
Wire Wire Line
	1500 1300 1600 1300
Wire Wire Line
	1500 1450 1600 1450
Wire Wire Line
	1500 1550 1600 1550
$Comp
L Eldalote-General:nRF24L01P U801
U 1 1 5FF805DF
P 1750 2800
F 0 "U801" H 1300 3300 50  0000 C CNN
F 1 "nRF24L01P" H 1400 3200 50  0000 C CNN
F 2 "Eldalote-footprints:nRF24L01P-QFN-20-1EP_4x4mm_P0.5mm_EP" H 1750 3100 50  0001 C CNN
F 3 "" H 1750 3100 50  0001 C CNN
F 4 "1490-1033-1-ND " H 1750 2800 50  0001 C CNN "DigiKey"
F 5 "949-NRF24L01P-T " H 1750 2800 50  0001 C CNN "Mouser"
F 6 "C8791" H 1750 2800 50  0001 C CNN "LCSC"
	1    1750 2800
	1    0    0    -1  
$EndComp
Wire Wire Line
	6100 2850 6100 3200
Wire Wire Line
	6200 2850 6100 2850
Wire Wire Line
	6350 2850 6200 2850
Connection ~ 6200 2850
Wire Wire Line
	6200 3200 6200 2850
Connection ~ 6350 2850
Connection ~ 6550 4350
Connection ~ 6450 4350
Connection ~ 6350 4350
Connection ~ 6250 4350
Connection ~ 6050 4350
Connection ~ 5950 4350
Connection ~ 5850 4350
Wire Wire Line
	6900 3500 7250 3500
Wire Wire Line
	6550 4350 6650 4350
Wire Wire Line
	6450 4350 6550 4350
Wire Wire Line
	6350 4350 6450 4350
Wire Wire Line
	6250 4350 6350 4350
Wire Wire Line
	6150 4350 6250 4350
Wire Wire Line
	6050 4350 6150 4350
Wire Wire Line
	5950 4350 6050 4350
Wire Wire Line
	5850 4350 5950 4350
Wire Wire Line
	5750 4350 5850 4350
$Comp
L Eldalote-General:RFX2401C U802
U 1 1 5FE52657
P 5650 3400
F 0 "U802" H 5650 3550 50  0000 L CNN
F 1 "RFX2401C" H 5650 3450 50  0000 L CNN
F 2 "Package_DFN_QFN:QFN-16-1EP_3x3mm_P0.5mm_EP1.75x1.75mm" H 6250 3450 50  0001 L CNN
F 3 "http://www.skyworksinc.com/uploads/documents/RFX2401C_204359A.pdf" H 6500 3800 50  0001 L CNN
F 4 " 863-1828-1-ND " H 7050 3200 50  0001 C CNN "DigiKey"
F 5 " 477-RFX2401C " H 7000 2950 50  0001 C CNN "Mouser"
F 6 "C19213" H 6850 2850 50  0001 C CNN "LCSC"
	1    5650 3400
	1    0    0    -1  
$EndComp
Wire Wire Line
	7500 2850 7500 2800
$Comp
L power:GND #PWR0820
U 1 1 5F4AA413
P 7100 3100
F 0 "#PWR0820" H 7100 2850 50  0001 C CNN
F 1 "GND" H 7105 2927 50  0000 C CNN
F 2 "" H 7100 3100 50  0001 C CNN
F 3 "" H 7100 3100 50  0001 C CNN
	1    7100 3100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0817
U 1 1 5F4A79C2
P 6750 3100
F 0 "#PWR0817" H 6750 2850 50  0001 C CNN
F 1 "GND" H 6755 2927 50  0000 C CNN
F 2 "" H 6750 3100 50  0001 C CNN
F 3 "" H 6750 3100 50  0001 C CNN
	1    6750 3100
	1    0    0    -1  
$EndComp
Wire Wire Line
	6350 2850 6750 2850
Wire Wire Line
	6750 2850 7100 2850
Wire Wire Line
	6750 2900 6750 2850
Wire Wire Line
	7100 2850 7500 2850
Connection ~ 7100 2850
Wire Wire Line
	7100 2900 7100 2850
$Comp
L Device:C_Small C812
U 1 1 5F494D13
P 7100 3000
F 0 "C812" H 7008 2954 50  0000 R CNN
F 1 "1uF" H 7008 3045 50  0000 R CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 7138 2850 50  0001 C CNN
F 3 "~" H 7100 3000 50  0001 C CNN
F 4 "" V 7100 3000 50  0001 C CNN "JLC Part Nr"
F 5 " C52923" H 7100 3000 50  0001 C CNN "LCSC"
	1    7100 3000
	-1   0    0    1   
$EndComp
$Comp
L Device:C_Small C811
U 1 1 5F4925C7
P 6750 3000
F 0 "C811" H 6658 2954 50  0000 R CNN
F 1 "10nF" H 6658 3045 50  0000 R CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 6788 2850 50  0001 C CNN
F 3 "~" H 6750 3000 50  0001 C CNN
F 4 "" V 6750 3000 50  0001 C CNN "JLC Part Nr"
F 5 " C15195" H 6750 3000 50  0001 C CNN "LCSC"
	1    6750 3000
	-1   0    0    1   
$EndComp
$Comp
L power:+3.3V #PWR0822
U 1 1 5F47D8CA
P 7500 2800
F 0 "#PWR0822" H 7500 2650 50  0001 C CNN
F 1 "+3.3V" H 7515 2973 50  0000 C CNN
F 2 "" H 7500 2800 50  0001 C CNN
F 3 "" H 7500 2800 50  0001 C CNN
	1    7500 2800
	1    0    0    -1  
$EndComp
Connection ~ 6750 2850
$EndSCHEMATC