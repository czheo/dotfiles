#!/usr/bin/env python3
import sys
import os
from pathlib import Path
try:
    import exiftool
except:
    os.system('pip3 install pyexiftool')
    import exiftool
import argparse
import filecmp
from datetime import datetime
import re
from collections import Counter

def similar(a, b):
    diff = Counter(a) - Counter(b)
    return sum(abs(v) for v in diff.values())

def get_create_date(path, et):
    metadata = et.get_metadata(str(path))
    dates = []
    for k, v in metadata.items():
        lower_k = k.lower()
        if 'create' in lower_k and 'date' in lower_k:
            dt = to_datetime(v)
            if dt is not None:
                dates.append((similar(lower_k, 'create date'), dt))
    return min(dates, default=(None ,None))[1]

def get_date(path, et):
    metadata = et.get_metadata(str(path))
    dates = []
    for k, v in metadata.items():
        lower_k = k.lower()
        if 'date' in lower_k:
            dt = to_datetime(v)
            if dt is not None:
                dates.append((similar(lower_k, 'create date'), dt))
    return min(dates, default=(None ,None))[1]

def to_datetime(date_str):
    try:
        fmt = '%Y:%m:%d %H:%M:%S'
        pattern = re.compile(r'(\d{4}:\d{2}:\d{2} \d{2}:\d{2}:\d{2})')
        matched = pattern.search(date_str)
        s = matched.group()
        return datetime.strptime(s, fmt)
    except:
        return None


def main(args):
    setup(args)
    input_dir = args.input_dir
    output_dir = args.output_dir
    with exiftool.ExifTool() as et:
        for path in Path(input_dir).glob("**/*"):
            name = path.name
            if not path.is_file():
                continue
            if path.is_symlink():
                continue
            if name.startswith("."):
                continue
            if path.suffix.lower() == ".zip":
                continue
            create_date = get_create_date(path, et)
            if create_date:
                year = '%d' % create_date.year
                month = '%02d' % create_date.month
                day = '%02d' % create_date.day
                output_path = os.path.join(output_dir, year, month + day, name)
            else:
                date = get_date(path, et)
                year = '%d' % date.year
                month = '%02d' % date.month
                day = '%02d' % date.day
                output_path = os.path.join(output_dir, 'unsorted', year, month + day, name)
            safe_copy(path, output_path)

def safe_copy(frm, to):
    if not os.path.exists(to):
        to_dir = Path(to).parent
        print(f'cp "{frm}" "{to}"')
        os.system(f'mkdir -p "{to_dir}" && cp "{frm}" "{to}"')
    else:
        if filecmp.cmp(frm, to):
            print(f"skipping since it's already copied: {frm}")
            if args.remove_old:
                print(f'rm "{frm}"')
                os.system(f'rm "{frm}"')
        else:
            safe_copy(frm, to + Path(to).suffix)

def setup(args):
    input_dir = args.input_dir
    output_dir = args.output_dir
    if not os.path.isdir(input_dir):
        exit(f"Input dir does not exists: {input_dir}")
    if not os.path.exists(output_dir):
        print(f"Ouput dir does not exists. Create new: {output_dir}")
        os.mkdir(output_dir)
    if not os.path.isdir(output_dir):
        exit(f"Ouput path is not a directory: {input_dir}")


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='copy media files from input_dir to output_dir by year/month in EXIF info')
    parser.add_argument('input_dir')
    parser.add_argument('output_dir')
    parser.add_argument('--remove-old', action='store_true')

    args = parser.parse_args()
    main(args)
