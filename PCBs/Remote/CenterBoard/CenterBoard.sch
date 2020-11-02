EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 4
Title ""
Date ""
Rev ""
Comp "Eldalote.Electronics"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Graphic:Logo_Open_Hardware_Small LOGO1
U 1 1 5F436516
P 4050 7550
F 0 "LOGO1" H 4050 7825 50  0001 C CNN
F 1 "Logo_Open_Hardware_Small" H 4050 7325 50  0001 C CNN
F 2 "Symbol:OSHW-Logo_5.7x6mm_SilkScreen" H 4050 7550 50  0001 C CNN
F 3 "~" H 4050 7550 50  0001 C CNN
	1    4050 7550
	1    0    0    -1  
$EndComp
$Sheet
S 12000 500  500  500 
U 5F9FCA6C
F0 "LPC51" 50
F1 "LPC51.sch" 50
$EndSheet
$Sheet
S 12000 1500 500  500 
U 5F9FD0C9
F0 "Power" 50
F1 "Power.sch" 50
$EndSheet
$Sheet
S 12000 2500 500  500 
U 5F9FD417
F0 "Radio" 50
F1 "Radio.sch" 50
$EndSheet
$Comp
L Eldalote-General:PTA6043 R101
U 1 1 5FA79FE9
P 10100 5650
F 0 "R101" H 9907 5446 50  0000 R CNN
F 1 "PTA6043" H 9907 5355 50  0000 R CNN
F 2 "Eldalote-footprints:PTA6043" H 10100 5650 50  0001 C CNN
F 3 "" H 10100 5650 50  0001 C CNN
	1    10100 5650
	1    0    0    -1  
$EndComp
$Comp
L Eldalote-General:Sparkfun_COM-09032 U101
U 1 1 5FA7B340
P 8500 5250
F 0 "U101" H 8830 5246 50  0000 L CNN
F 1 "Sparkfun_COM-09032" H 8830 5155 50  0000 L CNN
F 2 "Eldalote-footprints:Sparkfun_COM-09032" H 8500 5250 50  0001 L BNN
F 3 "" H 8500 5250 50  0001 L BNN
	1    8500 5250
	1    0    0    -1  
$EndComp
$Comp
L Eldalote-General:Sparkfun_COM-09032 U102
U 1 1 5FA7B424
P 10100 4450
F 0 "U102" H 10430 4446 50  0000 L CNN
F 1 "Sparkfun_COM-09032" H 10430 4355 50  0000 L CNN
F 2 "Eldalote-footprints:Sparkfun_COM-09032" H 10100 4450 50  0001 L BNN
F 3 "" H 10100 4450 50  0001 L BNN
	1    10100 4450
	1    0    0    -1  
$EndComp
$EndSCHEMATC
