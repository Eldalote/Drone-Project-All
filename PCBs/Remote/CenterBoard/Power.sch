EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 3 7
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
L SamacSys_Parts:SC189ZSKTRT U301
U 1 1 5F640727
P 5150 2900
F 0 "U301" H 5625 3165 50  0000 C CNN
F 1 "SC189ZSKTRT" H 5625 3074 50  0000 C CNN
F 2 "SOT95P280X145-5N" H 6100 3000 50  0001 L CNN
F 3 "http://www.semtech.com/images/datasheet/sc189.pdf" H 6100 2900 50  0001 L CNN
F 4 "Switching Voltage Regulators 2.5MHz-1.5A SYNC STEP DOWN REG" H 6100 2800 50  0001 L CNN "Description"
F 5 "1.45" H 6100 2700 50  0001 L CNN "Height"
F 6 "947-SC189ZSKTRT" H 6100 2600 50  0001 L CNN "Mouser Part Number"
F 7 "https://www.mouser.co.uk/ProductDetail/Semtech/SC189ZSKTRT?qs=rBWM4%252BvDhIck0D%2FgoUNMIQ%3D%3D" H 6100 2500 50  0001 L CNN "Mouser Price/Stock"
F 8 "SEMTECH" H 6100 2400 50  0001 L CNN "Manufacturer_Name"
F 9 "SC189ZSKTRT" H 6100 2300 50  0001 L CNN "Manufacturer_Part_Number"
	1    5150 2900
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C302
U 1 1 5F641444
P 6800 3050
F 0 "C302" H 6892 3096 50  0000 L CNN
F 1 "22uF" H 6892 3005 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 6800 3050 50  0001 C CNN
F 3 "~" H 6800 3050 50  0001 C CNN
F 4 "C45783" H 6800 3050 50  0001 C CNN "LCSC"
	1    6800 3050
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C301
U 1 1 5F64184D
P 4500 3050
F 0 "C301" H 4592 3096 50  0000 L CNN
F 1 "10uF" H 4592 3005 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 4500 3050 50  0001 C CNN
F 3 "~" H 4500 3050 50  0001 C CNN
F 4 "C15850" H 4500 3050 50  0001 C CNN "LCSC"
F 5 "1276-2891-1-ND" H 4500 3050 50  0001 C CNN "DigiKey"
F 6 "187-CL21A106KAYNNNE" H 4500 3050 50  0001 C CNN "Mouser"
	1    4500 3050
	1    0    0    -1  
$EndComp
$Comp
L Device:L L301
U 1 1 5F641EA5
P 6450 2900
F 0 "L301" V 6640 2900 50  0000 C CNN
F 1 "1uH" V 6549 2900 50  0000 C CNN
F 2 "Eldalote-footprints:L_3012_TDK" H 6450 2900 50  0001 C CNN
F 3 "~" H 6450 2900 50  0001 C CNN
F 4 "810-VLS3012CX-1R0M-1 " V 6450 2900 50  0001 C CNN "Mouser"
F 5 "445-180921-1-ND " V 6450 2900 50  0001 C CNN "DigiKey"
	1    6450 2900
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR0303
U 1 1 5F64278D
P 5600 3550
F 0 "#PWR0303" H 5600 3300 50  0001 C CNN
F 1 "GND" H 5605 3377 50  0000 C CNN
F 2 "" H 5600 3550 50  0001 C CNN
F 3 "" H 5600 3550 50  0001 C CNN
	1    5600 3550
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0302
U 1 1 5F642C6B
P 4500 3250
F 0 "#PWR0302" H 4500 3000 50  0001 C CNN
F 1 "GND" H 4505 3077 50  0000 C CNN
F 2 "" H 4500 3250 50  0001 C CNN
F 3 "" H 4500 3250 50  0001 C CNN
	1    4500 3250
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0304
U 1 1 5F642EA6
P 6800 3250
F 0 "#PWR0304" H 6800 3000 50  0001 C CNN
F 1 "GND" H 6805 3077 50  0000 C CNN
F 2 "" H 6800 3250 50  0001 C CNN
F 3 "" H 6800 3250 50  0001 C CNN
	1    6800 3250
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0301
U 1 1 5F643827
P 4050 2900
F 0 "#PWR0301" H 4050 2750 50  0001 C CNN
F 1 "+5V" H 4065 3073 50  0000 C CNN
F 2 "" H 4050 2900 50  0001 C CNN
F 3 "" H 4050 2900 50  0001 C CNN
	1    4050 2900
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR0305
U 1 1 5F643F44
P 7050 2800
F 0 "#PWR0305" H 7050 2650 50  0001 C CNN
F 1 "+3.3V" H 7065 2973 50  0000 C CNN
F 2 "" H 7050 2800 50  0001 C CNN
F 3 "" H 7050 2800 50  0001 C CNN
	1    7050 2800
	1    0    0    -1  
$EndComp
Wire Wire Line
	5150 2900 4900 2900
Wire Wire Line
	5600 3450 5600 3550
Wire Wire Line
	4500 3150 4500 3250
Wire Wire Line
	4500 2950 4500 2900
Connection ~ 4500 2900
Wire Wire Line
	4500 2900 4050 2900
Wire Wire Line
	5150 3100 4900 3100
Wire Wire Line
	4900 3100 4900 2900
Connection ~ 4900 2900
Wire Wire Line
	4900 2900 4500 2900
Wire Wire Line
	6100 2900 6300 2900
Wire Wire Line
	6600 2900 6650 2900
Wire Wire Line
	6800 2950 6800 2900
Connection ~ 6800 2900
Wire Wire Line
	6800 2900 7050 2900
Wire Wire Line
	6100 3100 6650 3100
Wire Wire Line
	6650 3100 6650 2900
Connection ~ 6650 2900
Wire Wire Line
	6650 2900 6800 2900
Wire Wire Line
	6800 3150 6800 3250
Text Label 6250 2900 1    50   ~ 0
3v3_LX
Wire Wire Line
	7050 2800 7050 2850
$Comp
L power:PWR_FLAG #FLG0301
U 1 1 5FD16A71
P 7050 2850
F 0 "#FLG0301" H 7050 2925 50  0001 C CNN
F 1 "PWR_FLAG" V 7050 2978 50  0000 L CNN
F 2 "" H 7050 2850 50  0001 C CNN
F 3 "~" H 7050 2850 50  0001 C CNN
	1    7050 2850
	0    1    1    0   
$EndComp
Connection ~ 7050 2850
Wire Wire Line
	7050 2850 7050 2900
$EndSCHEMATC
