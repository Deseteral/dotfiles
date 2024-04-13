#!/usr/bin/env python3

# Script for managing and backing up various configuration files in the system.
# It operates on fragments - configuration groups (most likely corresponding
# to apps). Each fragment can have more then one file/directory that is going
# to process - targets.
#
# Fragments and their targets are defined in fragments.toml file. Example:
#
# [nvim]
# targets = [
#     { src = "~/.config/nvim", dir = "config" },
# ]
#

import os
import shutil
import tomllib
import argparse

HELP_APPLY = 'apply configuration stored in the repository'
HELP_FETCH = 'fetch actual configuration and store it in the repository'
HELP_SELECT = 'comma separated list of fragments to operate on, or all fragments when omited'
HELP_LIST = 'list fragments present in configuration file'


def main():
    args = parse_args()

    data = read_fragments_config()
    if data is None:
        return

    config_fragments = set(data.keys())
    fragments = config_fragments
    if args.select is not None:
        fragments = config_fragments & args.select

    if len(fragments) == 0:
        print('Cannot perform operations without selected fragments.')
        return

    if args.fetch:
        fetch_fragments(data, fragments)
    elif args.apply:
        apply_fragments(data, fragments)
    elif args.list:
        list_fragments(data)


def parse_args():
    parser = argparse.ArgumentParser()

    group = parser.add_mutually_exclusive_group()
    group.add_argument('--apply', help=HELP_APPLY, action='store_true')
    group.add_argument('--fetch', help=HELP_FETCH, action='store_true')
    group.add_argument('--list', help=HELP_LIST, action='store_true')
    group.required = True

    parser.add_argument('--select', help=HELP_SELECT, type=str)

    args = parser.parse_args()

    if args.select is not None:
        args.select = set([s.strip() for s in args.select.split(',')])

    return args


def fetch_fragments(data, fragments):
    print(f'Performing fetch for {', '.join(fragments)} fragments.')

    mkdir('./fragments')

    for fragment in fragments:
        for target in data[fragment]['targets']:
            src = os.path.expanduser(target['src'])
            basename = os.path.basename(src)
            target_dir = os.path.join('.', 'fragments', fragment)

            if 'dir' in target:
                subdir = os.path.expanduser(target['dir'])
                target_dir = os.path.join(target_dir, subdir)

            if os.path.isdir(src):
                target_dir = os.path.join(target_dir, basename)

            mkdir(target_dir)
            copy(src, target_dir)


def apply_fragments(data, fragments):
    print(f'Performing apply for {', '.join(fragments)} fragments.')

    for fragment in fragments:
        for target in data[fragment]['targets']:
            src = os.path.expanduser(target['src'])
            target_dir = os.path.join('.', 'fragments', fragment)

            if 'dir' in target:
                subdir = os.path.expanduser(target['dir'])
                target_dir = os.path.join(target_dir, subdir)

            basename = os.path.basename(src)
            target_dir = os.path.join(target_dir, basename)

            copy(target_dir, src)


def list_fragments(data):
    fragments = ', '.join(data.keys())
    print('Fragments defined in configuration file:')
    print(fragments)


def read_fragments_config():
    try:
        f = open('./fragments.toml', mode='rb')
        data = tomllib.load(f)
        f.close()
        return data
    except Exception:
        print('Could not read fragments config file.')
        return None


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
