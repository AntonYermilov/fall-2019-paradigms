#!/usr/bin/env python3

import collections
from datetime import date

Person = collections.namedtuple('Person', ['first_name', 'last_name', 'birth_date', 'area'])
people = [
    Person(first_name='Albert', last_name='Einstein', birth_date=date(year=1879, month=3, day=14), area='physics'),
    Person(first_name='Alan', last_name='Turing', birth_date=date(year=1912, month=6, day=23), area='cs'),
    Person(first_name='Edsger', last_name='Dijkstra', birth_date=date(year=1930, month=5, day=11), area='cs'),
    Person(first_name='Niels', last_name='Bohr', birth_date=date(year=1885, month=10, day=7), area='physics'),
    Person(first_name='Leslie', last_name='Lamport', birth_date=date(year=1941, month=2, day=7), area='cs'),
]


x=people[0].birth_date
y=people[0]

print("--- Physics ---")
i=0
for p in people:
    if p.area =="physics":
        print("* {}. {}, born on {}".format(p.first_name[:1], p.last_name,p.birth_date))
        if p.birth_date < x:
            x=p.birth_date
            y=p
        i +=1
print("Total: {}".format(i))
print()
print("--- Computer Science ---")
i=0
for p in people:
    if p.area =="cs":
        print("* {}. {}, born on {}".format(p.first_name[:1],p.last_name, p.birth_date))
        if p.birth_date < x:
            x =p.birth_date
            y =p
        i +=1
print("Total: {}".format(i))

print('Oldest person: {}. {}, born on {}'.format(y.first_name[:1], y.last_name,x))
