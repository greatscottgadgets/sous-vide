#!/usr/bin/env python3
#
# This file is part of GreatFET

from __future__ import print_function

import argparse
import errno
import sys
import time

import greatfet
from greatfet import GreatFET
from greatfet.utils import log_silent, log_verbose
from greatfet.protocol import vendor_requests

COOK_TIME = 20
TARGET_TEMP = 27
MIN_TEMP = 26.9
MAX_TEMP = 85

time_elapsed = 0
start_time = 0
current_temp = 0
timer_started = False


def init(device):
    print("init")
    turn_on_heater()
    preparing(current_temp, time_elapsed, timer_started, start_time, device)


def preparing(current_temp, time_elapsed, timer_started, start_time, device):
    while current_temp < TARGET_TEMP:
        print("heating up")
        data = device.vendor_request_in(vendor_requests.DS18B20_READ, length=2)
        current_temp = (data[1] << 8 | data[0]) / 16.0
        print(time.strftime("%H:%M:%S"), current_temp)
        if timer_started is True:
            time_elapsed = get_time_elapsed(start_time)
            if time_elapsed >= COOK_TIME:
                turn_off_heater()
                done()
        time.sleep(1)
    if timer_started is False:
        start_time = get_start_time()
        timer_started = True
        print("start time: " + str(start_time))
        turn_off_heater()
        cooking(current_temp, start_time, time_elapsed, device)
    elif timer_started is True and time_elapsed < COOK_TIME:
        time_elapsed = get_time_elapsed(start_time)
        turn_off_heater()
        cooking(current_temp, start_time, time_elapsed, device)
    # TODO: might be able to get rid of this last elif statement but will keep it for now
    elif timer_started is True and time_elapsed >= COOK_TIME:
        turn_off_heater()
        done()


def cooking(current_temp, start_time, time_elapsed, device):
    while current_temp > MIN_TEMP and time_elapsed < COOK_TIME:
        print("cooking")
        time_elapsed = get_time_elapsed(start_time)
        data = device.vendor_request_in(vendor_requests.DS18B20_READ, length=2)
        current_temp = (data[1] << 8 | data[0]) / 16.0
        print(time.strftime("%H:%M:%S"), current_temp)
        time.sleep(1)
    if time_elapsed >= COOK_TIME:
        done()
    elif current_temp <= MIN_TEMP:
        preparing(current_temp, time_elapsed, True, start_time, device)


def done():
    print("done")
    sys.exit()


def turn_on_heater():
    print("heater turned on")


def turn_off_heater():
    print("heater turned off")


def get_start_time():
    print("starting timer")
    return time.time()


def get_time_elapsed(start_time):
    current_time = time.time()
    time_elapsed = current_time - start_time
    print("time elapsed: " + str(time_elapsed))
    return time_elapsed


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
