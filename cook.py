#!/usr/bin/env python3
#
# This file is part of GreatFET

from __future__ import print_function

import argparse
import errno
import sys
import time
import csv

import greatfet
from greatfet import GreatFET
from greatfet.utils import log_silent, log_verbose
from greatfet.protocol import vendor_requests

COOK_TIME = 3600
MIN_TEMPERATURE = 78
MAX_TEMPERATURE = 90

target_temperature = 85

cook_time_elapsed = 0
cook_start_time = 0

sleep_time = 10

current_temperature = 0
timer_started = False

gf = GreatFET()

def init(device):
    print("init")
    preparing(current_temperature, cook_time_elapsed, timer_started, cook_start_time, target_temperature, device)


def preparing(current_temperature, cook_time_elapsed, timer_started, cook_start_time, target_temperature, device):
    turn_on_heater()
    startup_time = time.time()

    while current_temperature < target_temperature:
        print("heating up")
        data = device.vendor_request_in(vendor_requests.DS18B20_READ, length=2)
        current_temperature = (data[1] << 8 | data[0]) / 16.0

        log_time_temperature(current_temperature)
        print(time.strftime("%H:%M:%S"), current_temperature)

        if timer_started is True:
            cook_time_elapsed = get_cook_time_elapsed(cook_start_time)
            if cook_time_elapsed >= COOK_TIME:
                turn_off_heater()
                done()
        time.sleep(sleep_time)
    if timer_started is False:
        cook_start_time = get_cook_start_time()
        timer_started = True
        target_temperature = 81
        print("start time: " + str(cook_start_time))
        turn_off_heater()
        cooking(current_temperature, cook_time_elapsed, cook_start_time, device)
    elif timer_started is True and cook_time_elapsed < COOK_TIME:
        cook_time_elapsed = get_cook_time_elapsed(cook_start_time)
        turn_off_heater()
        cooking(current_temperature, cook_time_elapsed, cook_start_time, device)
    # TODO: might be redundant but will keep in case of unknown scenario
    elif timer_started is True and cook_time_elapsed >= COOK_TIME:
        turn_off_heater()
        done()


def cooking(current_temperature, cook_time_elapsed, cook_start_time, device):
    while current_temperature > MIN_TEMPERATURE and cook_time_elapsed < COOK_TIME:
        print("cooking")
        cook_time_elapsed = get_cook_time_elapsed(cook_start_time)
        data = device.vendor_request_in(vendor_requests.DS18B20_READ, length=2)
        current_temperature = (data[1] << 8 | data[0]) / 16.0

        log_time_temperature(current_temperature)
        print(time.strftime("%H:%M:%S"), current_temperature)

        time.sleep(sleep_time)
    if cook_time_elapsed >= COOK_TIME:
        done()
    elif current_temperature <= MIN_TEMPERATURE:
        preparing(current_temperature, cook_time_elapsed, True, cook_start_time, target_temperature, device)


def done():
    print("done")
    sys.exit()


def turn_on_heater():
    print("heater turned on")
    # set J2 Pin 8 as output, high
    gf.gpio.setup((2, 2), 1)
    gf.gpio.output((2, 2), 1)


def turn_off_heater():
    print("heater turned off")
    # set J2 Pin 8 as output, low
    gf.gpio.setup((2, 2), 1)
    gf.gpio.output((2, 2), 0)


def get_cook_start_time():
    print("starting timer")
    return time.time()


def get_cook_time_elapsed(cook_start_time):
    current_time = time.time()
    cook_time_elapsed = current_time - cook_start_time
    print("time elapsed: " + str(cook_time_elapsed))
    return cook_time_elapsed


def log_time_temperature(current_temperature):
    log_time = time.strftime("%H:%M:%S")
    with open('log.csv', 'a', newline='') as csvfile:
        spamwriter = csv.writer(csvfile, delimiter=',', quotechar='|', quoting=csv.QUOTE_MINIMAL)
        spamwriter.writerow([log_time] + [current_temperature])


def main():
    # Set up a simple argument parser.
    parser = argparse.ArgumentParser(description="Utility for flashing the GreatFET's onboard SPI flash")
    parser.add_argument('-s', dest='serial', metavar='<serialnumber>', type=str,
                        help="Serial number of device, if multiple devices", default=None)
    parser.add_argument('-v', dest='verbose', action='store_true', help="Write data from file")
    args = parser.parse_args()

    log_function = log_verbose if args.verbose else log_silent

    try:
        log_function("Trying to find a GreatFET device...")
        device = GreatFET(serial_number=args.serial)
        log_function("{} found. (Serial number: {})".format(device.board_name(), device.serial_number()))
    except greatfet.errors.DeviceNotFoundError:
        if args.serial:
            print("No GreatFET board found matching serial '{}'.".format(args.serial), file=sys.stderr)
        else:
            print("No GreatFET board found!", file=sys.stderr)
        sys.exit(errno.ENODEV)

    # start cook process
    init(device)

if __name__ == '__main__':
    main()
