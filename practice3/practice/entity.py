from abc import ABC, abstractmethod

class Entity(ABC):
    def __init__(self, x: int, y: int, name: str):
        self.x = x
        self.y = y
        self.name = name

    @abstractmethod
    def draw(self):
        pass

class Wall(Entity):
    def __init__(self, x: int, y: int):
        super().__init__(x, y, 'wall')

    def draw(self):
        print(f'wall: x={self.x}, y={self.y}')
