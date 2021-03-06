EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 10 15
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
L Connector_Generic:Conn_02x10_Odd_Even J?
U 1 1 5F5C3855
P 1650 1500
AR Path="/5F439C11/5F5C3855" Ref="J?"  Part="1" 
AR Path="/5F439C11/5F5C1DDB/5F5C3855" Ref="J1001"  Part="1" 
F 0 "J1001" H 1700 2117 50  0000 C CNN
F 1 "Conn_02x10" H 1700 2050 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_2x10_P2.54mm_Vertical" H 1650 1500 50  0001 C CNN
F 3 "~" H 1650 1500 50  0001 C CNN
	1    1650 1500
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_02x10_Odd_Even J?
U 1 1 5F5C385B
P 5450 1500
AR Path="/5F439C11/5F5C385B" Ref="J?"  Part="1" 
AR Path="/5F439C11/5F5C1DDB/5F5C385B" Ref="J1003"  Part="1" 
F 0 "J1003" H 5500 2117 50  0000 C CNN
F 1 "Conn_02x10" H 5500 2026 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_2x10_P2.54mm_Vertical" H 5450 1500 50  0001 C CNN
F 3 "~" H 5450 1500 50  0001 C CNN
	1    5450 1500
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_02x07_Odd_Even J1002
U 1 1 5F5C7DF5
P 1950 5900
F 0 "J1002" H 2000 6417 50  0000 C CNN
F 1 "Conn_02x07" H 2000 6326 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_2x07_P2.54mm_Vertical" H 1950 5900 50  0001 C CNN
F 3 "~" H 1950 5900 50  0001 C CNN
	1    1950 5900
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_02x05_Odd_Even J1004
U 1 1 5F5CA1BC
P 9400 1200
F 0 "J1004" H 9450 1617 50  0000 C CNN
F 1 "Conn_02x05" H 9450 1526 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_2x05_P2.54mm_Vertical" H 9400 1200 50  0001 C CNN
F 3 "~" H 9400 1200 50  0001 C CNN
	1    9400 1200
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR01001
U 1 1 5F5D0685
P 1350 1100
F 0 "#PWR01001" H 1350 950 50  0001 C CNN
F 1 "+3.3V" H 1365 1273 50  0000 C CNN
F 2 "" H 1350 1100 50  0001 C CNN
F 3 "" H 1350 1100 50  0001 C CNN
	1    1350 1100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR01002
U 1 1 5F5D1394
P 1350 2000
F 0 "#PWR01002" H 1350 1750 50  0001 C CNN
F 1 "GND" H 1355 1827 50  0000 C CNN
F 2 "" H 1350 2000 50  0001 C CNN
F 3 "" H 1350 2000 50  0001 C CNN
	1    1350 2000
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR01006
U 1 1 5F5D1A60
P 2050 2000
F 0 "#PWR01006" H 2050 1750 50  0001 C CNN
F 1 "GND" H 2055 1827 50  0000 C CNN
F 2 "" H 2050 2000 50  0001 C CNN
F 3 "" H 2050 2000 50  0001 C CNN
	1    2050 2000
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR01005
U 1 1 5F5D2E37
P 2050 1100
F 0 "#PWR01005" H 2050 950 50  0001 C CNN
F 1 "+3.3V" H 2065 1273 50  0000 C CNN
F 2 "" H 2050 1100 50  0001 C CNN
F 3 "" H 2050 1100 50  0001 C CNN
	1    2050 1100
	1    0    0    -1  
$EndComp
Wire Wire Line
	1350 2000 1450 2000
Wire Wire Line
	2050 2000 1950 2000
Wire Wire Line
	2050 1100 1950 1100
Wire Wire Line
	1350 1100 1450 1100
$Comp
L power:+3.3V #PWR01009
U 1 1 5F5D4E37
P 5150 1100
F 0 "#PWR01009" H 5150 950 50  0001 C CNN
F 1 "+3.3V" H 5165 1273 50  0000 C CNN
F 2 "" H 5150 1100 50  0001 C CNN
F 3 "" H 5150 1100 50  0001 C CNN
	1    5150 1100
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR01011
U 1 1 5F5D53FF
P 5850 1100
F 0 "#PWR01011" H 5850 950 50  0001 C CNN
F 1 "+3.3V" H 5865 1273 50  0000 C CNN
F 2 "" H 5850 1100 50  0001 C CNN
F 3 "" H 5850 1100 50  0001 C CNN
	1    5850 1100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR01010
U 1 1 5F5D55FF
P 5150 2000
F 0 "#PWR01010" H 5150 1750 50  0001 C CNN
F 1 "GND" H 5155 1827 50  0000 C CNN
F 2 "" H 5150 2000 50  0001 C CNN
F 3 "" H 5150 2000 50  0001 C CNN
	1    5150 2000
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR01012
U 1 1 5F5D58BC
P 5850 2000
F 0 "#PWR01012" H 5850 1750 50  0001 C CNN
F 1 "GND" H 5855 1827 50  0000 C CNN
F 2 "" H 5850 2000 50  0001 C CNN
F 3 "" H 5850 2000 50  0001 C CNN
	1    5850 2000
	1    0    0    -1  
$EndComp
Wire Wire Line
	5850 1100 5750 1100
Wire Wire Line
	5150 2000 5250 2000
Wire Wire Line
	5850 2000 5750 2000
$Comp
L power:GND #PWR01008
U 1 1 5F5D6E3D
P 2350 6200
F 0 "#PWR01008" H 2350 5950 50  0001 C CNN
F 1 "GND" H 2355 6027 50  0000 C CNN
F 2 "" H 2350 6200 50  0001 C CNN
F 3 "" H 2350 6200 50  0001 C CNN
	1    2350 6200
	1    0    0    -1  
$EndComp
$Comp
L power:GNDA #PWR01004
U 1 1 5F5D7044
P 1650 6200
F 0 "#PWR01004" H 1650 5950 50  0001 C CNN
F 1 "GNDA" H 1655 6027 50  0000 C CNN
F 2 "" H 1650 6200 50  0001 C CNN
F 3 "" H 1650 6200 50  0001 C CNN
	1    1650 6200
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR01007
U 1 1 5F5D7F99
P 2350 5600
F 0 "#PWR01007" H 2350 5450 50  0001 C CNN
F 1 "+5V" H 2365 5773 50  0000 C CNN
F 2 "" H 2350 5600 50  0001 C CNN
F 3 "" H 2350 5600 50  0001 C CNN
	1    2350 5600
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR01003
U 1 1 5F5D85DF
P 1650 5600
F 0 "#PWR01003" H 1650 5450 50  0001 C CNN
F 1 "+5V" H 1665 5773 50  0000 C CNN
F 2 "" H 1650 5600 50  0001 C CNN
F 3 "" H 1650 5600 50  0001 C CNN
	1    1650 5600
	1    0    0    -1  
$EndComp
Wire Wire Line
	1650 5600 1750 5600
Wire Wire Line
	2350 5600 2250 5600
Wire Wire Line
	2350 6200 2250 6200
Wire Wire Line
	1650 6200 1750 6200
Wire Wire Line
	5150 1100 5250 1100
Wire Wire Line
	9200 1000 9100 1000
Wire Wire Line
	9200 1100 9100 1100
Wire Wire Line
	9200 1200 9100 1200
Wire Wire Line
	9200 1400 9100 1400
Wire Wire Line
	9700 1000 9850 1000
Wire Wire Line
	9700 1100 10100 1100
Wire Wire Line
	9700 1400 9850 1400
NoConn ~ 9700 1200
NoConn ~ 9700 1300
NoConn ~ 9200 1300
$Comp
L Eldalote-Power:VCCA #PWR01017
U 1 1 5F737A8B
P 10100 1000
F 0 "#PWR01017" H 10100 850 50  0001 C CNN
F 1 "VCCA" H 10115 1173 50  0000 C CNN
F 2 "" H 10100 1000 50  0001 C CNN
F 3 "" H 10100 1000 50  0001 C CNN
	1    10100 1000
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR01016
U 1 1 5F73804D
P 9850 1400
F 0 "#PWR01016" H 9850 1150 50  0001 C CNN
F 1 "GND" H 9855 1227 50  0000 C CNN
F 2 "" H 9850 1400 50  0001 C CNN
F 3 "" H 9850 1400 50  0001 C CNN
	1    9850 1400
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR01015
U 1 1 5F7385E0
P 9850 1000
F 0 "#PWR01015" H 9850 750 50  0001 C CNN
F 1 "GND" H 10000 950 50  0000 C CNN
F 2 "" H 9850 1000 50  0001 C CNN
F 3 "" H 9850 1000 50  0001 C CNN
	1    9850 1000
	1    0    0    -1  
$EndComp
Wire Wire Line
	10100 1100 10100 1000
Text Label 9100 1100 2    50   ~ 0
JTAG_TDO
Text Label 9100 1000 2    50   ~ 0
JTAG_TCK
Text Label 9100 1200 2    50   ~ 0
JTAG_TMS
Text Label 9100 1400 2    50   ~ 0
JTAG_TDI
$Comp
L Eldalote-Power:VCCA #PWR01013
U 1 1 5F73A8C6
P 9200 1700
F 0 "#PWR01013" H 9200 1550 50  0001 C CNN
F 1 "VCCA" H 9215 1873 50  0000 C CNN
F 2 "" H 9200 1700 50  0001 C CNN
F 3 "" H 9200 1700 50  0001 C CNN
	1    9200 1700
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR01014
U 1 1 5F73AE9B
P 9750 2150
F 0 "#PWR01014" H 9750 1900 50  0001 C CNN
F 1 "GND" H 9755 1977 50  0000 C CNN
F 2 "" H 9750 2150 50  0001 C CNN
F 3 "" H 9750 2150 50  0001 C CNN
	1    9750 2150
	1    0    0    -1  
$EndComp
$Comp
L Device:R R1001
U 1 1 5F73B16D
P 9100 1950
F 0 "R1001" V 9200 1850 50  0000 L CNN
F 1 "10k" V 9100 1850 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 9030 1950 50  0001 C CNN
F 3 "~" H 9100 1950 50  0001 C CNN
F 4 "C25744" H 9100 1950 50  0001 C CNN "LCSC"
	1    9100 1950
	1    0    0    -1  
$EndComp
$Comp
L Device:R R1003
U 1 1 5F73B658
P 9750 1950
F 0 "R1003" V 9850 1850 50  0000 L CNN
F 1 "1k" V 9750 1900 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 9680 1950 50  0001 C CNN
F 3 "~" H 9750 1950 50  0001 C CNN
F 4 "C11702" H 9750 1950 50  0001 C CNN "LCSC"
	1    9750 1950
	1    0    0    -1  
$EndComp
$Comp
L Device:R R1002
U 1 1 5F73DA4E
P 9300 1950
F 0 "R1002" V 9400 1850 50  0000 L CNN
F 1 "10k" V 9300 1850 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 9230 1950 50  0001 C CNN
F 3 "~" H 9300 1950 50  0001 C CNN
F 4 "C25744" H 9300 1950 50  0001 C CNN "LCSC"
	1    9300 1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	9200 1700 9100 1700
Wire Wire Line
	9100 1700 9100 1800
Wire Wire Line
	9200 1700 9300 1700
Wire Wire Line
	9300 1700 9300 1800
Connection ~ 9200 1700
Wire Wire Line
	9750 2100 9750 2150
Wire Wire Line
	9750 1800 9750 1750
Wire Wire Line
	9100 2100 9100 2150
Wire Wire Line
	9300 2100 9300 2150
Text Label 9100 2150 3    50   ~ 0
JTAG_TDI
Text Label 9300 2150 3    50   ~ 0
JTAG_TMS
Text Label 9750 1750 0    50   ~ 0
JTAG_TCK
Wire Notes Line
	10400 700  10400 2600
Wire Notes Line
	10400 2600 8700 2600
Wire Notes Line
	8700 2600 8700 700 
Wire Notes Line
	8700 700  10400 700 
Text Notes 9350 700  0    50   ~ 0
JTAG (top)
Wire Wire Line
	10000 3100 10100 3100
Wire Wire Line
	10000 3200 10100 3200
Wire Wire Line
	10000 3300 10100 3300
Wire Wire Line
	10000 3400 10100 3400
Text GLabel 10100 3100 2    50   Input ~ 0
JTAG_TCK
Text GLabel 10100 3200 2    50   Input ~ 0
JTAG_TDO
Text GLabel 10100 3300 2    50   Input ~ 0
JTAG_TMS
Text GLabel 10100 3400 2    50   Input ~ 0
JTAG_TDI
Text Label 10000 3100 2    50   ~ 0
JTAG_TCK
Text Label 10000 3200 2    50   ~ 0
JTAG_TDO
Text Label 10000 3300 2    50   ~ 0
JTAG_TMS
Text Label 10000 3400 2    50   ~ 0
JTAG_TDI
Text Label 10000 3900 2    50   ~ 0
5v_GPIO_5v_3
Text Label 10000 3800 2    50   ~ 0
5v_GPIO_5v_2
Text Label 10000 3700 2    50   ~ 0
5v_GPIO_5v_1
Text Label 10000 3600 2    50   ~ 0
5v_GPIO_5v_0
Wire Wire Line
	10000 3900 10100 3900
Wire Wire Line
	10000 3800 10100 3800
Wire Wire Line
	10000 3700 10100 3700
Wire Wire Line
	10000 3600 10100 3600
Text GLabel 10100 3600 2    50   Input ~ 0
5v_GPIO_5v_0
Text GLabel 10100 3700 2    50   Input ~ 0
5v_GPIO_5v_1
Text GLabel 10100 3800 2    50   Input ~ 0
5v_GPIO_5v_2
Text GLabel 10100 3900 2    50   Input ~ 0
5v_GPIO_5v_3
Wire Wire Line
	9500 4100 10100 4100
Wire Wire Line
	9500 4200 10100 4200
Wire Wire Line
	9500 4300 10100 4300
Wire Wire Line
	9500 4400 10100 4400
Wire Wire Line
	9500 4500 10100 4500
Wire Wire Line
	9500 4600 10100 4600
Text Label 9500 4100 0    50   ~ 0
ADC_CH2
Text Label 9500 4200 0    50   ~ 0
ADC_CH3
Text Label 9500 4300 0    50   ~ 0
ADC_CH4
Text Label 9500 4400 0    50   ~ 0
ADC_CH5
Text Label 9500 4500 0    50   ~ 0
ADC_CH6
Text Label 9500 4600 0    50   ~ 0
ADC_CH7
Text GLabel 10100 4100 2    50   Input ~ 0
ADC_CH2
Text GLabel 10100 4200 2    50   Input ~ 0
ADC_CH3
Text GLabel 10100 4300 2    50   Input ~ 0
ADC_CH4
Text GLabel 10100 4400 2    50   Input ~ 0
ADC_CH5
Text GLabel 10100 4500 2    50   Input ~ 0
ADC_CH6
Text GLabel 10100 4600 2    50   Input ~ 0
ADC_CH7
Text Label 2350 5800 0    50   ~ 0
5v_GPIO_5v_3
Text Label 1650 5800 2    50   ~ 0
5v_GPIO_5v_2
Text Label 2350 5700 0    50   ~ 0
5v_GPIO_5v_1
Text Label 1650 5700 2    50   ~ 0
5v_GPIO_5v_0
Wire Wire Line
	2350 5800 2250 5800
Wire Wire Line
	1650 5800 1750 5800
Wire Wire Line
	2350 5700 2250 5700
Wire Wire Line
	1650 5700 1750 5700
Wire Wire Line
	2850 6100 2250 6100
Wire Wire Line
	1150 6100 1750 6100
Wire Wire Line
	2850 6000 2250 6000
Wire Wire Line
	1150 6000 1750 6000
Wire Wire Line
	2850 5900 2250 5900
Wire Wire Line
	1150 5900 1750 5900
Text Label 2850 6100 2    50   ~ 0
ADC_CH2
Text Label 1150 6100 0    50   ~ 0
ADC_CH3
Text Label 2850 6000 2    50   ~ 0
ADC_CH4
Text Label 1150 6000 0    50   ~ 0
ADC_CH5
Text Label 2850 5900 2    50   ~ 0
ADC_CH6
Text Label 1150 5900 0    50   ~ 0
ADC_CH7
Wire Wire Line
	1450 1200 1350 1200
Wire Wire Line
	1450 1300 1350 1300
Wire Wire Line
	1450 1400 1350 1400
Wire Wire Line
	1450 1500 1350 1500
Wire Wire Line
	1450 1600 1350 1600
Wire Wire Line
	1450 1700 1350 1700
Wire Wire Line
	1450 1800 1350 1800
Wire Wire Line
	1450 1900 1350 1900
Wire Wire Line
	1950 1200 2050 1200
Wire Wire Line
	1950 1300 2050 1300
Wire Wire Line
	1950 1400 2050 1400
Wire Wire Line
	1950 1500 2050 1500
Wire Wire Line
	1950 1600 2050 1600
Wire Wire Line
	1950 1700 2050 1700
Wire Wire Line
	1950 1800 2050 1800
Wire Wire Line
	1950 1900 2050 1900
Text Label 1350 1200 2    50   ~ 0
GPIO1-0
Text Label 1350 1300 2    50   ~ 0
GPIO1-2
Text Label 1350 1400 2    50   ~ 0
GPIO1-4
Text Label 1350 1500 2    50   ~ 0
GPIO1-6
Text Label 1350 1600 2    50   ~ 0
GPIO1-8
Text Label 1350 1700 2    50   ~ 0
GPIO1-10
Text Label 1350 1800 2    50   ~ 0
GPIO1-12
Text Label 1350 1900 2    50   ~ 0
GPIO1-14
Text Label 2050 1200 0    50   ~ 0
GPIO1-1
Text Label 2050 1300 0    50   ~ 0
GPIO1-3
Text Label 2050 1400 0    50   ~ 0
GPIO1-5
Text Label 2050 1500 0    50   ~ 0
GPIO1-7
Text Label 2050 1600 0    50   ~ 0
GPIO1-9
Text Label 2050 1700 0    50   ~ 0
GPIO1-11
Text Label 2050 1800 0    50   ~ 0
GPIO1-13
Text Label 2050 1900 0    50   ~ 0
GPIO1-15
Wire Wire Line
	10100 4800 10000 4800
Wire Wire Line
	10100 5000 10000 5000
Wire Wire Line
	10100 5200 10000 5200
Wire Wire Line
	10100 5400 10000 5400
Wire Wire Line
	10100 5600 10000 5600
Wire Wire Line
	10100 5800 10000 5800
Wire Wire Line
	10100 6000 10000 6000
Wire Wire Line
	10100 6200 10000 6200
Text Label 10000 4800 2    50   ~ 0
GPIO1-0
Text Label 10000 5000 2    50   ~ 0
GPIO1-2
Text Label 10000 5200 2    50   ~ 0
GPIO1-4
Text Label 10000 5400 2    50   ~ 0
GPIO1-6
Text Label 10000 5600 2    50   ~ 0
GPIO1-8
Text Label 10000 5800 2    50   ~ 0
GPIO1-10
Text Label 10000 6000 2    50   ~ 0
GPIO1-12
Text Label 10000 6200 2    50   ~ 0
GPIO1-14
Wire Wire Line
	10100 4900 10000 4900
Wire Wire Line
	10100 5100 10000 5100
Wire Wire Line
	10100 5300 10000 5300
Wire Wire Line
	10100 5500 10000 5500
Wire Wire Line
	10100 5700 10000 5700
Wire Wire Line
	10100 5900 10000 5900
Wire Wire Line
	10100 6100 10000 6100
Wire Wire Line
	10100 6300 10000 6300
Text Label 10000 4900 2    50   ~ 0
GPIO1-1
Text Label 10000 5100 2    50   ~ 0
GPIO1-3
Text Label 10000 5300 2    50   ~ 0
GPIO1-5
Text Label 10000 5500 2    50   ~ 0
GPIO1-7
Text Label 10000 5700 2    50   ~ 0
GPIO1-9
Text Label 10000 5900 2    50   ~ 0
GPIO1-11
Text Label 10000 6100 2    50   ~ 0
GPIO1-13
Text Label 10000 6300 2    50   ~ 0
GPIO1-15
Text GLabel 10100 4800 2    50   Input ~ 0
GPIO1-0
Text GLabel 10100 4900 2    50   Input ~ 0
GPIO1-1
Text GLabel 10100 5000 2    50   Input ~ 0
GPIO1-2
Text GLabel 10100 5100 2    50   Input ~ 0
GPIO1-3
Text GLabel 10100 5200 2    50   Input ~ 0
GPIO1-4
Text GLabel 10100 5300 2    50   Input ~ 0
GPIO1-5
Text GLabel 10100 5400 2    50   Input ~ 0
GPIO1-6
Text GLabel 10100 5500 2    50   Input ~ 0
GPIO1-7
Text GLabel 10100 5600 2    50   Input ~ 0
GPIO1-8
Text GLabel 10100 5700 2    50   Input ~ 0
GPIO1-9
Text GLabel 10100 5800 2    50   Input ~ 0
GPIO1-10
Text GLabel 10100 5900 2    50   Input ~ 0
GPIO1-11
Text GLabel 10100 6000 2    50   Input ~ 0
GPIO1-12
Text GLabel 10100 6100 2    50   Input ~ 0
GPIO1-13
Text GLabel 10100 6200 2    50   Input ~ 0
GPIO1-14
Text GLabel 10100 6300 2    50   Input ~ 0
GPIO1-15
Wire Wire Line
	5250 1200 5150 1200
Wire Wire Line
	5250 1300 5150 1300
Wire Wire Line
	5250 1400 5150 1400
Wire Wire Line
	5250 1500 5150 1500
Wire Wire Line
	5250 1600 5150 1600
Wire Wire Line
	5250 1700 5150 1700
Wire Wire Line
	5250 1800 5150 1800
Wire Wire Line
	5250 1900 5150 1900
Text Label 5150 1200 2    50   ~ 0
GPIO2-0
Text Label 5150 1300 2    50   ~ 0
GPIO2-2
Text Label 5150 1400 2    50   ~ 0
GPIO2-4
Text Label 5150 1500 2    50   ~ 0
GPIO2-6
Text Label 5150 1600 2    50   ~ 0
GPIO2-8
Text Label 5150 1700 2    50   ~ 0
GPIO2-10
Text Label 5150 1800 2    50   ~ 0
GPIO2-12
Text Label 5150 1900 2    50   ~ 0
GPIO2-14
Wire Wire Line
	5750 1200 5850 1200
Wire Wire Line
	5750 1300 5850 1300
Wire Wire Line
	5750 1400 5850 1400
Wire Wire Line
	5750 1500 5850 1500
Wire Wire Line
	5750 1600 5850 1600
Wire Wire Line
	5750 1700 5850 1700
Wire Wire Line
	5750 1800 5850 1800
Wire Wire Line
	5750 1900 5850 1900
Text Label 5850 1200 0    50   ~ 0
GPIO2-1
Text Label 5850 1300 0    50   ~ 0
GPIO2-3
Text Label 5850 1400 0    50   ~ 0
GPIO2-5
Text Label 5850 1500 0    50   ~ 0
GPIO2-7
Text Label 5850 1600 0    50   ~ 0
GPIO2-9
Text Label 5850 1700 0    50   ~ 0
GPIO2-11
Text Label 5850 1800 0    50   ~ 0
GPIO2-13
Text Label 5850 1900 0    50   ~ 0
GPIO2-15
Wire Wire Line
	9000 4800 8900 4800
Wire Wire Line
	8900 4900 9000 4900
Wire Wire Line
	8900 5000 9000 5000
Wire Wire Line
	8900 5100 9000 5100
Wire Wire Line
	8900 5200 9000 5200
Wire Wire Line
	8900 5300 9000 5300
Wire Wire Line
	8900 5400 9000 5400
Wire Wire Line
	8900 5500 9000 5500
Wire Wire Line
	8900 5600 9000 5600
Wire Wire Line
	8900 5700 9000 5700
Wire Wire Line
	8900 5800 9000 5800
Wire Wire Line
	8900 5900 9000 5900
Wire Wire Line
	8900 6000 9000 6000
Wire Wire Line
	8900 6100 9000 6100
Wire Wire Line
	8900 6200 9000 6200
Wire Wire Line
	8900 6300 9000 6300
Text Label 8900 4800 2    50   ~ 0
GPIO2-0
Text Label 8900 4900 2    50   ~ 0
GPIO2-1
Text Label 8900 5000 2    50   ~ 0
GPIO2-2
Text Label 8900 5100 2    50   ~ 0
GPIO2-3
Text Label 8900 5200 2    50   ~ 0
GPIO2-4
Text Label 8900 5300 2    50   ~ 0
GPIO2-5
Text Label 8900 5400 2    50   ~ 0
GPIO2-6
Text Label 8900 5500 2    50   ~ 0
GPIO2-7
Text Label 8900 5600 2    50   ~ 0
GPIO2-8
Text Label 8900 5700 2    50   ~ 0
GPIO2-9
Text Label 8900 5800 2    50   ~ 0
GPIO2-10
Text Label 8900 5900 2    50   ~ 0
GPIO2-11
Text Label 8900 6000 2    50   ~ 0
GPIO2-12
Text Label 8900 6100 2    50   ~ 0
GPIO2-13
Text Label 8900 6200 2    50   ~ 0
GPIO2-14
Text Label 8900 6300 2    50   ~ 0
GPIO2-15
Text GLabel 9000 4800 2    50   Input ~ 0
GPIO2-0
Text GLabel 9000 4900 2    50   Input ~ 0
GPIO2-1
Text GLabel 9000 5000 2    50   Input ~ 0
GPIO2-2
Text GLabel 9000 5100 2    50   Input ~ 0
GPIO2-3
Text GLabel 9000 5200 2    50   Input ~ 0
GPIO2-4
Text GLabel 9000 5300 2    50   Input ~ 0
GPIO2-5
Text GLabel 9000 5400 2    50   Input ~ 0
GPIO2-6
Text GLabel 9000 5500 2    50   Input ~ 0
GPIO2-7
Text GLabel 9000 5600 2    50   Input ~ 0
GPIO2-8
Text GLabel 9000 5700 2    50   Input ~ 0
GPIO2-9
Text GLabel 9000 5800 2    50   Input ~ 0
GPIO2-10
Text GLabel 9000 5900 2    50   Input ~ 0
GPIO2-11
Text GLabel 9000 6000 2    50   Input ~ 0
GPIO2-12
Text GLabel 9000 6100 2    50   Input ~ 0
GPIO2-13
Text GLabel 9000 6200 2    50   Input ~ 0
GPIO2-14
Text GLabel 9000 6300 2    50   Input ~ 0
GPIO2-15
Wire Notes Line
	8400 2750 10750 2750
Wire Notes Line
	10750 2750 10750 6400
Wire Notes Line
	10750 6400 8400 6400
Wire Notes Line
	8400 6400 8400 2750
Text Notes 9450 2850 0    50   ~ 0
Sheet IO
$EndSCHEMATC
