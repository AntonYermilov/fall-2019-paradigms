from abc import ABC, abstractmethod
from typing import Dict, Tuple
from entity import Entity
from random import randint

class Character(Entity):
    def __init__(self, x: int, y: int, name: str, health: int):
        super().__init__(x, y, name)
        self.health = health

    @abstractmethod
    def make_turn(self):
        pass


class Player(Character):
    def __init__(self, x: int, y: int, name: str, health: int):
        super().__init__(x, y, name, health)
        self.turns: Dict[str, Tuple[int, int]] = {
            'L': (-1, 0),
            'R': (1, 0),
            'U': (0, 1),
            'D': (0, -1)
        }
    
    def make_turn(self):
        turn = input('Make turn [L,R,U,D]:\n')
        dx, dy = self.turns[turn]
        self.x += dx
        self.y += dy
    
    def draw(self):
        print(f'Player {self.name}: x={self.x}, y={self.y}, health={self.health}')


class SuperPlayer(Player):
    def draw(self):
        print(f'SuperPlayer {self.name}: x={self.x}, y={self.y}, health={self.health}')


class Mob(Character):
    def __init__(self, x: int, y: int, name: str, health: int):
        super().__init__(x, y, name, health)

    def make_turn(self):
        dx, dy = randint(-1, 1), randint(-1, 1)
        self.x += dx
        self.y += dy

    def draw(self):
        print(f'Mob {self.name}: x={self.x}, y={self.y}, health={self.health}')

