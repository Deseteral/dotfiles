#!/usr/bin/env python3
import os
import shutil
import sys
import tomllib
import argparse

HELP_APPLY = 'apply configuration stored in the repository'
HELP_FETCH = 'fetch actual configuration and store it in the repository'


def main():
    args = parse_args()

    data = read_fragments_config()
    if data is None:
        print('Could not read fragments config file.')
        sys.exit(1)

    if args.fetch:
        fetch_fragments(data)
    elif args.apply:
        apply_fragments(data)


def parse_args():
    parser = argparse.ArgumentParser()

    group = parser.add_mutually_exclusive_group()
    group.add_argument('--apply', help=HELP_APPLY, action='store_true')
    group.add_argument('--fetch', help=HELP_FETCH, action='store_true')
    group.required = True

    return parser.parse_args()


def fetch_fragments(data):
    fragments = list(data.keys())
    print(f'Performing fetch for {', '.join(fragments)} fragments.')

    mkdir('./fragments')

    for fragment in fragments:
        for target in data[fragment]['targets']:
            src = os.path.expanduser(target['src'])
            basename = os.path.basename(src)
            target_dir = './fragments/' + fragment

            if 'dir' in target:
                subdir = os.path.expanduser(target['dir'])
                target_dir += '/' + subdir

            if os.path.isdir(src):
                target_dir += '/' + basename

            mkdir(target_dir)
            copy(src, target_dir)


def apply_fragments(data):
    fragments = list(data.keys())
    print(f'Performing apply for {', '.join(fragments)} fragments.')

    for fragment in fragments:
        for target in data[fragment]['targets']:
            src = os.path.expanduser(target['src'])
            target_dir = './fragments/' + fragment

            if 'dir' in target:
                subdir = os.path.expanduser(target['dir'])
                target_dir += '/' + subdir

            basename = os.path.basename(src)
            target_dir += '/' + basename

            copy(target_dir, src)


def read_fragments_config():
    data = None
    with open('./fragments.toml', mode='rb') as fp:
        data = tomllib.load(fp)
    return data


def mkdir(p):
    if not os.path.exists(p):
        os.makedirs(p)


def copy(s, d):
    print(f'Copying "{s}" to "{d}"...', end='')
    if os.path.isdir(s):
        shutil.copytree(s, d, dirs_exist_ok=True)
        print('  Done.')
    elif os.path.isfile(s):
        shutil.copy2(s, d)
        print('  Done.')
    else:
        print('  Skipped...')


if __name__ == '__main__':
    main()
