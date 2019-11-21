import time
from typing import List
from entity import Entity, Wall
from character import Character, Player, Mob, SuperPlayer


class Game:
    def __init__(self):
        self.entities: List[Entity] = [Wall(1, 2), Wall(5, 3), SuperPlayer(0, 0, '@', 100), Mob(-3, 2, 'snake', 20), Mob(-4, -2, 'cockroach', 10)]

    def start(self):
        self.draw()
        while True:
            self.make_turn()
            self.draw()
    
    def make_turn(self):
        for entity in self.entities:
            if isinstance(entity, Character):
                entity.make_turn()

    def draw(self):
        print('====')
        for entity in self.entities:
            entity.draw()


if __name__ == '__main__':
    game = Game()
    game.start()

