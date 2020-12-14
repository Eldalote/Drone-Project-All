EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 9 15
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Sheet
S 750  750  1750 1300
U 5F5C1DDB
F0 "GPIOs" 50
F1 "GPIO.sch" 50
$EndSheet
$Comp
L Eldalote-General:Amphenol-1mm-10-header J901
U 1 1 601D85B5
P 9850 1050
F 0 "J901" H 10228 501 50  0000 L CNN
F 1 "Amphenol-1mm-10-header" H 9900 -100 50  0000 L CNN
F 2 "Eldalote-footprints:Amphenol-10-1mm" H 9850 1050 50  0001 C CNN
F 3 "" H 9850 1050 50  0001 C CNN
F 4 " 609-6308-1-ND " H 9850 1050 50  0001 C CNN "DigiKey"
F 5 "649-10147606-00010LF" H 9850 1050 50  0001 C CNN "Mouser"
	1    9850 1050
	1    0    0    -1  
$EndComp
Wire Wire Line
	9750 1200 9650 1200
Wire Wire Line
	9650 1200 9650 1050
Wire Wire Line
	9650 950  9300 950 
Wire Wire Line
	9300 950  9300 1000
Wire Wire Line
	9750 1300 9650 1300
Wire Wire Line
	9650 1300 9650 1200
Connection ~ 9650 1200
$Comp
L power:GND #PWR0901
U 1 1 601DBF04
P 9300 1000
F 0 "#PWR0901" H 9300 750 50  0001 C CNN
F 1 "GND" H 9305 827 50  0000 C CNN
F 2 "" H 9300 1000 50  0001 C CNN
F 3 "" H 9300 1000 50  0001 C CNN
	1    9300 1000
	1    0    0    -1  
$EndComp
Wire Wire Line
	9750 1400 9600 1400
Text Label 9600 1400 2    50   ~ 0
VBAT
$Comp
L power:+10V #PWR0129
U 1 1 601DC472
P 9300 1450
F 0 "#PWR0129" H 9300 1300 50  0001 C CNN
F 1 "+10V" H 9315 1623 50  0000 C CNN
F 2 "" H 9300 1450 50  0001 C CNN
F 3 "" H 9300 1450 50  0001 C CNN
	1    9300 1450
	1    0    0    -1  
$EndComp
Wire Wire Line
	9750 1500 9300 1500
Wire Wire Line
	9300 1500 9300 1450
Wire Wire Line
	9750 1600 9550 1600
Wire Wire Line
	9750 1700 9550 1700
Wire Wire Line
	9750 1800 9550 1800
Wire Wire Line
	9750 1900 9550 1900
Wire Wire Line
	9750 2000 9650 2000
Wire Wire Line
	9750 2100 9650 2100
Text Label 9550 1600 2    50   ~ 0
ESC4
Text Label 9550 1700 2    50   ~ 0
ESC3
Text Label 9550 1800 2    50   ~ 0
ESC2
Text Label 9550 1900 2    50   ~ 0
ESC1
Text Label 9250 2000 2    50   ~ 0
ESC-CRT
Text Label 9250 2100 2    50   ~ 0
ESC-TX
Wire Notes Line
	11050 850  11050 2300
Wire Notes Line
	8800 2300 8800 850 
Text Notes 9450 850  0    50   ~ 0
ESC Connection header (bottom)
Wire Wire Line
	9100 2850 9300 2850
Text Label 9100 2850 2    50   ~ 0
VBAT
Text GLabel 10450 2750 1    50   Input ~ 0
ADC_CH0
$Comp
L Device:R R902
U 1 1 5FAD2626
P 9500 2100
F 0 "R902" V 9550 2250 50  0000 C CNN
F 1 "OPT" V 9500 2100 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 9430 2100 50  0001 C CNN
F 3 "~" H 9500 2100 50  0001 C CNN
	1    9500 2100
	0    1    1    0   
$EndComp
$Comp
L Device:R R901
U 1 1 5FAD3C20
P 9500 2000
F 0 "R901" V 9450 2150 50  0000 C CNN
F 1 "OPT" V 9500 2000 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 9430 2000 50  0001 C CNN
F 3 "~" H 9500 2000 50  0001 C CNN
	1    9500 2000
	0    1    1    0   
$EndComp
Wire Wire Line
	9350 2000 9250 2000
Wire Wire Line
	9350 2100 9250 2100
Wire Notes Line
	8800 2300 11050 2300
Wire Notes Line
	8800 850  11050 850 
$Comp
L Device:LED D901
U 1 1 5FB27ADC
P 1850 3250
F 0 "D901" H 1843 2995 50  0000 C CNN
F 1 "POWERGOOD" H 1843 3086 50  0000 C CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 1850 3250 50  0001 C CNN
F 3 "~" H 1850 3250 50  0001 C CNN
F 4 "C72041" H 1850 3250 50  0001 C CNN "LCSC"
	1    1850 3250
	-1   0    0    1   
$EndComp
$Comp
L Device:R R903
U 1 1 5FB2923E
P 1450 3250
F 0 "R903" V 1350 3200 50  0000 C CNN
F 1 "390R" V 1450 3250 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 1380 3250 50  0001 C CNN
F 3 "~" H 1450 3250 50  0001 C CNN
F 4 "C23151" V 1450 3250 50  0001 C CNN "LCSC"
	1    1450 3250
	0    1    1    0   
$EndComp
Wire Wire Line
	1600 3250 1700 3250
$Comp
L Device:LED D902
U 1 1 5FB2F0A7
P 1850 3900
F 0 "D902" H 1843 3645 50  0000 C CNN
F 1 "USERLED0" H 1843 3736 50  0000 C CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 1850 3900 50  0001 C CNN
F 3 "~" H 1850 3900 50  0001 C CNN
F 4 "C72041" H 1850 3900 50  0001 C CNN "LCSC"
	1    1850 3900
	-1   0    0    1   
$EndComp
$Comp
L Device:R R904
U 1 1 5FB2F0AE
P 1450 3900
F 0 "R904" V 1350 3850 50  0000 C CNN
F 1 "390R" V 1450 3900 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 1380 3900 50  0001 C CNN
F 3 "~" H 1450 3900 50  0001 C CNN
F 4 "C23151" V 1450 3900 50  0001 C CNN "LCSC"
	1    1450 3900
	0    1    1    0   
$EndComp
Wire Wire Line
	1600 3900 1700 3900
$Comp
L Device:LED D903
U 1 1 5FB2F975
P 1850 4250
F 0 "D903" H 1843 3995 50  0000 C CNN
F 1 "USERLED1" H 1843 4086 50  0000 C CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 1850 4250 50  0001 C CNN
F 3 "~" H 1850 4250 50  0001 C CNN
F 4 "C72041" H 1850 4250 50  0001 C CNN "LCSC"
	1    1850 4250
	-1   0    0    1   
$EndComp
$Comp
L Device:R R905
U 1 1 5FB2F97C
P 1450 4250
F 0 "R905" V 1350 4200 50  0000 C CNN
F 1 "390R" V 1450 4250 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 1380 4250 50  0001 C CNN
F 3 "~" H 1450 4250 50  0001 C CNN
F 4 "C23151" V 1450 4250 50  0001 C CNN "LCSC"
	1    1450 4250
	0    1    1    0   
$EndComp
Wire Wire Line
	1600 4250 1700 4250
$Comp
L Device:LED D904
U 1 1 5FB30302
P 1850 4600
F 0 "D904" H 1843 4345 50  0000 C CNN
F 1 "USERLED2" H 1843 4436 50  0000 C CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 1850 4600 50  0001 C CNN
F 3 "~" H 1850 4600 50  0001 C CNN
F 4 "C72041" H 1850 4600 50  0001 C CNN "LCSC"
	1    1850 4600
	-1   0    0    1   
$EndComp
$Comp
L Device:R R906
U 1 1 5FB30309
P 1450 4600
F 0 "R906" V 1350 4550 50  0000 C CNN
F 1 "390R" V 1450 4600 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 1380 4600 50  0001 C CNN
F 3 "~" H 1450 4600 50  0001 C CNN
F 4 "C23151" V 1450 4600 50  0001 C CNN "LCSC"
	1    1450 4600
	0    1    1    0   
$EndComp
Wire Wire Line
	1600 4600 1700 4600
$Comp
L Device:LED D905
U 1 1 5FB30C6C
P 1850 4950
F 0 "D905" H 1843 4695 50  0000 C CNN
F 1 "USERLED3" H 1843 4786 50  0000 C CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 1850 4950 50  0001 C CNN
F 3 "~" H 1850 4950 50  0001 C CNN
F 4 "C72041" H 1850 4950 50  0001 C CNN "LCSC"
	1    1850 4950
	-1   0    0    1   
$EndComp
$Comp
L Device:R R907
U 1 1 5FB30C73
P 1450 4950
F 0 "R907" V 1350 4900 50  0000 C CNN
F 1 "390R" V 1450 4950 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 1380 4950 50  0001 C CNN
F 3 "~" H 1450 4950 50  0001 C CNN
F 4 "C23151" V 1450 4950 50  0001 C CNN "LCSC"
	1    1450 4950
	0    1    1    0   
$EndComp
Wire Wire Line
	1600 4950 1700 4950
$Comp
L Device:LED D906
U 1 1 5FB314D1
P 1850 5300
F 0 "D906" H 1843 5045 50  0000 C CNN
F 1 "USERLED4" H 1843 5136 50  0000 C CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 1850 5300 50  0001 C CNN
F 3 "~" H 1850 5300 50  0001 C CNN
F 4 "C72041" H 1850 5300 50  0001 C CNN "LCSC"
	1    1850 5300
	-1   0    0    1   
$EndComp
$Comp
L Device:R R908
U 1 1 5FB314D8
P 1450 5300
F 0 "R908" V 1350 5250 50  0000 C CNN
F 1 "390R" V 1450 5300 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 1380 5300 50  0001 C CNN
F 3 "~" H 1450 5300 50  0001 C CNN
F 4 "C23151" V 1450 5300 50  0001 C CNN "LCSC"
	1    1450 5300
	0    1    1    0   
$EndComp
Wire Wire Line
	1600 5300 1700 5300
$Comp
L Device:LED D907
U 1 1 5FB31DC0
P 1850 5700
F 0 "D907" H 1843 5445 50  0000 C CNN
F 1 "USERLED5" H 1843 5536 50  0000 C CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 1850 5700 50  0001 C CNN
F 3 "~" H 1850 5700 50  0001 C CNN
F 4 "C72041" H 1850 5700 50  0001 C CNN "LCSC"
	1    1850 5700
	-1   0    0    1   
$EndComp
$Comp
L Device:R R909
U 1 1 5FB31DC7
P 1450 5700
F 0 "R909" V 1350 5650 50  0000 C CNN
F 1 "390R" V 1450 5700 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 1380 5700 50  0001 C CNN
F 3 "~" H 1450 5700 50  0001 C CNN
F 4 "C23151" V 1450 5700 50  0001 C CNN "LCSC"
	1    1450 5700
	0    1    1    0   
$EndComp
Wire Wire Line
	1600 5700 1700 5700
$Comp
L Device:LED D908
U 1 1 5FB327F9
P 1850 6050
F 0 "D908" H 1843 5795 50  0000 C CNN
F 1 "USERLED6" H 1843 5886 50  0000 C CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 1850 6050 50  0001 C CNN
F 3 "~" H 1850 6050 50  0001 C CNN
F 4 "C72041" H 1850 6050 50  0001 C CNN "LCSC"
	1    1850 6050
	-1   0    0    1   
$EndComp
$Comp
L Device:R R910
U 1 1 5FB32800
P 1450 6050
F 0 "R910" V 1350 6000 50  0000 C CNN
F 1 "390R" V 1450 6050 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 1380 6050 50  0001 C CNN
F 3 "~" H 1450 6050 50  0001 C CNN
F 4 "C23151" V 1450 6050 50  0001 C CNN "LCSC"
	1    1450 6050
	0    1    1    0   
$EndComp
Wire Wire Line
	1600 6050 1700 6050
$Comp
L Device:LED D909
U 1 1 5FB33150
P 1850 6400
F 0 "D909" H 1843 6145 50  0000 C CNN
F 1 "USERLED7" H 1843 6236 50  0000 C CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 1850 6400 50  0001 C CNN
F 3 "~" H 1850 6400 50  0001 C CNN
F 4 "C72041" H 1850 6400 50  0001 C CNN "LCSC"
	1    1850 6400
	-1   0    0    1   
$EndComp
$Comp
L Device:R R911
U 1 1 5FB33157
P 1450 6400
F 0 "R911" V 1350 6350 50  0000 C CNN
F 1 "390R" V 1450 6400 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 1380 6400 50  0001 C CNN
F 3 "~" H 1450 6400 50  0001 C CNN
F 4 "C23151" V 1450 6400 50  0001 C CNN "LCSC"
	1    1450 6400
	0    1    1    0   
$EndComp
Wire Wire Line
	1600 6400 1700 6400
$Comp
L power:+3.3V #PWR0902
U 1 1 5FB38A0E
P 1000 3050
F 0 "#PWR0902" H 1000 2900 50  0001 C CNN
F 1 "+3.3V" H 1015 3223 50  0000 C CNN
F 2 "" H 1000 3050 50  0001 C CNN
F 3 "" H 1000 3050 50  0001 C CNN
	1    1000 3050
	1    0    0    -1  
$EndComp
Wire Wire Line
	1000 6400 1300 6400
Wire Wire Line
	1300 6050 1000 6050
Connection ~ 1000 6050
Wire Wire Line
	1000 6050 1000 6400
Wire Wire Line
	1300 5700 1000 5700
Connection ~ 1000 5700
Wire Wire Line
	1000 5700 1000 6050
Wire Wire Line
	1300 5300 1000 5300
Connection ~ 1000 5300
Wire Wire Line
	1000 5300 1000 5700
Wire Wire Line
	1300 4950 1000 4950
Connection ~ 1000 4950
Wire Wire Line
	1000 4950 1000 5300
Wire Wire Line
	1300 4600 1000 4600
Connection ~ 1000 4600
Wire Wire Line
	1000 4600 1000 4950
Wire Wire Line
	1300 4250 1000 4250
Wire Wire Line
	1000 3050 1000 3250
Connection ~ 1000 4250
Wire Wire Line
	1000 4250 1000 4600
Wire Wire Line
	1300 3900 1000 3900
Connection ~ 1000 3900
Wire Wire Line
	1000 3900 1000 4250
Wire Wire Line
	1300 3250 1000 3250
Connection ~ 1000 3250
Wire Wire Line
	1000 3250 1000 3900
$Comp
L power:GND #PWR0903
U 1 1 5FB3F3B1
P 2350 3400
F 0 "#PWR0903" H 2350 3150 50  0001 C CNN
F 1 "GND" H 2355 3227 50  0000 C CNN
F 2 "" H 2350 3400 50  0001 C CNN
F 3 "" H 2350 3400 50  0001 C CNN
	1    2350 3400
	1    0    0    -1  
$EndComp
Wire Wire Line
	2350 3400 2350 3250
Wire Wire Line
	2350 3250 2000 3250
Wire Wire Line
	2000 3900 2400 3900
Wire Wire Line
	2000 4250 2400 4250
Wire Wire Line
	2000 4600 2400 4600
Wire Wire Line
	2000 4950 2400 4950
Wire Wire Line
	2000 5300 2400 5300
Wire Wire Line
	2000 5700 2400 5700
Wire Wire Line
	2000 6050 2400 6050
Wire Wire Line
	2000 6400 2400 6400
Text Label 2400 3900 0    50   ~ 0
USERLED0
Text Label 2400 4250 0    50   ~ 0
USERLED1
Text Label 2400 4600 0    50   ~ 0
USERLED2
Text Label 2400 4950 0    50   ~ 0
USERLED3
Text Label 2400 5300 0    50   ~ 0
USERLED4
Text Label 2400 5700 0    50   ~ 0
USERLED5
Text Label 2400 6050 0    50   ~ 0
USERLED6
Text Label 2400 6400 0    50   ~ 0
USERLED7
Wire Wire Line
	10350 3500 10150 3500
Wire Wire Line
	10350 3600 10150 3600
Wire Wire Line
	10350 3700 10150 3700
Wire Wire Line
	10350 3800 10150 3800
Text Label 10150 3500 2    50   ~ 0
ESC4
Text Label 10150 3600 2    50   ~ 0
ESC3
Text Label 10150 3700 2    50   ~ 0
ESC2
Text Label 10150 3800 2    50   ~ 0
ESC1
Text Label 9850 3100 2    50   ~ 0
ESC-CRT
Text Label 10150 3900 2    50   ~ 0
ESC-TX
Wire Wire Line
	10050 3100 9850 3100
Wire Wire Line
	10350 3900 10150 3900
Wire Wire Line
	10150 4100 10350 4100
Wire Wire Line
	10150 4200 10350 4200
Wire Wire Line
	10150 4300 10350 4300
Wire Wire Line
	10150 4400 10350 4400
Wire Wire Line
	10150 4500 10350 4500
Wire Wire Line
	10150 4600 10350 4600
Wire Wire Line
	10150 4700 10350 4700
Wire Wire Line
	10150 4800 10350 4800
Text Label 10150 4100 2    50   ~ 0
USERLED0
Text Label 10150 4200 2    50   ~ 0
USERLED1
Text Label 10150 4300 2    50   ~ 0
USERLED2
Text Label 10150 4400 2    50   ~ 0
USERLED3
Text Label 10150 4500 2    50   ~ 0
USERLED4
Text Label 10150 4600 2    50   ~ 0
USERLED5
Text Label 10150 4700 2    50   ~ 0
USERLED6
Text Label 10150 4800 2    50   ~ 0
USERLED7
Text GLabel 10350 3500 2    50   Input ~ 0
ESC4
Text GLabel 10350 3600 2    50   Input ~ 0
ESC3
Text GLabel 10350 3700 2    50   Input ~ 0
ESC2
Text GLabel 10350 3800 2    50   Input ~ 0
ESC1
Text GLabel 10350 3900 2    50   Input ~ 0
ESC-TX
$Comp
L Device:R R915
U 1 1 5FB9201C
P 10650 2850
F 0 "R915" V 10550 2850 50  0000 C CNN
F 1 "10K" V 10650 2850 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 10580 2850 50  0001 C CNN
F 3 "~" H 10650 2850 50  0001 C CNN
F 4 "C17414" V 10650 2850 50  0001 C CNN "LCSC"
	1    10650 2850
	0    1    1    0   
$EndComp
$Comp
L Device:R R914
U 1 1 5FB9299F
P 10250 2850
F 0 "R914" V 10150 2850 50  0000 C CNN
F 1 "10K" V 10250 2850 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 10180 2850 50  0001 C CNN
F 3 "~" H 10250 2850 50  0001 C CNN
F 4 "C17414" V 10250 2850 50  0001 C CNN "LCSC"
	1    10250 2850
	0    1    1    0   
$EndComp
$Comp
L Device:R R913
U 1 1 5FB92BDE
P 9850 2850
F 0 "R913" V 9750 2850 50  0000 C CNN
F 1 "10K" V 9850 2850 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 9780 2850 50  0001 C CNN
F 3 "~" H 9850 2850 50  0001 C CNN
F 4 "C17414" V 9850 2850 50  0001 C CNN "LCSC"
	1    9850 2850
	0    1    1    0   
$EndComp
$Comp
L Device:R R912
U 1 1 5FB948E4
P 9450 2850
F 0 "R912" V 9350 2850 50  0000 C CNN
F 1 "10K" V 9450 2850 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 9380 2850 50  0001 C CNN
F 3 "~" H 9450 2850 50  0001 C CNN
F 4 "C17414" V 9450 2850 50  0001 C CNN "LCSC"
	1    9450 2850
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0904
U 1 1 5FB966BD
P 10900 2900
F 0 "#PWR0904" H 10900 2650 50  0001 C CNN
F 1 "GND" H 10905 2727 50  0000 C CNN
F 2 "" H 10900 2900 50  0001 C CNN
F 3 "" H 10900 2900 50  0001 C CNN
	1    10900 2900
	1    0    0    -1  
$EndComp
Wire Wire Line
	10900 2900 10900 2850
Wire Wire Line
	10900 2850 10800 2850
Wire Wire Line
	10500 2850 10450 2850
Wire Wire Line
	10100 2850 10000 2850
Wire Wire Line
	9600 2850 9700 2850
Wire Wire Line
	10450 2750 10450 2850
Connection ~ 10450 2850
Wire Wire Line
	10450 2850 10400 2850
Text GLabel 10350 4100 2    50   Input ~ 0
USERLED0
Text GLabel 10350 4200 2    50   Input ~ 0
USERLED1
Text GLabel 10350 4300 2    50   Input ~ 0
USERLED2
Text GLabel 10350 4400 2    50   Input ~ 0
USERLED3
Text GLabel 10350 4500 2    50   Input ~ 0
USERLED4
Text GLabel 10350 4600 2    50   Input ~ 0
USERLED5
Text GLabel 10350 4700 2    50   Input ~ 0
USERLED6
Text GLabel 10350 4800 2    50   Input ~ 0
USERLED7
Text GLabel 10050 3100 2    50   Input ~ 0
ADC_CH1
$Comp
L power:PWR_FLAG #FLG0103
U 1 1 5FC9FEBD
P 9650 1050
F 0 "#FLG0103" H 9650 1125 50  0001 C CNN
F 1 "PWR_FLAG" V 9650 1178 50  0000 L CNN
F 2 "" H 9650 1050 50  0001 C CNN
F 3 "~" H 9650 1050 50  0001 C CNN
	1    9650 1050
	0    1    1    0   
$EndComp
Connection ~ 9650 1050
Wire Wire Line
	9650 1050 9650 950 
$Comp
L power:PWR_FLAG #FLG0104
U 1 1 5FCA0A7E
P 9300 1500
F 0 "#FLG0104" H 9300 1575 50  0001 C CNN
F 1 "PWR_FLAG" V 9300 1627 50  0000 L CNN
F 2 "" H 9300 1500 50  0001 C CNN
F 3 "~" H 9300 1500 50  0001 C CNN
	1    9300 1500
	0    -1   -1   0   
$EndComp
Connection ~ 9300 1500
$EndSCHEMATC
