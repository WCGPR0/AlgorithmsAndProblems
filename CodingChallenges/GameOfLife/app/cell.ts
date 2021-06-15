enum Age {
    EMPTY = 0,
    NEWBORN = 1,
    ADULT = 2,
    SENIOR = 3
}

interface PointInterface {
    x: number;
    y: number;
}

class Point implements PointInterface {
    x: number;
    y: number;
    constructor(x: number, y: number) {
        this.x = x;
        this.y = y;
    }
}

class Cell {
    point: Point;
    age: Age.EMPTY | Age.NEWBORN | Age.ADULT | Age.SENIOR;
    constructor(point: Point, age: number = Age.EMPTY) {
        this.point = point;
        this.age = age;
    }
}

export { Age, Point, Cell };