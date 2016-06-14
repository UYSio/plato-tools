#!/usr/bin/env python3

import datetime as dt
import os

def mkdir():
    today = dt.datetime.today().strftime('%Y/%m/%d/%H/%M/%S')
    os.makedirs(today, exist_ok=True)
    return today

if __name__ == '__main__':
    mkdir()
