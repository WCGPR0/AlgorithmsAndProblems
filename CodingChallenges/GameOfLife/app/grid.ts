import {Point, Cell} from './cell';

interface GridInterface {
    coordinates: Map<Point, Cell>;
}

class Grid implements GridInterface {
    coordinates: Map<Point, Cell>;
    width: number;
    height: number;

    //Constructs a Grid of size, width x height
    constructor(width: number, height: number) {
        this.width = width;
        this.height = height;
        this.coordinates = new Map();
        for (let y = 0; y < height; y++) {
            for (let x = 0; x < width; x++) {
                let point = new Point(x, y);
                let cell = new Cell(point);
                this.coordinates.set(point, cell);
            }
        }
    }

    getPoint(x: number, y: number): Point {
        return [...this.coordinates.keys()].filter( point => point.x === x && point.y === y)[0];
    }
}

export {Grid};