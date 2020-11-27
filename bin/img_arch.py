#!/usr/bin/env python
import sys
import os
from pathlib import Path
try:
    import exiftool
except:
    os.system('pip install pyexiftool')
    import exiftool
import argparse
import filecmp

def get_create_date(path, et):
    fullpath = str(path)
    if path.suffix.lower() == ".mov":
        return et.get_tag("QuickTime:MediaCreateDate", fullpath)
    else:
        return et.get_tag("EXIF:CreateDate", fullpath)

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
                year = create_date[:4]
                month = create_date[5:7]
                output_path = os.path.join(output_dir, year, month, name)
                safe_copy(path, output_path)
            else:
                print(f"Cannot get create date: {path}")

def safe_copy(frm, to):
    if not os.path.exists(to):
        to_dir = Path(to).parent
        print(f"cp {frm} {to}")
        os.system(f'mkdir -p {to_dir} && cp {frm} {to}')
    else:
        if filecmp.cmp(frm, to):
            print(f"skipping since it's already copied: {frm}")
            if args.remove_old:
                print(f"rm {frm}")
                os.system(f"rm {frm}")
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
