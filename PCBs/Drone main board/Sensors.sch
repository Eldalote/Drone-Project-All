EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 7 15
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
L Sensor_Motion:BNO055 U703
U 1 1 5F4BD31D
P 5000 2050
F 0 "U703" H 5250 2800 50  0000 C CNN
F 1 "BNO055" H 5300 2700 50  0000 C CNN
F 2 "Package_LGA:LGA-28_5.2x3.8mm_P0.5mm" H 5250 1400 50  0001 L CNN
F 3 "https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST_BNO055_DS000_14.pdf" H 5000 2250 50  0001 C CNN
F 4 "828-1058-1-ND" H 5000 2050 50  0001 C CNN "DigiKey"
F 5 "262-BNO055 " H 5000 2050 50  0001 C CNN "Mouser"
	1    5000 2050
	1    0    0    -1  
$EndComp
$Comp
L 2020-08-24_12-35-16:DPS422XTSA1 U704
U 1 1 5F4C1DB6
P 7550 1400
F 0 "U704" H 8500 1350 60  0000 C CNN
F 1 "DPS422XTSA1" H 8700 1250 60  0000 C CNN
F 2 "footprints:DPS422XTSA1" H 8350 1640 60  0001 C CNN
F 3 "" H 7550 1400 60  0000 C CNN
F 4 "DPS422XTSA1CT-ND" H 7550 1400 50  0001 C CNN "DigiKey"
F 5 "726-DPS422XTSA1 " H 7550 1400 50  0001 C CNN "Mouser"
	1    7550 1400
	1    0    0    -1  
$EndComp
$Comp
L dk_Logic-Translators-Level-Shifters:TXB0108PWR U702
U 1 1 5F5EB69B
P 4900 4950
F 0 "U702" H 5250 4450 60  0000 C CNN
F 1 "TXB0108PWR" H 5400 4350 60  0000 C CNN
F 2 "digikey-footprints:TSSOP-20_W4.4mm" H 5100 5150 60  0001 L CNN
F 3 "http://www.ti.com/general/docs/suppproductinfo.tsp?distId=10&gotoUrl=http%3A%2F%2Fwww.ti.com%2Flit%2Fgpn%2Ftxb0108" H 5100 5250 60  0001 L CNN
F 4 "296-21527-1-ND" H 5100 5350 60  0001 L CNN "Digi-Key_PN"
F 5 "TXB0108PWR" H 5100 5450 60  0001 L CNN "MPN"
F 6 "Integrated Circuits (ICs)" H 5100 5550 60  0001 L CNN "Category"
F 7 "Logic - Translators, Level Shifters" H 5100 5650 60  0001 L CNN "Family"
F 8 "http://www.ti.com/general/docs/suppproductinfo.tsp?distId=10&gotoUrl=http%3A%2F%2Fwww.ti.com%2Flit%2Fgpn%2Ftxb0108" H 5100 5750 60  0001 L CNN "DK_Datasheet_Link"
F 9 "/product-detail/en/texas-instruments/TXB0108PWR/296-21527-1-ND/1305700" H 5100 5850 60  0001 L CNN "DK_Detail_Page"
F 10 "IC TRNSLTR BIDIRECTIONAL 20TSSOP" H 5100 5950 60  0001 L CNN "Description"
F 11 "Texas Instruments" H 5100 6050 60  0001 L CNN "Manufacturer"
F 12 "Active" H 5100 6150 60  0001 L CNN "Status"
	1    4900 4950
	1    0    0    -1  
$EndComp
$Comp
L Sensor_Motion:ICM-20602 U701
U 1 1 5F6639B8
P 1900 1850
F 0 "U701" H 2100 2400 50  0000 C CNN
F 1 "ICM-20602" H 2250 2300 50  0000 C CNN
F 2 "Package_LGA:LGA-16_3x3mm_P0.5mm_LayoutBorder3x5y" H 1900 2100 50  0001 C CNN
F 3 "http://www.invensense.com/wp-content/uploads/2016/10/DS-000176-ICM-20602-v1.0.pdf" H 1950 2800 50  0001 C CNN
F 4 "410-ICM-20602" H 1900 1850 50  0001 C CNN "Mouser"
F 5 "1428-1060-1-ND" H 1900 1850 50  0001 C CNN "DigiKey"
	1    1900 1850
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C702
U 1 1 5F66628C
P 1550 1100
F 0 "C702" H 1642 1146 50  0000 L CNN
F 1 "2u2F" H 1642 1055 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 1550 1100 50  0001 C CNN
F 3 "~" H 1550 1100 50  0001 C CNN
F 4 "C23630" H 1550 1100 50  0001 C CNN "LCSC"
	1    1550 1100
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C701
U 1 1 5F666C14
P 1150 1100
F 0 "C701" H 1242 1146 50  0000 L CNN
F 1 "100nF" H 1242 1055 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 1150 1100 50  0001 C CNN
F 3 "~" H 1150 1100 50  0001 C CNN
F 4 "C1525" H 1150 1100 50  0001 C CNN "LCSC"
	1    1150 1100
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C704
U 1 1 5F666E9C
P 2550 1100
F 0 "C704" H 2642 1146 50  0000 L CNN
F 1 "10nF" H 2642 1055 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 2550 1100 50  0001 C CNN
F 3 "~" H 2550 1100 50  0001 C CNN
F 4 "C15195" H 2550 1100 50  0001 C CNN "LCSC"
	1    2550 1100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0703
U 1 1 5F667830
P 1900 2650
F 0 "#PWR0703" H 1900 2400 50  0001 C CNN
F 1 "GND" H 1905 2477 50  0000 C CNN
F 2 "" H 1900 2650 50  0001 C CNN
F 3 "" H 1900 2650 50  0001 C CNN
	1    1900 2650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0704
U 1 1 5F667CC9
P 2500 2300
F 0 "#PWR0704" H 2500 2050 50  0001 C CNN
F 1 "GND" H 2505 2127 50  0000 C CNN
F 2 "" H 2500 2300 50  0001 C CNN
F 3 "" H 2500 2300 50  0001 C CNN
	1    2500 2300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0702
U 1 1 5F667E20
P 1350 1350
F 0 "#PWR0702" H 1350 1100 50  0001 C CNN
F 1 "GND" H 1355 1177 50  0000 C CNN
F 2 "" H 1350 1350 50  0001 C CNN
F 3 "" H 1350 1350 50  0001 C CNN
	1    1350 1350
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0705
U 1 1 5F6685A1
P 2550 1300
F 0 "#PWR0705" H 2550 1050 50  0001 C CNN
F 1 "GND" H 2555 1127 50  0000 C CNN
F 2 "" H 2550 1300 50  0001 C CNN
F 3 "" H 2550 1300 50  0001 C CNN
	1    2550 1300
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR0701
U 1 1 5F6696AE
P 1000 900
F 0 "#PWR0701" H 1000 750 50  0001 C CNN
F 1 "+3.3V" H 1015 1073 50  0000 C CNN
F 2 "" H 1000 900 50  0001 C CNN
F 3 "" H 1000 900 50  0001 C CNN
	1    1000 900 
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR0706
U 1 1 5F669E09
P 2700 900
F 0 "#PWR0706" H 2700 750 50  0001 C CNN
F 1 "+3.3V" H 2715 1073 50  0000 C CNN
F 2 "" H 2700 900 50  0001 C CNN
F 3 "" H 2700 900 50  0001 C CNN
	1    2700 900 
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C703
U 1 1 5F66AD24
P 2500 2100
F 0 "C703" H 2592 2146 50  0000 L CNN
F 1 "100nF" H 2592 2055 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 2500 2100 50  0001 C CNN
F 3 "~" H 2500 2100 50  0001 C CNN
F 4 "C1525" H 2500 2100 50  0001 C CNN "LCSC"
	1    2500 2100
	1    0    0    -1  
$EndComp
Wire Wire Line
	1000 900  1150 900 
Wire Wire Line
	1150 900  1150 1000
Wire Wire Line
	1550 1000 1550 900 
Wire Wire Line
	1550 900  1150 900 
Wire Wire Line
	1150 1200 1150 1250
Wire Wire Line
	1150 1250 1350 1250
Wire Wire Line
	1550 1250 1550 1200
Connection ~ 1350 1250
Wire Wire Line
	1350 1250 1550 1250
Wire Wire Line
	2550 1200 2550 1300
Wire Wire Line
	1550 900  1900 900 
Wire Wire Line
	1900 900  1900 1350
Connection ~ 1550 900 
Wire Wire Line
	2000 900  2000 1350
Connection ~ 1150 900 
Wire Wire Line
	2700 900  2550 900 
Wire Wire Line
	2550 900  2550 1000
Connection ~ 2550 900 
Wire Wire Line
	2550 900  2000 900 
Wire Wire Line
	1350 1250 1350 1350
Wire Wire Line
	2400 1950 2500 1950
Wire Wire Line
	2500 1950 2500 2000
Wire Wire Line
	2500 2200 2500 2300
Wire Wire Line
	1900 2350 1900 2650
Wire Notes Line
	750  600  2900 600 
Wire Notes Line
	2900 600  2900 2950
Wire Notes Line
	2900 2950 750  2950
Wire Notes Line
	750  2950 750  600 
Text Notes 1700 600  0    50   ~ 0
ICM 20602 (top)
Wire Wire Line
	1400 1750 1000 1750
Wire Wire Line
	1400 1850 1000 1850
Wire Wire Line
	1400 1950 1000 1950
Wire Wire Line
	1400 2050 1000 2050
Text Label 1000 1750 0    50   ~ 0
ICM_MISO
Text Label 1000 1850 0    50   ~ 0
ICM_MOSI
Text Label 1000 1950 0    50   ~ 0
ICM_SCLK
Text Label 1000 2050 0    50   ~ 0
ICM_CSn
Wire Wire Line
	2400 1750 2600 1750
Wire Wire Line
	2400 1850 2600 1850
Text Label 2500 1750 0    50   ~ 0
ICM_INT
Text Label 2500 1850 0    50   ~ 0
ICM_FSYNC
$Comp
L Device:C_Small C710
U 1 1 5F67A865
P 5950 1100
F 0 "C710" H 6042 1146 50  0000 L CNN
F 1 "4n7F" H 6042 1055 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 5950 1100 50  0001 C CNN
F 3 "~" H 5950 1100 50  0001 C CNN
F 4 "C53987" H 5950 1100 50  0001 C CNN "LCSC"
	1    5950 1100
	1    0    0    -1  
$EndComp
$Comp
L Device:R R702
U 1 1 5F67AE36
P 3650 2050
F 0 "R702" V 3750 1950 50  0000 L CNN
F 1 "4k7" V 3650 1950 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 3580 2050 50  0001 C CNN
F 3 "~" H 3650 2050 50  0001 C CNN
F 4 "C25900" H 3650 2050 50  0001 C CNN "LCSC"
	1    3650 2050
	1    0    0    -1  
$EndComp
$Comp
L Device:R R703
U 1 1 5F67C072
P 3950 1300
F 0 "R703" V 4050 1200 50  0000 L CNN
F 1 "10k" V 3950 1200 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 3880 1300 50  0001 C CNN
F 3 "~" H 3950 1300 50  0001 C CNN
F 4 "C25744" H 3950 1300 50  0001 C CNN "LCSC"
	1    3950 1300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0710
U 1 1 5F67C854
P 4000 2650
F 0 "#PWR0710" H 4000 2400 50  0001 C CNN
F 1 "GND" H 4005 2477 50  0000 C CNN
F 2 "" H 4000 2650 50  0001 C CNN
F 3 "" H 4000 2650 50  0001 C CNN
	1    4000 2650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0717
U 1 1 5F67CDFF
P 4900 2950
F 0 "#PWR0717" H 4900 2700 50  0001 C CNN
F 1 "GND" H 4905 2777 50  0000 C CNN
F 2 "" H 4900 2950 50  0001 C CNN
F 3 "" H 4900 2950 50  0001 C CNN
	1    4900 2950
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0719
U 1 1 5F67D0FA
P 5100 2950
F 0 "#PWR0719" H 5100 2700 50  0001 C CNN
F 1 "GND" H 5105 2777 50  0000 C CNN
F 2 "" H 5100 2950 50  0001 C CNN
F 3 "" H 5100 2950 50  0001 C CNN
	1    5100 2950
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0723
U 1 1 5F67D240
P 5750 2950
F 0 "#PWR0723" H 5750 2700 50  0001 C CNN
F 1 "GND" H 5755 2777 50  0000 C CNN
F 2 "" H 5750 2950 50  0001 C CNN
F 3 "" H 5750 2950 50  0001 C CNN
	1    5750 2950
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0724
U 1 1 5F67D98C
P 6100 2500
F 0 "#PWR0724" H 6100 2250 50  0001 C CNN
F 1 "GND" H 6105 2327 50  0000 C CNN
F 2 "" H 6100 2500 50  0001 C CNN
F 3 "" H 6100 2500 50  0001 C CNN
	1    6100 2500
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0726
U 1 1 5F67FBCE
P 6400 2100
F 0 "#PWR0726" H 6400 1850 50  0001 C CNN
F 1 "GND" H 6405 1927 50  0000 C CNN
F 2 "" H 6400 2100 50  0001 C CNN
F 3 "" H 6400 2100 50  0001 C CNN
	1    6400 2100
	1    0    0    -1  
$EndComp
$Comp
L Device:Crystal Y701
U 1 1 5F681AC9
P 5850 1800
F 0 "Y701" V 5804 1931 50  0000 L CNN
F 1 "32.7KHz" V 5895 1931 50  0000 L CNN
F 2 "Crystal:Crystal_SMD_3215-2Pin_3.2x1.5mm" H 5850 1800 50  0001 C CNN
F 3 "~" H 5850 1800 50  0001 C CNN
F 4 "C32346" V 5850 1800 50  0001 C CNN "LCSC"
	1    5850 1800
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C711
U 1 1 5F683264
P 6100 1550
F 0 "C711" V 5871 1550 50  0000 C CNN
F 1 "22pF" V 5962 1550 50  0000 C CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 6100 1550 50  0001 C CNN
F 3 "~" H 6100 1550 50  0001 C CNN
F 4 "C1653" V 6100 1550 50  0001 C CNN "LCSC"
	1    6100 1550
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C712
U 1 1 5F683583
P 6100 2050
F 0 "C712" V 6300 2000 50  0000 C CNN
F 1 "22pF" V 6200 2050 50  0000 C CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 6100 2050 50  0001 C CNN
F 3 "~" H 6100 2050 50  0001 C CNN
F 4 "C1653" V 6100 2050 50  0001 C CNN "LCSC"
	1    6100 2050
	0    1    1    0   
$EndComp
Wire Wire Line
	5600 1550 5850 1550
Wire Wire Line
	6200 1550 6400 1550
Wire Wire Line
	6400 1550 6400 2050
Wire Wire Line
	6200 2050 6400 2050
Connection ~ 6400 2050
Wire Wire Line
	6400 2050 6400 2100
Wire Wire Line
	5600 2050 5850 2050
Wire Wire Line
	5850 1950 5850 2050
Connection ~ 5850 2050
Wire Wire Line
	5850 2050 6000 2050
Wire Wire Line
	5850 1650 5850 1550
Connection ~ 5850 1550
Wire Wire Line
	5850 1550 6000 1550
$Comp
L Device:C_Small C705
U 1 1 5F688207
P 4300 1100
F 0 "C705" H 4392 1146 50  0000 L CNN
F 1 "100nF" H 4392 1055 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 4300 1100 50  0001 C CNN
F 3 "~" H 4300 1100 50  0001 C CNN
F 4 "C1525" H 4300 1100 50  0001 C CNN "LCSC"
	1    4300 1100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0713
U 1 1 5F689BCE
P 4300 1250
F 0 "#PWR0713" H 4300 1000 50  0001 C CNN
F 1 "GND" H 4305 1077 50  0000 C CNN
F 2 "" H 4300 1250 50  0001 C CNN
F 3 "" H 4300 1250 50  0001 C CNN
	1    4300 1250
	1    0    0    -1  
$EndComp
Wire Wire Line
	4900 950  4900 1350
Wire Wire Line
	4100 950  4300 950 
Wire Wire Line
	4300 950  4300 1000
Connection ~ 4300 950 
Wire Wire Line
	4300 950  4900 950 
Wire Wire Line
	4300 1200 4300 1250
$Comp
L power:+3.3V #PWR0711
U 1 1 5F68BFC5
P 4100 950
F 0 "#PWR0711" H 4100 800 50  0001 C CNN
F 1 "+3.3V" H 4115 1123 50  0000 C CNN
F 2 "" H 4100 950 50  0001 C CNN
F 3 "" H 4100 950 50  0001 C CNN
	1    4100 950 
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C708
U 1 1 5F68CE98
P 5550 1100
F 0 "C708" H 5642 1146 50  0000 L CNN
F 1 "100nF" H 5642 1055 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 5550 1100 50  0001 C CNN
F 3 "~" H 5550 1100 50  0001 C CNN
F 4 "C1525" H 5550 1100 50  0001 C CNN "LCSC"
	1    5550 1100
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR0725
U 1 1 5F68E68E
P 6200 950
F 0 "#PWR0725" H 6200 800 50  0001 C CNN
F 1 "+3.3V" H 6215 1123 50  0000 C CNN
F 2 "" H 6200 950 50  0001 C CNN
F 3 "" H 6200 950 50  0001 C CNN
	1    6200 950 
	1    0    0    -1  
$EndComp
Wire Wire Line
	6200 950  5950 950 
Wire Wire Line
	5100 950  5100 1350
Wire Wire Line
	5550 1000 5550 950 
Connection ~ 5550 950 
Wire Wire Line
	5550 950  5100 950 
Wire Wire Line
	5950 1000 5950 950 
Connection ~ 5950 950 
Wire Wire Line
	5950 950  5550 950 
$Comp
L power:GND #PWR0722
U 1 1 5F690D75
P 5750 1250
F 0 "#PWR0722" H 5750 1000 50  0001 C CNN
F 1 "GND" H 5755 1077 50  0000 C CNN
F 2 "" H 5750 1250 50  0001 C CNN
F 3 "" H 5750 1250 50  0001 C CNN
	1    5750 1250
	1    0    0    -1  
$EndComp
Wire Wire Line
	5550 1200 5550 1250
Wire Wire Line
	5550 1250 5750 1250
Wire Wire Line
	5750 1250 5950 1250
Wire Wire Line
	5950 1250 5950 1200
Connection ~ 5750 1250
$Comp
L Device:C_Small C709
U 1 1 5F692F80
P 5750 2700
F 0 "C709" H 5842 2746 50  0000 L CNN
F 1 "100nF" H 5842 2655 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 5750 2700 50  0001 C CNN
F 3 "~" H 5750 2700 50  0001 C CNN
F 4 "C1525" H 5750 2700 50  0001 C CNN "LCSC"
	1    5750 2700
	1    0    0    -1  
$EndComp
Wire Wire Line
	5600 2550 5750 2550
Wire Wire Line
	5750 2550 5750 2600
Wire Wire Line
	5750 2800 5750 2950
Wire Wire Line
	5100 2750 5100 2950
Wire Wire Line
	4900 2750 4900 2950
Wire Wire Line
	4400 2550 4000 2550
Wire Wire Line
	4000 2550 4000 2650
Wire Wire Line
	4400 2450 4000 2450
Wire Wire Line
	4000 2450 4000 2550
Connection ~ 4000 2550
Wire Wire Line
	4400 2350 3400 2350
Text Label 3750 2250 0    50   ~ 0
BNO_SDA
Text Label 3750 2350 0    50   ~ 0
BNO_SCL
Wire Wire Line
	3400 2350 3400 2300
Wire Wire Line
	3650 2250 3650 2200
Wire Wire Line
	3650 2250 4400 2250
$Comp
L power:+3.3V #PWR0708
U 1 1 5F6A0692
P 3650 1850
F 0 "#PWR0708" H 3650 1700 50  0001 C CNN
F 1 "+3.3V" V 3665 1978 50  0000 L CNN
F 2 "" H 3650 1850 50  0001 C CNN
F 3 "" H 3650 1850 50  0001 C CNN
	1    3650 1850
	0    1    1    0   
$EndComp
$Comp
L power:+3.3V #PWR0707
U 1 1 5F6A0B05
P 3400 1950
F 0 "#PWR0707" H 3400 1800 50  0001 C CNN
F 1 "+3.3V" H 3415 2123 50  0000 C CNN
F 2 "" H 3400 1950 50  0001 C CNN
F 3 "" H 3400 1950 50  0001 C CNN
	1    3400 1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	3400 1950 3400 2000
Wire Wire Line
	3650 1850 3650 1900
$Comp
L Device:R R701
U 1 1 5F6A3C3C
P 3400 2150
F 0 "R701" V 3500 2050 50  0000 L CNN
F 1 "4k7" V 3400 2050 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 3330 2150 50  0001 C CNN
F 3 "~" H 3400 2150 50  0001 C CNN
F 4 "C25900" H 3400 2150 50  0001 C CNN "LCSC"
	1    3400 2150
	1    0    0    -1  
$EndComp
NoConn ~ 4400 2050
$Comp
L power:+3.3V #PWR0712
U 1 1 5F6A62EB
P 4150 1950
F 0 "#PWR0712" H 4150 1800 50  0001 C CNN
F 1 "+3.3V" H 4165 2123 50  0000 C CNN
F 2 "" H 4150 1950 50  0001 C CNN
F 3 "" H 4150 1950 50  0001 C CNN
	1    4150 1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	4400 1950 4150 1950
Wire Wire Line
	5600 2450 6100 2450
Wire Wire Line
	6100 2450 6100 2350
Wire Wire Line
	6100 2350 5600 2350
Connection ~ 6100 2450
Wire Wire Line
	6100 2500 6100 2450
Wire Wire Line
	4400 1550 3950 1550
Wire Wire Line
	3950 1550 3950 1450
$Comp
L power:+3.3V #PWR0709
U 1 1 5F6AEF28
P 3950 1050
F 0 "#PWR0709" H 3950 900 50  0001 C CNN
F 1 "+3.3V" H 3965 1223 50  0000 C CNN
F 2 "" H 3950 1050 50  0001 C CNN
F 3 "" H 3950 1050 50  0001 C CNN
	1    3950 1050
	1    0    0    -1  
$EndComp
Wire Wire Line
	3950 1050 3950 1150
Text Label 3400 1550 0    50   ~ 0
BNO_NRESET
Connection ~ 3950 1550
Wire Wire Line
	3400 1550 3950 1550
Wire Wire Line
	4400 1750 3450 1750
Text Label 3450 1750 0    50   ~ 0
BNO_INT
Wire Notes Line
	6600 600  6600 3250
Wire Notes Line
	6600 3250 3150 3250
Wire Notes Line
	3150 3250 3150 600 
Wire Notes Line
	3150 600  6600 600 
Text Notes 4800 600  0    50   ~ 0
BNO 055 (top)
Wire Wire Line
	900  3250 1500 3250
Wire Wire Line
	900  3350 1500 3350
Wire Wire Line
	900  3450 1500 3450
Wire Wire Line
	900  3550 1500 3550
Wire Wire Line
	900  3650 1500 3650
Wire Wire Line
	900  3750 1500 3750
Wire Wire Line
	900  3950 1500 3950
Wire Wire Line
	900  4050 1500 4050
Wire Wire Line
	900  4150 1500 4150
Wire Wire Line
	900  4250 1500 4250
Text Label 900  3250 0    50   ~ 0
ICM_SCLK
Text Label 900  3350 0    50   ~ 0
ICM_CSn
Text Label 900  3450 0    50   ~ 0
ICM_MOSI
Text Label 900  3550 0    50   ~ 0
ICM_MISO
Text Label 900  3650 0    50   ~ 0
ICM_INT
Text Label 900  3750 0    50   ~ 0
ICM_FSYNC
Text Label 900  3950 0    50   ~ 0
BNO_SDA
Text Label 900  4050 0    50   ~ 0
BNO_SCL
Text Label 900  4150 0    50   ~ 0
BNO_NRESET
Text Label 900  4250 0    50   ~ 0
BNO_INT
Text GLabel 1500 3250 2    50   Input ~ 0
ICM_SCLK
Text GLabel 1500 3350 2    50   Input ~ 0
ICM_CSn
Text GLabel 1500 3450 2    50   Input ~ 0
ICM_MOSI
Text GLabel 1500 3550 2    50   Input ~ 0
ICM_MISO
Text GLabel 1500 3650 2    50   Input ~ 0
ICM_INT
Text GLabel 1500 3750 2    50   Input ~ 0
ICM_FSYNC
Text GLabel 1500 3950 2    50   Input ~ 0
BNO_SDA
Text GLabel 1500 4050 2    50   Input ~ 0
BNO_SCL
Text GLabel 1500 4150 2    50   Input ~ 0
BNO_NRESET
Text GLabel 1500 4250 2    50   Input ~ 0
BNO_INT
$Comp
L Device:C_Small C713
U 1 1 5F702768
P 7750 1050
F 0 "C713" H 7842 1096 50  0000 L CNN
F 1 "100nF" H 7842 1005 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 7750 1050 50  0001 C CNN
F 3 "~" H 7750 1050 50  0001 C CNN
F 4 "C1525" H 7750 1050 50  0001 C CNN "LCSC"
	1    7750 1050
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C716
U 1 1 5F702D63
P 8500 1050
F 0 "C716" H 8592 1096 50  0000 L CNN
F 1 "100nF" H 8592 1005 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 8500 1050 50  0001 C CNN
F 3 "~" H 8500 1050 50  0001 C CNN
F 4 "C1525" H 8500 1050 50  0001 C CNN "LCSC"
	1    8500 1050
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR0727
U 1 1 5F7045D0
P 7600 900
F 0 "#PWR0727" H 7600 750 50  0001 C CNN
F 1 "+3.3V" H 7615 1073 50  0000 C CNN
F 2 "" H 7600 900 50  0001 C CNN
F 3 "" H 7600 900 50  0001 C CNN
	1    7600 900 
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR0735
U 1 1 5F704921
P 8650 900
F 0 "#PWR0735" H 8650 750 50  0001 C CNN
F 1 "+3.3V" H 8665 1073 50  0000 C CNN
F 2 "" H 8650 900 50  0001 C CNN
F 3 "" H 8650 900 50  0001 C CNN
	1    8650 900 
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0729
U 1 1 5F704BED
P 7750 1200
F 0 "#PWR0729" H 7750 950 50  0001 C CNN
F 1 "GND" H 7755 1027 50  0000 C CNN
F 2 "" H 7750 1200 50  0001 C CNN
F 3 "" H 7750 1200 50  0001 C CNN
	1    7750 1200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0733
U 1 1 5F704F35
P 8500 1200
F 0 "#PWR0733" H 8500 950 50  0001 C CNN
F 1 "GND" H 8505 1027 50  0000 C CNN
F 2 "" H 8500 1200 50  0001 C CNN
F 3 "" H 8500 1200 50  0001 C CNN
	1    8500 1200
	1    0    0    -1  
$EndComp
Wire Wire Line
	7600 900  7750 900 
Wire Wire Line
	8100 900  8100 1100
Wire Wire Line
	8250 900  8250 1100
Wire Wire Line
	8500 900  8500 950 
Connection ~ 8500 900 
Wire Wire Line
	8500 900  8250 900 
Wire Wire Line
	8500 900  8650 900 
Wire Wire Line
	8500 1150 8500 1200
Wire Wire Line
	7750 1150 7750 1200
Wire Wire Line
	7750 950  7750 900 
Connection ~ 7750 900 
Wire Wire Line
	7750 900  8100 900 
Wire Wire Line
	7550 1500 7150 1500
Wire Wire Line
	7550 1600 7150 1600
Wire Wire Line
	7550 1700 7150 1700
Wire Wire Line
	7550 1800 7150 1800
Text Label 7150 1500 0    50   ~ 0
DPS_CSn
Text Label 7150 1600 0    50   ~ 0
DPS_MOSI
Text Label 7150 1700 0    50   ~ 0
DPS_SCLK
Text Label 7150 1800 0    50   ~ 0
DPS_MISO
$Comp
L power:GND #PWR0732
U 1 1 5F727896
P 8250 2300
F 0 "#PWR0732" H 8250 2050 50  0001 C CNN
F 1 "GND" H 8255 2127 50  0000 C CNN
F 2 "" H 8250 2300 50  0001 C CNN
F 3 "" H 8250 2300 50  0001 C CNN
	1    8250 2300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0731
U 1 1 5F727CD4
P 8100 2300
F 0 "#PWR0731" H 8100 2050 50  0001 C CNN
F 1 "GND" H 8105 2127 50  0000 C CNN
F 2 "" H 8100 2300 50  0001 C CNN
F 3 "" H 8100 2300 50  0001 C CNN
	1    8100 2300
	1    0    0    -1  
$EndComp
Wire Wire Line
	8250 2250 8250 2300
Wire Wire Line
	8100 2250 8100 2300
Wire Notes Line
	7000 600  9050 600 
Wire Notes Line
	9050 600  9050 2600
Wire Notes Line
	9050 2600 7000 2600
Wire Notes Line
	7000 2600 7000 600 
Text Notes 7950 600  0    50   ~ 0
DPS422 (top)
Wire Wire Line
	900  4450 1500 4450
Wire Wire Line
	900  4550 1500 4550
Wire Wire Line
	900  4650 1500 4650
Wire Wire Line
	900  4750 1500 4750
Text Label 900  4450 0    50   ~ 0
DPS_SCLK
Text Label 900  4550 0    50   ~ 0
DPS_CSn
Text Label 900  4650 0    50   ~ 0
DPS_MOSI
Text Label 900  4750 0    50   ~ 0
DPS_MISO
Text GLabel 1500 4450 2    50   Input ~ 0
DPS_SCLK
Text GLabel 1500 4550 2    50   Input ~ 0
DPS_CSn
Text GLabel 1500 4650 2    50   Input ~ 0
DPS_MOSI
Text GLabel 1500 4750 2    50   Input ~ 0
DPS_MISO
$Comp
L power:GND #PWR0718
U 1 1 5F7EE9A3
P 4900 5750
F 0 "#PWR0718" H 4900 5500 50  0001 C CNN
F 1 "GND" H 4905 5577 50  0000 C CNN
F 2 "" H 4900 5750 50  0001 C CNN
F 3 "" H 4900 5750 50  0001 C CNN
	1    4900 5750
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0714
U 1 1 5F7EF668
P 4300 5900
F 0 "#PWR0714" H 4300 5650 50  0001 C CNN
F 1 "GND" H 4305 5727 50  0000 C CNN
F 2 "" H 4300 5900 50  0001 C CNN
F 3 "" H 4300 5900 50  0001 C CNN
	1    4300 5900
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0716
U 1 1 5F7EFB5A
P 4450 4350
F 0 "#PWR0716" H 4450 4100 50  0001 C CNN
F 1 "GND" H 4455 4177 50  0000 C CNN
F 2 "" H 4450 4350 50  0001 C CNN
F 3 "" H 4450 4350 50  0001 C CNN
	1    4450 4350
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C706
U 1 1 5F7F16ED
P 4450 4200
F 0 "C706" H 4542 4246 50  0000 L CNN
F 1 "100nF" H 4542 4155 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 4450 4200 50  0001 C CNN
F 3 "~" H 4450 4200 50  0001 C CNN
F 4 "187-CL21B104KACNNNC " H 4450 4200 50  0001 C CNN "Mouser"
F 5 "1276-1099-1-ND " H 4450 4200 50  0001 C CNN "DigiKey"
	1    4450 4200
	1    0    0    -1  
$EndComp
Wire Wire Line
	4450 4300 4450 4350
Wire Wire Line
	5300 4300 5300 4350
Wire Wire Line
	5000 4050 5000 4350
Wire Wire Line
	4350 4050 4450 4050
Wire Wire Line
	4800 4050 4800 4350
$Comp
L power:+3.3V #PWR0715
U 1 1 5F804B13
P 4350 4050
F 0 "#PWR0715" H 4350 3900 50  0001 C CNN
F 1 "+3.3V" H 4365 4223 50  0000 C CNN
F 2 "" H 4350 4050 50  0001 C CNN
F 3 "" H 4350 4050 50  0001 C CNN
	1    4350 4050
	1    0    0    -1  
$EndComp
Wire Wire Line
	4450 4100 4450 4050
Connection ~ 4450 4050
Wire Wire Line
	4450 4050 4800 4050
Wire Wire Line
	5300 4100 5300 4050
Wire Wire Line
	5300 4050 5000 4050
Wire Wire Line
	4900 5650 4900 5750
$Comp
L Device:R R704
U 1 1 5F81452C
P 4300 5700
F 0 "R704" H 4370 5746 50  0000 L CNN
F 1 "10K" H 4370 5655 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 4230 5700 50  0001 C CNN
F 3 "~" H 4300 5700 50  0001 C CNN
F 4 "603-RC0805FR-0710KL " H 4300 5700 50  0001 C CNN "Mouser"
F 5 "311-10.0KCRCT-ND " H 4300 5700 50  0001 C CNN "DigiKey"
	1    4300 5700
	1    0    0    -1  
$EndComp
Wire Wire Line
	4500 5450 4300 5450
Wire Wire Line
	4300 5450 4300 5550
Wire Wire Line
	4300 5850 4300 5900
Wire Wire Line
	3750 4650 4500 4650
Wire Wire Line
	3750 4750 4500 4750
Wire Wire Line
	3750 4850 4500 4850
Wire Wire Line
	3750 4950 4500 4950
Text Label 3750 4650 0    50   ~ 0
5v_GPIO_3v3_0
Text Label 3750 4750 0    50   ~ 0
5v_GPIO_3v3_1
Text Label 3750 4850 0    50   ~ 0
5v_GPIO_3v3_2
Text Label 3750 4950 0    50   ~ 0
5v_GPIO_3v3_3
Wire Wire Line
	4500 5050 3750 5050
Wire Wire Line
	4500 5150 3750 5150
Wire Wire Line
	4500 5250 3750 5250
Wire Wire Line
	4500 5350 3750 5350
Text Label 3750 5050 0    50   ~ 0
ADC_CSn
Text Label 3750 5150 0    50   ~ 0
ADC_MOSI
Text Label 3750 5250 0    50   ~ 0
ADC_MISO
Text Label 3750 5350 0    50   ~ 0
ADC_SCLK
Wire Wire Line
	900  5450 1500 5450
Wire Wire Line
	900  5550 1500 5550
Wire Wire Line
	900  5650 1500 5650
Wire Wire Line
	900  5750 1500 5750
Text Label 900  5450 0    50   ~ 0
5v_GPIO_3v3_0
Text Label 900  5550 0    50   ~ 0
5v_GPIO_3v3_1
Text Label 900  5650 0    50   ~ 0
5v_GPIO_3v3_2
Text Label 900  5750 0    50   ~ 0
5v_GPIO_3v3_3
Wire Wire Line
	1500 4950 900  4950
Wire Wire Line
	1500 5050 900  5050
Wire Wire Line
	1500 5150 900  5150
Wire Wire Line
	1500 5250 900  5250
Text Label 900  4950 0    50   ~ 0
ADC_CSn
Text Label 900  5050 0    50   ~ 0
ADC_MOSI
Text Label 900  5150 0    50   ~ 0
ADC_MISO
Text Label 900  5250 0    50   ~ 0
ADC_SCLK
Text GLabel 1500 4950 2    50   Input ~ 0
ADC_CSn
Text GLabel 1500 5050 2    50   Input ~ 0
ADC_MOSI
Text GLabel 1500 5150 2    50   Input ~ 0
ADC_MISO
Text GLabel 1500 5250 2    50   Input ~ 0
ADC_SCLK
Text GLabel 1500 5450 2    50   Input ~ 0
5v_GPIO_0
Text GLabel 1500 5550 2    50   Input ~ 0
5v_GPIO_1
Text GLabel 1500 5650 2    50   Input ~ 0
5v_GPIO_2
Text GLabel 1500 5750 2    50   Input ~ 0
5v_GPIO_3
Wire Wire Line
	900  5950 1500 5950
Wire Wire Line
	900  6050 1500 6050
Wire Wire Line
	900  6150 1500 6150
Wire Wire Line
	900  6250 1500 6250
Wire Wire Line
	900  6350 1500 6350
Wire Wire Line
	900  6450 1500 6450
Wire Wire Line
	900  6550 1500 6550
Wire Wire Line
	900  6650 1500 6650
Text Label 900  5950 0    50   ~ 0
ADC_CH0
Text Label 900  6050 0    50   ~ 0
ADC_CH1
Text Label 900  6150 0    50   ~ 0
ADC_CH2
Text Label 900  6250 0    50   ~ 0
ADC_CH3
Text Label 900  6350 0    50   ~ 0
ADC_CH4
Text Label 900  6450 0    50   ~ 0
ADC_CH5
Text Label 900  6550 0    50   ~ 0
ADC_CH6
Text Label 900  6650 0    50   ~ 0
ADC_CH7
Text GLabel 1500 5950 2    50   Input ~ 0
ADC_CH0
Text GLabel 1500 6050 2    50   Input ~ 0
ADC_CH1
Text GLabel 1500 6150 2    50   Input ~ 0
ADC_CH2
Text GLabel 1500 6250 2    50   Input ~ 0
ADC_CH3
Text GLabel 1500 6350 2    50   Input ~ 0
ADC_CH4
Text GLabel 1500 6450 2    50   Input ~ 0
ADC_CH5
Text GLabel 1500 6550 2    50   Input ~ 0
ADC_CH6
Text GLabel 1500 6650 2    50   Input ~ 0
ADC_CH7
Text Notes 1550 3050 2    50   ~ 0
Sheet IO
Connection ~ 5300 4050
Text Label 5850 4950 2    50   ~ 0
5v_GPIO_5v_3
Text Label 5850 4850 2    50   ~ 0
5v_GPIO_5v_2
Text Label 5850 4750 2    50   ~ 0
5v_GPIO_5v_1
Text Label 5850 4650 2    50   ~ 0
5v_GPIO_5v_0
Wire Wire Line
	5200 4950 5850 4950
Wire Wire Line
	5200 4850 5850 4850
Wire Wire Line
	5200 4750 5850 4750
Wire Wire Line
	5200 4650 5850 4650
$Comp
L power:+5V #PWR0721
U 1 1 5F8046A8
P 5500 4050
F 0 "#PWR0721" H 5500 3900 50  0001 C CNN
F 1 "+5V" H 5515 4223 50  0000 C CNN
F 2 "" H 5500 4050 50  0001 C CNN
F 3 "" H 5500 4050 50  0001 C CNN
	1    5500 4050
	1    0    0    -1  
$EndComp
Wire Wire Line
	5500 4050 5300 4050
$Comp
L Device:C_Small C707
U 1 1 5F7EFE8F
P 5300 4200
F 0 "C707" H 5392 4246 50  0000 L CNN
F 1 "100nF" H 5392 4155 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 5300 4200 50  0001 C CNN
F 3 "~" H 5300 4200 50  0001 C CNN
F 4 "187-CL21B104KACNNNC " H 5300 4200 50  0001 C CNN "Mouser"
F 5 "1276-1099-1-ND " H 5300 4200 50  0001 C CNN "DigiKey"
	1    5300 4200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0720
U 1 1 5F7EF80B
P 5300 4350
F 0 "#PWR0720" H 5300 4100 50  0001 C CNN
F 1 "GND" H 5305 4177 50  0000 C CNN
F 2 "" H 5300 4350 50  0001 C CNN
F 3 "" H 5300 4350 50  0001 C CNN
	1    5300 4350
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C717
U 1 1 5F758560
P 8950 4300
F 0 "C717" H 9042 4346 50  0000 L CNN
F 1 "1uF" H 9042 4255 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 8950 4300 50  0001 C CNN
F 3 "~" H 8950 4300 50  0001 C CNN
F 4 "187-CL21B105KAFNNNE " H 8950 4300 50  0001 C CNN "Mouser"
F 5 "1276-1066-1-ND " H 8950 4300 50  0001 C CNN "DigiKey"
	1    8950 4300
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C718
U 1 1 5F759AE2
P 9300 4300
F 0 "C718" H 9392 4346 50  0000 L CNN
F 1 "100nF" H 9392 4255 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 9300 4300 50  0001 C CNN
F 3 "~" H 9300 4300 50  0001 C CNN
F 4 "187-CL21B104KACNNNC " H 9300 4300 50  0001 C CNN "Mouser"
F 5 "1276-1099-1-ND " H 9300 4300 50  0001 C CNN "DigiKey"
	1    9300 4300
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C714
U 1 1 5F759EFD
P 7800 4300
F 0 "C714" H 7892 4346 50  0000 L CNN
F 1 "1uF" H 7892 4255 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 7800 4300 50  0001 C CNN
F 3 "~" H 7800 4300 50  0001 C CNN
F 4 "187-CL21B105KAFNNNE " H 7800 4300 50  0001 C CNN "Mouser"
F 5 "1276-1066-1-ND " H 7800 4300 50  0001 C CNN "DigiKey"
	1    7800 4300
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C715
U 1 1 5F75B3B7
P 8150 4300
F 0 "C715" H 8242 4346 50  0000 L CNN
F 1 "100nF" H 8242 4255 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 8150 4300 50  0001 C CNN
F 3 "~" H 8150 4300 50  0001 C CNN
F 4 "187-CL21B104KACNNNC " H 8150 4300 50  0001 C CNN "Mouser"
F 5 "1276-1099-1-ND " H 8150 4300 50  0001 C CNN "DigiKey"
	1    8150 4300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0737
U 1 1 5F75C7C8
P 9300 4500
F 0 "#PWR0737" H 9300 4250 50  0001 C CNN
F 1 "GND" H 9305 4327 50  0000 C CNN
F 2 "" H 9300 4500 50  0001 C CNN
F 3 "" H 9300 4500 50  0001 C CNN
	1    9300 4500
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0730
U 1 1 5F75CCF8
P 7800 4500
F 0 "#PWR0730" H 7800 4250 50  0001 C CNN
F 1 "GND" H 7805 4327 50  0000 C CNN
F 2 "" H 7800 4500 50  0001 C CNN
F 3 "" H 7800 4500 50  0001 C CNN
	1    7800 4500
	1    0    0    -1  
$EndComp
Wire Wire Line
	8150 4400 7800 4400
Wire Wire Line
	7800 4400 7800 4500
Connection ~ 7800 4400
Wire Wire Line
	8950 4400 9300 4400
Wire Wire Line
	9300 4400 9300 4500
Connection ~ 9300 4400
Wire Wire Line
	9450 4150 9300 4150
Wire Wire Line
	8850 4150 8850 4500
Wire Wire Line
	8950 4200 8950 4150
Connection ~ 8950 4150
Wire Wire Line
	8950 4150 8850 4150
Wire Wire Line
	9300 4200 9300 4150
Connection ~ 9300 4150
Wire Wire Line
	9300 4150 8950 4150
Wire Wire Line
	7650 4150 7800 4150
Wire Wire Line
	8550 4150 8550 4500
Wire Wire Line
	8150 4200 8150 4150
Connection ~ 8150 4150
Wire Wire Line
	8150 4150 8550 4150
Wire Wire Line
	7800 4200 7800 4150
Connection ~ 7800 4150
Wire Wire Line
	7800 4150 8150 4150
$Comp
L power:+5V #PWR0728
U 1 1 5F77F70B
P 7650 4150
F 0 "#PWR0728" H 7650 4000 50  0001 C CNN
F 1 "+5V" H 7665 4323 50  0000 C CNN
F 2 "" H 7650 4150 50  0001 C CNN
F 3 "" H 7650 4150 50  0001 C CNN
	1    7650 4150
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0738
U 1 1 5F77FBBF
P 9450 4150
F 0 "#PWR0738" H 9450 4000 50  0001 C CNN
F 1 "+5V" H 9465 4323 50  0000 C CNN
F 2 "" H 9450 4150 50  0001 C CNN
F 3 "" H 9450 4150 50  0001 C CNN
	1    9450 4150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0736
U 1 1 5F780484
P 8850 5700
F 0 "#PWR0736" H 8850 5450 50  0001 C CNN
F 1 "GND" H 8855 5527 50  0000 C CNN
F 2 "" H 8850 5700 50  0001 C CNN
F 3 "" H 8850 5700 50  0001 C CNN
	1    8850 5700
	1    0    0    -1  
$EndComp
$Comp
L power:GNDA #PWR0734
U 1 1 5F780D45
P 8550 5700
F 0 "#PWR0734" H 8550 5450 50  0001 C CNN
F 1 "GNDA" H 8555 5527 50  0000 C CNN
F 2 "" H 8550 5700 50  0001 C CNN
F 3 "" H 8550 5700 50  0001 C CNN
	1    8550 5700
	1    0    0    -1  
$EndComp
Wire Wire Line
	8550 5600 8550 5650
Wire Wire Line
	8850 5600 8850 5650
Wire Wire Line
	8050 4700 7200 4700
Wire Wire Line
	8050 4800 7200 4800
Wire Wire Line
	8050 4900 7200 4900
Wire Wire Line
	8050 5000 7200 5000
Wire Wire Line
	8050 5100 7200 5100
Wire Wire Line
	8050 5200 7200 5200
Wire Wire Line
	8050 5300 7200 5300
Wire Wire Line
	8050 5400 7200 5400
Wire Wire Line
	9250 5200 9900 5200
Wire Wire Line
	9250 5100 9900 5100
Wire Wire Line
	9250 5000 9900 5000
Wire Wire Line
	9250 4900 9900 4900
Text Label 7200 4700 0    50   ~ 0
ADC_CH0
Text Label 7200 4800 0    50   ~ 0
ADC_CH1
Text Label 7200 4900 0    50   ~ 0
ADC_CH2
Text Label 7200 5000 0    50   ~ 0
ADC_CH3
Text Label 7200 5100 0    50   ~ 0
ADC_CH4
Text Label 7200 5200 0    50   ~ 0
ADC_CH5
Text Label 7200 5300 0    50   ~ 0
ADC_CH6
Text Label 7200 5400 0    50   ~ 0
ADC_CH7
Text Label 9900 4900 2    50   ~ 0
5v_ADC_CLK
Text Label 9900 5000 2    50   ~ 0
5v_ADC_Dout
Text Label 9900 5100 2    50   ~ 0
5v_ADC_Din
Text Label 9900 5200 2    50   ~ 0
5v_ADC_CSn
Wire Notes Line
	3350 3550 6200 3550
Wire Notes Line
	6200 6350 3350 6350
Wire Notes Line
	3350 6350 3350 3550
Wire Notes Line
	6900 3600 10150 3600
Wire Notes Line
	10150 3600 10150 6050
Wire Notes Line
	10150 6050 6900 6050
Wire Notes Line
	6900 6050 6900 3600
Text Notes 5150 3550 2    50   ~ 0
5v-3v3 level translator (bottom)
Text Notes 8700 3600 2    50   ~ 0
ADC (bottom)
$Comp
L Device:Net-Tie_2 NT701
U 1 1 5F8EC7DF
P 8700 5650
F 0 "NT701" H 8700 5600 50  0000 C CNN
F 1 "Net-Tie_2" H 9100 5650 50  0000 C CNN
F 2 "NetTie:NetTie-2_SMD_Pad0.5mm" H 8700 5650 50  0001 C CNN
F 3 "~" H 8700 5650 50  0001 C CNN
	1    8700 5650
	1    0    0    1   
$EndComp
Wire Wire Line
	8850 5650 8800 5650
Connection ~ 8850 5650
Wire Wire Line
	8850 5650 8850 5700
Wire Wire Line
	8550 5650 8600 5650
Connection ~ 8550 5650
Wire Wire Line
	8550 5650 8550 5700
$Comp
L Analog_ADC:MCP3208 U705
U 1 1 5F4C395E
P 8650 5000
F 0 "U705" H 9250 4600 50  0000 C CNN
F 1 "MCP3208" H 9350 4500 50  0000 C CNN
F 2 "Package_SO:SOIC-16_3.9x9.9mm_P1.27mm" H 8750 5100 50  0001 C CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/21298c.pdf" H 8750 5100 50  0001 C CNN
F 4 "MCP3208-CI/SL-ND" H 8650 5000 50  0001 C CNN "DigiKey"
F 5 "579-MCP3208CISL " H 8650 5000 50  0001 C CNN "Mouser"
	1    8650 5000
	1    0    0    -1  
$EndComp
Wire Notes Line
	6200 3550 6200 6350
Text Label 5850 5350 2    50   ~ 0
5v_ADC_CLK
Text Label 5850 5250 2    50   ~ 0
5v_ADC_Dout
Text Label 5850 5150 2    50   ~ 0
5v_ADC_Din
Text Label 5850 5050 2    50   ~ 0
5v_ADC_CSn
Wire Wire Line
	5200 5350 5850 5350
Wire Wire Line
	5200 5250 5850 5250
Wire Wire Line
	5200 5150 5850 5150
Wire Wire Line
	5200 5050 5850 5050
Text Label 900  7150 0    50   ~ 0
5v_GPIO_5v_3
Text Label 900  7050 0    50   ~ 0
5v_GPIO_5v_2
Text Label 900  6950 0    50   ~ 0
5v_GPIO_5v_1
Text Label 900  6850 0    50   ~ 0
5v_GPIO_5v_0
Wire Wire Line
	900  7150 1500 7150
Wire Wire Line
	900  7050 1500 7050
Wire Wire Line
	900  6950 1500 6950
Wire Wire Line
	900  6850 1500 6850
Wire Notes Line
	2500 3050 2500 7200
Wire Notes Line
	750  3050 750  7200
Text GLabel 1500 6850 2    50   Input ~ 0
5v_GPIO_5v_0
Text GLabel 1500 6950 2    50   Input ~ 0
5v_GPIO_5v_1
Text GLabel 1500 7050 2    50   Input ~ 0
5v_GPIO_5v_2
Text GLabel 1500 7150 2    50   Input ~ 0
5v_GPIO_5v_3
Text Notes 1900 5950 0    50   ~ 0
(VBAT)
Text Notes 1900 6050 0    50   ~ 0
(ESC Current)
Wire Notes Line
	750  3050 2500 3050
Wire Notes Line
	750  7200 2500 7200
$Comp
L power:PWR_FLAG #FLG0109
U 1 1 5FD0D45C
P 8550 5700
F 0 "#FLG0109" H 8550 5775 50  0001 C CNN
F 1 "PWR_FLAG" V 8550 5827 50  0000 L CNN
F 2 "" H 8550 5700 50  0001 C CNN
F 3 "~" H 8550 5700 50  0001 C CNN
	1    8550 5700
	0    -1   -1   0   
$EndComp
Connection ~ 8550 5700
$EndSCHEMATC
