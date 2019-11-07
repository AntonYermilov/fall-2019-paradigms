from .functions import *


"""
Запускать тесты с pytest
"""


def test_transform_1():
    arr = list(range(10))
    assert transform_simple(arr, 5, 7) == [25, 36, 49]


def test_transform_2():
    arr = list(range(10))
    assert transform_generators(arr, 5, 7) == [25, 36, 49]


def test_transform_3():
    arr = list(range(10))
    assert transform_list_comprehensions(arr, 5, 7) == [25, 37, 49]
