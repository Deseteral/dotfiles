#!/usr/bin/env python3
import os
import shutil
import sys
import tomllib


def main():
    data = read_fragments_config()
    if data is None:
        print('Could not read fragments config file.')
        sys.exit(1)

    if len(sys.argv) == 1:
        print_help_and_exit()

    command = sys.argv[1]
    if command not in ['fetch', 'apply']:
        print_help_and_exit()

    if command == 'fetch':
        fetch_fragments(data)
    elif command == 'apply':
        apply_fragments(data)


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


def print_help_and_exit():
    print('Help')
    sys.exit(1)


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
