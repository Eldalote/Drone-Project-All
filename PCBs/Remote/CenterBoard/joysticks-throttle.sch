EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 6 6
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
L Eldalote-General:PTA6043 R?
U 1 1 5FB902BA
P 5850 5150
AR Path="/5FB902BA" Ref="R?"  Part="1" 
AR Path="/5FB8F5C2/5FB902BA" Ref="R601"  Part="1" 
F 0 "R601" V 5750 5050 50  0000 R CNN
F 1 "Throttle Potentiometer" V 5650 5550 50  0000 R CNN
F 2 "Eldalote-footprints:PTA6043" H 5850 5150 50  0001 C CNN
F 3 "" H 5850 5150 50  0001 C CNN
F 4 "PTA6043-2015DPB103-ND " H 5850 5150 50  0001 C CNN "DigiKey"
F 5 "652-PTA60432015DPB10 " H 5850 5150 50  0001 C CNN "Mouser"
	1    5850 5150
	0    -1   -1   0   
$EndComp
$Comp
L Eldalote-General:Sparkfun_COM-09032 U?
U 1 1 5FB902C0
P 9400 1950
AR Path="/5FB902C0" Ref="U?"  Part="1" 
AR Path="/5FB8F5C2/5FB902C0" Ref="U601"  Part="1" 
F 0 "U601" H 9730 1946 50  0000 L CNN
F 1 "Joystick Left" H 9730 1855 50  0000 L CNN
F 2 "Eldalote-footprints:Sparkfun_COM-09032" H 9400 1950 50  0001 L BNN
F 3 "" H 9400 1950 50  0001 L BNN
F 4 " 1568-1526-ND " H 9400 1950 50  0001 C CNN "DigiKey"
F 5 " 474-COM-09032 " H 9400 1950 50  0001 C CNN "Mouser"
	1    9400 1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	8800 1450 8900 1450
Wire Wire Line
	8800 1850 8900 1850
Text Label 8800 1450 2    50   ~ 0
JS_left_V
Text Label 8800 1850 2    50   ~ 0
JS_left_H
NoConn ~ 8900 2550
NoConn ~ 8900 4300
$Comp
L power:+3V3 #PWR0116
U 1 1 5FB946E6
P 8900 1950
F 0 "#PWR0116" H 8900 1800 50  0001 C CNN
F 1 "+3V3" V 8915 2078 50  0000 L CNN
F 2 "" H 8900 1950 50  0001 C CNN
F 3 "" H 8900 1950 50  0001 C CNN
	1    8900 1950
	0    -1   -1   0   
$EndComp
$Comp
L power:+3V3 #PWR0117
U 1 1 5FB94D04
P 8900 1550
F 0 "#PWR0117" H 8900 1400 50  0001 C CNN
F 1 "+3V3" V 8915 1678 50  0000 L CNN
F 2 "" H 8900 1550 50  0001 C CNN
F 3 "" H 8900 1550 50  0001 C CNN
	1    8900 1550
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR0118
U 1 1 5FB95B79
P 8900 2050
F 0 "#PWR0118" H 8900 1800 50  0001 C CNN
F 1 "GND" V 8905 1922 50  0000 R CNN
F 2 "" H 8900 2050 50  0001 C CNN
F 3 "" H 8900 2050 50  0001 C CNN
	1    8900 2050
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0119
U 1 1 5FB95D18
P 8900 1650
F 0 "#PWR0119" H 8900 1400 50  0001 C CNN
F 1 "GND" V 8905 1522 50  0000 R CNN
F 2 "" H 8900 1650 50  0001 C CNN
F 3 "" H 8900 1650 50  0001 C CNN
	1    8900 1650
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0120
U 1 1 5FB96AB8
P 8900 2350
F 0 "#PWR0120" H 8900 2100 50  0001 C CNN
F 1 "GND" V 8905 2222 50  0000 R CNN
F 2 "" H 8900 2350 50  0001 C CNN
F 3 "" H 8900 2350 50  0001 C CNN
	1    8900 2350
	0    1    1    0   
$EndComp
$Comp
L Device:R R602
U 1 1 5FB9A4A5
P 8250 2050
F 0 "R602" V 8350 1950 50  0000 L CNN
F 1 "10k" V 8250 1950 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 8180 2050 50  0001 C CNN
F 3 "~" H 8250 2050 50  0001 C CNN
F 4 "C17414" H 8250 2050 50  0001 C CNN "LCSC"
F 5 "311-10.0KCRCT-ND " H 8250 2050 50  0001 C CNN "DigiKey"
F 6 "603-RC0805FR-0710KL " H 8250 2050 50  0001 C CNN "Mouser"
	1    8250 2050
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR0121
U 1 1 5FB9A775
P 8250 1850
F 0 "#PWR0121" H 8250 1700 50  0001 C CNN
F 1 "+3V3" H 8265 2023 50  0000 C CNN
F 2 "" H 8250 1850 50  0001 C CNN
F 3 "" H 8250 1850 50  0001 C CNN
	1    8250 1850
	1    0    0    -1  
$EndComp
Wire Wire Line
	8250 1850 8250 1900
Wire Wire Line
	8250 2250 8250 2200
Wire Wire Line
	8250 2250 8900 2250
Wire Wire Line
	8250 2250 8150 2250
Connection ~ 8250 2250
Text Label 8150 2250 2    50   ~ 0
JS_left_button
Wire Wire Line
	8800 3200 8900 3200
Wire Wire Line
	8800 3600 8900 3600
Text Label 8800 3200 2    50   ~ 0
JS_right_V
Text Label 8800 3600 2    50   ~ 0
JS_right_H
$Comp
L power:+3V3 #PWR0122
U 1 1 5FB9CFE0
P 8900 3700
F 0 "#PWR0122" H 8900 3550 50  0001 C CNN
F 1 "+3V3" V 8915 3828 50  0000 L CNN
F 2 "" H 8900 3700 50  0001 C CNN
F 3 "" H 8900 3700 50  0001 C CNN
	1    8900 3700
	0    -1   -1   0   
$EndComp
$Comp
L power:+3V3 #PWR0123
U 1 1 5FB9CFE6
P 8900 3300
F 0 "#PWR0123" H 8900 3150 50  0001 C CNN
F 1 "+3V3" V 8915 3428 50  0000 L CNN
F 2 "" H 8900 3300 50  0001 C CNN
F 3 "" H 8900 3300 50  0001 C CNN
	1    8900 3300
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR0124
U 1 1 5FB9CFEC
P 8900 3800
F 0 "#PWR0124" H 8900 3550 50  0001 C CNN
F 1 "GND" V 8905 3672 50  0000 R CNN
F 2 "" H 8900 3800 50  0001 C CNN
F 3 "" H 8900 3800 50  0001 C CNN
	1    8900 3800
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0125
U 1 1 5FB9CFF2
P 8900 3400
F 0 "#PWR0125" H 8900 3150 50  0001 C CNN
F 1 "GND" V 8905 3272 50  0000 R CNN
F 2 "" H 8900 3400 50  0001 C CNN
F 3 "" H 8900 3400 50  0001 C CNN
	1    8900 3400
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0126
U 1 1 5FB9CFF8
P 8900 4100
F 0 "#PWR0126" H 8900 3850 50  0001 C CNN
F 1 "GND" V 8905 3972 50  0000 R CNN
F 2 "" H 8900 4100 50  0001 C CNN
F 3 "" H 8900 4100 50  0001 C CNN
	1    8900 4100
	0    1    1    0   
$EndComp
$Comp
L Device:R R603
U 1 1 5FB9D001
P 8250 3800
F 0 "R603" V 8350 3700 50  0000 L CNN
F 1 "10k" V 8250 3700 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 8180 3800 50  0001 C CNN
F 3 "~" H 8250 3800 50  0001 C CNN
F 4 "C17414" H 8250 3800 50  0001 C CNN "LCSC"
F 5 "311-10.0KCRCT-ND " H 8250 3800 50  0001 C CNN "DigiKey"
F 6 "603-RC0805FR-0710KL " H 8250 3800 50  0001 C CNN "Mouser"
	1    8250 3800
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR0127
U 1 1 5FB9D007
P 8250 3600
F 0 "#PWR0127" H 8250 3450 50  0001 C CNN
F 1 "+3V3" H 8265 3773 50  0000 C CNN
F 2 "" H 8250 3600 50  0001 C CNN
F 3 "" H 8250 3600 50  0001 C CNN
	1    8250 3600
	1    0    0    -1  
$EndComp
Wire Wire Line
	8250 3600 8250 3650
Wire Wire Line
	8250 4000 8250 3950
Wire Wire Line
	8250 4000 8900 4000
Wire Wire Line
	8250 4000 8150 4000
Connection ~ 8250 4000
Text Label 8150 4000 2    50   ~ 0
JS_right_button
$Comp
L Eldalote-General:Sparkfun_COM-09032 U?
U 1 1 5FB9D199
P 9400 3700
AR Path="/5FB9D199" Ref="U?"  Part="1" 
AR Path="/5FB8F5C2/5FB9D199" Ref="U602"  Part="1" 
F 0 "U602" H 9730 3696 50  0000 L CNN
F 1 "Joystick Right" H 9730 3605 50  0000 L CNN
F 2 "Eldalote-footprints:Sparkfun_COM-09032" H 9400 3700 50  0001 L BNN
F 3 "" H 9400 3700 50  0001 L BNN
F 4 " 1568-1526-ND " H 9400 3700 50  0001 C CNN "DigiKey"
F 5 " 474-COM-09032 " H 9400 3700 50  0001 C CNN "Mouser"
	1    9400 3700
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR0128
U 1 1 5FB9DFEF
P 5750 5100
F 0 "#PWR0128" H 5750 4950 50  0001 C CNN
F 1 "+3V3" H 5765 5273 50  0000 C CNN
F 2 "" H 5750 5100 50  0001 C CNN
F 3 "" H 5750 5100 50  0001 C CNN
	1    5750 5100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0129
U 1 1 5FB9E77D
P 6450 5200
F 0 "#PWR0129" H 6450 4950 50  0001 C CNN
F 1 "GND" H 6455 5027 50  0000 C CNN
F 2 "" H 6450 5200 50  0001 C CNN
F 3 "" H 6450 5200 50  0001 C CNN
	1    6450 5200
	1    0    0    -1  
$EndComp
Wire Wire Line
	6350 5150 6450 5150
Wire Wire Line
	6450 5150 6450 5200
Wire Wire Line
	5850 5150 5750 5150
Wire Wire Line
	5750 5150 5750 5100
Wire Wire Line
	6100 4950 6100 4800
Wire Wire Line
	6100 4800 6000 4800
Text Label 6000 4800 2    50   ~ 0
Throttle
Wire Wire Line
	1500 1000 1600 1000
Text Label 1600 1000 0    50   ~ 0
JS_left_button
Wire Wire Line
	1600 1100 1500 1100
Text Label 1600 1100 0    50   ~ 0
JS_left_V
Wire Wire Line
	1600 1200 1500 1200
Text Label 1600 1200 0    50   ~ 0
JS_left_H
Wire Wire Line
	1600 1500 1500 1500
Text Label 1600 1500 0    50   ~ 0
JS_right_V
Wire Wire Line
	1600 1600 1500 1600
Text Label 1600 1600 0    50   ~ 0
JS_right_H
Wire Wire Line
	1500 1400 1600 1400
Text Label 1600 1400 0    50   ~ 0
JS_right_button
Wire Wire Line
	1500 1800 1600 1800
Text Label 1600 1800 0    50   ~ 0
Throttle
Text GLabel 1500 1000 0    50   Input ~ 0
JS_left_button
Text GLabel 1500 1100 0    50   Input ~ 0
JS_left_V
Text GLabel 1500 1200 0    50   Input ~ 0
JS_left_H
Text GLabel 1500 1400 0    50   Input ~ 0
JS_right_button
Text GLabel 1500 1500 0    50   Input ~ 0
JS_right_V
Text GLabel 1500 1600 0    50   Input ~ 0
JS_right_H
Text GLabel 1500 1800 0    50   Input ~ 0
Throttle
$EndSCHEMATC