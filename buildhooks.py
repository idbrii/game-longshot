#! /usr/bin/env python

import argparse
import pathlib

def _get_and_validate_args():
    arg_parser = argparse.ArgumentParser(
        description='''Change the return value of a function to switch between dev and prod.
        '''
    )

    group = arg_parser.add_mutually_exclusive_group(required=True)
    group.add_argument('--to-prod',
                       action='store_true',
                       help="Switch to production.")

    group.add_argument('--to-dev',
                       action='store_true',
                       help="Switch to dev.")

    args = arg_parser.parse_args()
    return args

def change_to_return(fpath, new_return_value):
    """Change devcheck to return the input value.
    """

    with open(fpath, 'r') as f:
        dev = f.readlines()
    with open(fpath, 'w') as f:
        is_in_prod_fn = False
        for line in dev:
            if is_in_prod_fn and line.startswith('end'):
                is_in_prod_fn = False
            if not is_in_prod_fn:
                f.write(line)
            if 'function devcheck.isProduction' in line:
                is_in_prod_fn = True
                f.write('    return {}\n'.format(new_return_value))

def main(args):
    parent = pathlib.Path(__file__).resolve().parent
    fpath = parent / 'src/devcheck.lua'
    if args.to_prod:
        change_to_return(fpath, 'true')
    if args.to_dev:
        change_to_return(fpath, 'false')
        
    
if __name__ == "__main__":
    main(_get_and_validate_args())

