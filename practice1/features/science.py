#!/usr/bin/env python3


"""
Выводит на экран табличку с людьми из заданного файла, имя и фамилия которых соответствует заданной регулярке.
Пример использования: `python3 science.py "Al*" scientists.json`
"""


import collections
import json
import argparse
import re
from pathlib import Path


Person = collections.namedtuple('Person', ['first_name', 'last_name', 'birth_date'])


def format_person(p):
    return '{}. {}, born on {}'.format(p.first_name[:1], p.last_name, p.birth_date)


def print_table(people):
    for p in people:
        print('* ' + format_person(p))
    print('Total: {}'.format(len(people)))


def main(args):
    source = Path(args.file)
    if not source.exists():
        print(f'File {source.name} does not exist')
        return

    with source.open('r') as f:
        people = [Person(**p) for p in json.load(f)]

    match = re.compile(args.regex)
    print_table([p for p in people if match.search(' '.join([p.first_name, p.last_name]))])


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('regex')
    parser.add_argument('file')
    args = parser.parse_args()
    main(args)
