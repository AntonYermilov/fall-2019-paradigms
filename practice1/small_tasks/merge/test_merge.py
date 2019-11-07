from .merge import merge


def test_merge():
    assert merge([1], [1]) == [1, 1]
