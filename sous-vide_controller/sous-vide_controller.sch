EESchema Schematic File Version 4
LIBS:neighbor-template-cache
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "Sous-vide_controller"
Date "2018-11-08"
Rev "1"
Comp "Great Scott Gadgets"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L gsg-symbols:ADM1602K LCD1
U 1 1 5BE49062
P 5500 8200
F 0 "LCD1" H 4478 10178 50  0000 L CNN
F 1 "ADM1602K" H 4478 10087 50  0000 L CNN
F 2 "" H 2850 10800 50  0001 C CNN
F 3 "https://www.sparkfun.com/datasheets/LCD/ADM1602K-NSW-FBS-3.3v.pdf" H 2850 10800 50  0001 C CNN
F 4 "Sparkfun" H 5500 8200 50  0001 C CNN "Manufacturer"
F 5 "ADM1602K" H 5500 8200 50  0001 C CNN "Part Number"
F 6 "LCD Module" H 5500 8200 50  0001 C CNN "Description"
	1    5500 8200
	1    0    0    -1  
$EndComp
Text Label 9600 1700 0    40   ~ 0
P2_8
$Comp
L sous-vide_controller-rescue:CONN_02X20- J1
U 1 1 5BE51465
P 10050 2050
F 0 "J1" H 10050 3100 50  0000 C CNN
F 1 "NEIGHBOR2" V 10050 2050 50  0000 C CNN
F 2 "gsg-modules:HEADER-2x20" H 10050 1100 60  0001 C CNN
F 3 "" H 10050 1100 60  0000 C CNN
F 4 "Samtec" H 10050 2050 60  0001 C CNN "Manufacturer"
F 5 "SSQ-120-23-G-D" H 10050 2050 60  0001 C CNN "Part Number"
F 6 "CONN RCPT .100\" 40POS DUAL-ROW STACKING GOLD" H 10050 2050 60  0001 C CNN "Description"
F 7 "Alternate: https://www.adafruit.com/products/2223" H 10050 2050 60  0001 C CNN "Note"
	1    10050 2050
	1    0    0    -1  
$EndComp
$Comp
L sous-vide_controller-rescue:GND- #PWR09
U 1 1 5BE5146C
P 9600 1100
F 0 "#PWR09" H 9600 850 50  0001 C CNN
F 1 "GND" H 9600 950 50  0000 C CNN
F 2 "" H 9600 1100 60  0000 C CNN
F 3 "" H 9600 1100 60  0000 C CNN
	1    9600 1100
	0    1    1    0   
$EndComp
$Comp
L sous-vide_controller-rescue:GND- #PWR010
U 1 1 5BE51472
P 9600 3450
F 0 "#PWR010" H 9600 3200 50  0001 C CNN
F 1 "GND" H 9600 3300 50  0000 C CNN
F 2 "" H 9600 3450 60  0000 C CNN
F 3 "" H 9600 3450 60  0000 C CNN
	1    9600 3450
	0    1    1    0   
$EndComp
$Comp
L sous-vide_controller-rescue:VCC- #PWR011
U 1 1 5BE51478
P 10500 3450
F 0 "#PWR011" H 10500 3300 50  0001 C CNN
F 1 "VCC" H 10500 3600 50  0000 C CNN
F 2 "" H 10500 3450 60  0000 C CNN
F 3 "" H 10500 3450 60  0000 C CNN
	1    10500 3450
	0    1    1    0   
$EndComp
Text Label 10500 1100 2    40   ~ 0
VBUS
$Comp
L sous-vide_controller-rescue:CONN_02X20- J2
U 1 1 5BE51483
P 10050 4400
F 0 "J2" H 10050 5450 50  0000 C CNN
F 1 "NEIGHBOR1" V 10050 4400 50  0000 C CNN
F 2 "gsg-modules:HEADER-2x20" H 10050 3450 60  0001 C CNN
F 3 "" H 10050 3450 60  0000 C CNN
F 4 "Samtec" H 10050 4400 60  0001 C CNN "Manufacturer"
F 5 "SSQ-120-23-G-D" H 10050 4400 60  0001 C CNN "Part Number"
F 6 "CONN RCPT .100\" 40POS DUAL-ROW STACKING GOLD" H 10050 4400 60  0001 C CNN "Description"
F 7 "Alternate: https://www.adafruit.com/products/2223" H 10050 4400 60  0001 C CNN "Note"
	1    10050 4400
	1    0    0    -1  
$EndComp
Text Label 10500 3550 2    40   ~ 0
P0_0
Text Label 9600 3550 0    40   ~ 0
P4_9
Text Label 10500 3650 2    40   ~ 0
P0_1
Text Label 9600 3650 0    40   ~ 0
P4_10
Text Label 10500 3750 2    40   ~ 0
P5_0
Text Label 9600 3750 0    40   ~ 0
P1_0
Text Label 9600 3850 0    40   ~ 0
P5_1
Text Label 10500 3850 2    40   ~ 0
P1_1
Text Label 10500 3950 2    40   ~ 0
P1_2
Text Label 10500 5350 2    40   ~ 0
P1_3
Text Label 10500 4050 2    40   ~ 0
P5_2
Text Label 9600 5350 0    40   ~ 0
P1_4
Text Label 9600 4050 0    40   ~ 0
P1_5
Text Label 10500 4150 2    40   ~ 0
P1_6
Text Label 9600 4150 0    40   ~ 0
P1_7
Text Label 10500 4250 2    40   ~ 0
P1_8
Text Label 9600 4250 0    40   ~ 0
P1_9
Text Label 10500 4350 2    40   ~ 0
P1_10
Text Label 9600 4350 0    40   ~ 0
P5_3
Text Label 10500 4450 2    40   ~ 0
P1_11
Text Label 9600 4450 0    40   ~ 0
P1_12
Text Label 10500 4550 2    40   ~ 0
P5_4
Text Label 9600 4550 0    40   ~ 0
P5_5
Text Label 10500 4650 2    40   ~ 0
P1_13
Text Label 9600 4650 0    40   ~ 0
P1_14
Text Label 10500 4750 2    40   ~ 0
P1_15
Text Label 9600 4750 0    40   ~ 0
P5_6
Text Label 10500 4850 2    40   ~ 0
P1_16
Text Label 9600 4850 0    40   ~ 0
P5_7
Text Label 10500 4950 2    40   ~ 0
P1_17
Text Label 9600 4950 0    40   ~ 0
P1_18
Text Label 10500 5250 2    40   ~ 0
P1_19
Text Label 9600 5050 0    40   ~ 0
P9_5
Text Label 9600 5250 0    40   ~ 0
P1_20
Text Label 10500 5050 2    40   ~ 0
P9_6
Text Label 9600 3950 0    40   ~ 0
CLK0
Text Label 10500 5150 2    40   ~ 0
P6_0
Text Label 9600 5150 0    40   ~ 0
P2_0
Text Notes 10550 5350 0    40   ~ 0
MISO
Text Notes 9550 5350 2    40   ~ 0
MOSI
Text Notes 10550 5250 0    40   ~ 0
SCK
Text Notes 9550 5250 2    40   ~ 0
SSEL
Text Label 10600 3000 2    40   ~ 0
I2C0_SCL
Text Label 9500 3000 0    40   ~ 0
I2C0_SDA
Text Label 10500 2800 2    40   ~ 0
P6_3
Text Label 9600 2800 0    40   ~ 0
P2_1
Text Label 10500 2700 2    40   ~ 0
P6_6
Text Label 9600 2700 0    40   ~ 0
P2_2
Text Label 9600 2600 0    40   ~ 0
P6_7
Text Label 9600 2500 0    40   ~ 0
P6_8
Text Label 10500 2000 2    40   ~ 0
P2_3
Text Label 9600 2000 0    40   ~ 0
P2_4
Text Label 10500 1900 2    40   ~ 0
P2_5
Text Label 9600 1800 0    40   ~ 0
P2_6
Text Label 10500 1600 2    40   ~ 0
CLK2
Text Label 9600 2400 0    40   ~ 0
P7_0
Text Label 10500 2300 2    40   ~ 0
P3_0
Text Label 9600 2300 0    40   ~ 0
P7_1
Text Label 10500 2200 2    40   ~ 0
P3_1
Text Label 9600 2200 0    40   ~ 0
P7_2
Text Label 10500 2100 2    40   ~ 0
P3_2
Text Label 10500 2600 2    40   ~ 0
P3_3
Text Label 10500 2400 2    40   ~ 0
P3_4
Text Label 9600 2100 0    40   ~ 0
PF_4
Text Label 9600 2900 0    40   ~ 0
P3_5
Text Label 10500 2900 2    40   ~ 0
P3_6
Text Label 10500 2500 2    40   ~ 0
P3_7
Text Label 10500 1800 2    40   ~ 0
P7_7
Text Label 10500 1200 2    40   ~ 0
P4_0
Text Label 9550 1300 0    40   ~ 0
ADC0_0
Text Label 9600 1500 0    40   ~ 0
P4_3
Text Label 10500 1400 2    40   ~ 0
P4_2
Text Label 9600 1400 0    40   ~ 0
P4_4
Text Label 10500 1300 2    40   ~ 0
P4_5
Text Label 10500 1500 2    40   ~ 0
P4_6
Text Label 9600 1600 0    40   ~ 0
P4_7
Text Label 9600 1200 0    40   ~ 0
P4_8
Text Label 9500 1900 0    40   ~ 0
WAKEUP0
Text Label 10500 1700 2    40   ~ 0
P2_7
Text Notes 10650 1700 2    40   ~ 0
ISP
Text Notes 9450 1700 0    40   ~ 0
DFU
Text Notes 10550 3850 0    40   ~ 0
BOOT
Text Notes 10700 3950 2    40   ~ 0
BOOT
Wire Wire Line
	9600 3450 9800 3450
Wire Wire Line
	10300 3450 10500 3450
Wire Wire Line
	10500 3550 10300 3550
Wire Wire Line
	9600 3550 9800 3550
Wire Wire Line
	9600 1100 9800 1100
Wire Wire Line
	9600 3650 9800 3650
Wire Wire Line
	9600 3750 9800 3750
Wire Wire Line
	9600 3850 9800 3850
Wire Wire Line
	9600 3950 9800 3950
Wire Wire Line
	9600 4050 9800 4050
Wire Wire Line
	9600 4150 9800 4150
Wire Wire Line
	9600 4250 9800 4250
Wire Wire Line
	9600 4350 9800 4350
Wire Wire Line
	9600 4450 9800 4450
Wire Wire Line
	9600 4550 9800 4550
Wire Wire Line
	9600 4650 9800 4650
Wire Wire Line
	9600 4750 9800 4750
Wire Wire Line
	9600 4850 9800 4850
Wire Wire Line
	9600 4950 9800 4950
Wire Wire Line
	9600 5050 9800 5050
Wire Wire Line
	9600 5150 9800 5150
Wire Wire Line
	10500 5150 10300 5150
Wire Wire Line
	10300 5050 10500 5050
Wire Wire Line
	10500 4950 10300 4950
Wire Wire Line
	10300 4850 10500 4850
Wire Wire Line
	10500 4750 10300 4750
Wire Wire Line
	10300 4650 10500 4650
Wire Wire Line
	10500 4550 10300 4550
Wire Wire Line
	10300 4450 10500 4450
Wire Wire Line
	10500 4350 10300 4350
Wire Wire Line
	10300 4250 10500 4250
Wire Wire Line
	10500 4150 10300 4150
Wire Wire Line
	10300 4050 10500 4050
Wire Wire Line
	10500 3950 10300 3950
Wire Wire Line
	10300 3850 10500 3850
Wire Wire Line
	10500 3750 10300 3750
Wire Wire Line
	10300 3650 10500 3650
Wire Wire Line
	9600 5250 9800 5250
Wire Wire Line
	9800 5350 9600 5350
Wire Wire Line
	10300 5350 10500 5350
Wire Wire Line
	10500 5250 10300 5250
Wire Wire Line
	9600 2900 9800 2900
Wire Wire Line
	10300 2900 10500 2900
Wire Wire Line
	10500 2800 10300 2800
Wire Wire Line
	9800 2800 9600 2800
Wire Wire Line
	9600 2700 9800 2700
Wire Wire Line
	10500 2700 10300 2700
Wire Wire Line
	10500 2600 10300 2600
Wire Wire Line
	10500 2500 10300 2500
Wire Wire Line
	9800 2600 9600 2600
Wire Wire Line
	9600 2500 9800 2500
Wire Wire Line
	9800 2400 9600 2400
Wire Wire Line
	10500 2300 10300 2300
Wire Wire Line
	10600 3000 10300 3000
Wire Wire Line
	9800 3000 9500 3000
Wire Wire Line
	10500 2400 10300 2400
Wire Wire Line
	9600 2300 9800 2300
Wire Wire Line
	9600 2200 9800 2200
Wire Wire Line
	10500 2200 10300 2200
Wire Wire Line
	10500 2100 10300 2100
Wire Wire Line
	9600 2100 9800 2100
Wire Wire Line
	10500 2000 10300 2000
Wire Wire Line
	9800 2000 9600 2000
Wire Wire Line
	10500 1900 10300 1900
Wire Wire Line
	9800 1900 9500 1900
Wire Wire Line
	9600 1800 9800 1800
Wire Wire Line
	10500 1800 10300 1800
Wire Wire Line
	10500 1700 10300 1700
Wire Wire Line
	9600 1700 9800 1700
Wire Wire Line
	10500 1600 10300 1600
Wire Wire Line
	9600 1600 9800 1600
Wire Wire Line
	10500 1500 10300 1500
Wire Wire Line
	9600 1500 9800 1500
Wire Wire Line
	10500 1400 10300 1400
Wire Wire Line
	9800 1400 9600 1400
Wire Wire Line
	9550 1300 9800 1300
Wire Wire Line
	10500 1300 10300 1300
Wire Wire Line
	9600 1200 9800 1200
Wire Wire Line
	10300 1200 10500 1200
Text Label 1850 5400 1    50   ~ 0
P1_5
$Comp
L power:VCC #PWR05
U 1 1 5BE60CC3
P 2950 5400
F 0 "#PWR05" H 2950 5250 50  0001 C CNN
F 1 "VCC" H 2967 5573 50  0000 C CNN
F 2 "" H 2950 5400 50  0001 C CNN
F 3 "" H 2950 5400 50  0001 C CNN
	1    2950 5400
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR06
U 1 1 5BE60CF8
P 3050 5400
F 0 "#PWR06" H 3050 5150 50  0001 C CNN
F 1 "GND" V 3055 5272 50  0000 R CNN
F 2 "" H 3050 5400 50  0001 C CNN
F 3 "" H 3050 5400 50  0001 C CNN
	1    3050 5400
	0    -1   -1   0   
$EndComp
Text Label 1950 5250 1    50   ~ 0
P5_2
Wire Wire Line
	1950 5250 1950 5400
Wire Wire Line
	1550 5400 1550 5250
Wire Wire Line
	2150 5400 2150 5250
Wire Wire Line
	2350 5400 2350 5250
Wire Wire Line
	2550 5400 2550 5250
Wire Wire Line
	2750 5400 2750 5250
Text Label 2050 5400 1    50   ~ 0
P1_7
Text Label 2150 5250 1    50   ~ 0
P1_6
Text Label 2250 5400 1    50   ~ 0
P1_9
Text Label 2350 5250 1    50   ~ 0
P1_8
Text Label 2450 5400 1    50   ~ 0
P5_3
Text Label 2550 5250 1    50   ~ 0
P1_10
Text Label 2650 5400 1    50   ~ 0
P1_12
Text Label 2750 5250 1    50   ~ 0
P1_11
Text Label 2850 5400 1    50   ~ 0
P5_5
$Comp
L power:GND #PWR01
U 1 1 5BE881CC
P 1550 5250
F 0 "#PWR01" H 1550 5000 50  0001 C CNN
F 1 "GND" V 1555 5122 50  0000 R CNN
F 2 "" H 1550 5250 50  0001 C CNN
F 3 "" H 1550 5250 50  0001 C CNN
	1    1550 5250
	0    1    1    0   
$EndComp
$Comp
L power:VCC #PWR02
U 1 1 5BE8C245
P 1650 5400
F 0 "#PWR02" H 1650 5250 50  0001 C CNN
F 1 "VCC" H 1667 5573 50  0000 C CNN
F 2 "" H 1650 5400 50  0001 C CNN
F 3 "" H 1650 5400 50  0001 C CNN
	1    1650 5400
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR03
U 1 1 5BE8C27A
P 1750 5150
F 0 "#PWR03" H 1750 4900 50  0001 C CNN
F 1 "GND" H 1755 4977 50  0000 C CNN
F 2 "" H 1750 5150 50  0001 C CNN
F 3 "" H 1750 5150 50  0001 C CNN
	1    1750 5150
	-1   0    0    1   
$EndComp
Wire Wire Line
	1750 5400 1750 5150
$Comp
L Sensor_Temperature:DS18B20 U3
U 1 1 5BE9875D
P 6150 1850
F 0 "U3" H 5920 1896 50  0000 R CNN
F 1 "DS18B20" H 5920 1805 50  0000 R CNN
F 2 "Package_TO_SOT_THT:TO-92_Inline" H 5150 1600 50  0001 C CNN
F 3 "http://datasheets.maximintegrated.com/en/ds/DS18B20.pdf" H 6000 2100 50  0001 C CNN
	1    6150 1850
	1    0    0    -1  
$EndComp
Text Label 6800 1850 0    50   ~ 0
P3_1
$Comp
L power:GND #PWR08
U 1 1 5BE9883D
P 6150 2150
F 0 "#PWR08" H 6150 1900 50  0001 C CNN
F 1 "GND" H 6155 1977 50  0000 C CNN
F 2 "" H 6150 2150 50  0001 C CNN
F 3 "" H 6150 2150 50  0001 C CNN
	1    6150 2150
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR07
U 1 1 5BE98875
P 6150 1450
F 0 "#PWR07" H 6150 1300 50  0001 C CNN
F 1 "VCC" H 6167 1623 50  0000 C CNN
F 2 "" H 6150 1450 50  0001 C CNN
F 3 "" H 6150 1450 50  0001 C CNN
	1    6150 1450
	1    0    0    -1  
$EndComp
$Comp
L gsg-symbols:IoT_Relay U1
U 1 1 5BEA0BD7
P 1400 1600
F 0 "U1" H 1678 1565 50  0000 L CNN
F 1 "IoT_Relay" H 1678 1474 50  0000 L CNN
F 2 "" H 1400 1600 50  0001 C CNN
F 3 "" H 1400 1600 50  0001 C CNN
	1    1400 1600
	1    0    0    -1  
$EndComp
$Comp
L gsg-symbols:IoT_Relay U2
U 1 1 5BEA0C66
P 2900 1600
F 0 "U2" H 3178 1565 50  0000 L CNN
F 1 "IoT_Relay" H 3178 1474 50  0000 L CNN
F 2 "" H 2900 1600 50  0001 C CNN
F 3 "" H 2900 1600 50  0001 C CNN
	1    2900 1600
	1    0    0    -1  
$EndComp
Wire Wire Line
	1550 1900 1550 2150
Wire Wire Line
	3050 2150 3050 1900
Wire Wire Line
	2700 1900 2700 2000
Wire Wire Line
	1200 2000 1200 1900
Wire Wire Line
	1550 2150 2500 2150
Connection ~ 2500 2150
Wire Wire Line
	2500 2150 3050 2150
Wire Wire Line
	2500 2150 2500 2350
Wire Wire Line
	1200 2000 1800 2000
Wire Wire Line
	1800 2000 1800 2350
Connection ~ 1800 2000
Wire Wire Line
	1800 2000 2700 2000
$Comp
L power:GND #PWR04
U 1 1 5BEB0CEF
P 2500 2350
F 0 "#PWR04" H 2500 2100 50  0001 C CNN
F 1 "GND" H 2505 2177 50  0000 C CNN
F 2 "" H 2500 2350 50  0001 C CNN
F 3 "" H 2500 2350 50  0001 C CNN
	1    2500 2350
	1    0    0    -1  
$EndComp
Text Label 1800 2350 3    50   ~ 0
P4_2
Wire Wire Line
	6450 1850 6600 1850
Wire Wire Line
	6600 1500 6600 1850
Connection ~ 6600 1850
Wire Wire Line
	6600 1850 6800 1850
Wire Wire Line
	6150 1450 6150 1500
$Comp
L Device:R R1
U 1 1 5BEE3DBC
P 6350 1500
F 0 "R1" V 6143 1500 50  0000 C CNN
F 1 "4.7k" V 6234 1500 50  0000 C CNN
F 2 "" V 6280 1500 50  0001 C CNN
F 3 "~" H 6350 1500 50  0001 C CNN
	1    6350 1500
	0    1    1    0   
$EndComp
Wire Wire Line
	6150 1500 6200 1500
Connection ~ 6150 1500
Wire Wire Line
	6150 1500 6150 1550
Wire Wire Line
	6500 1500 6600 1500
$EndSCHEMATC
