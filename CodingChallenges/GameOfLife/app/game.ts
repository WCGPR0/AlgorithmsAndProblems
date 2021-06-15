import { Cell, Age, Point } from "./cell";
import { Grid } from "./grid";

interface GameInterface {
    grid: Grid;
    generation: number;
}

class Game implements GameInterface {
    grid: Grid;
    generation: number;
    constructor(width: number, height: number, initialCells: Cell[]) {
        this.grid = new Grid(width, height);
        this.generation = 1;
        for (let cell of initialCells) {
            this.setCell(cell);
        }
    }

    private setCell(cell: Cell) {
        const point = [...this.grid.coordinates.keys()].filter( point => point.x === cell.point.x && point.y === cell.point.y)[0];
        this.grid.coordinates.set(point, cell);
    }

    printGrid(): string {
        let gridString = "";
        let y = 0;

        for (let y = 0; y < this.grid.height; y++) {
            for (let x = 0; x < this.grid.width; x++) {
                const point = this.grid.getPoint(x, y);
                //let point = new Point(x, y);
                const cell = this.grid.coordinates.get(point);

                if (cell.age != Age.EMPTY) {
                    gridString += cell.age;
                } else {
                    gridString += 'x';  //Indicates empty space 
                }
                gridString += "\t";

            }
            gridString += '\n';
        }

        return gridString;
    }

    incrementGeneration(): void {
        this.generation += 1;
        let range = this.getRange();
        for (let [point, cell] of range) {
            let original_cell = this.grid.coordinates.get(this.grid.getPoint(point.x, point.y));
            cell.age = this.recalcAge(original_cell);
        }
        for (const cell of range.values()) {
            this.setCell(cell);
        }
    }

    /** Creates a new deep copy of the relevant range of potential cells that requires checking neighbors for */
    private getRange() : Map<Point, Cell> {
            let aliveCells = [...this.grid.coordinates].filter( ([point, cell]) => cell.age != Age.EMPTY);
            let minY = Math.min( ...aliveCells.map( ([point, cell]) => cell.point.y )) - 1;
            let minX = Math.min( ...aliveCells.map( ([point, cell]) => cell.point.x )) - 1;
            let maxX = Math.max( ...aliveCells.map( ([point, cell]) => cell.point.x )) + 1;
            let maxY = Math.max( ...aliveCells.map( ([point, cell]) => cell.point.y )) + 1;

            /** <Reset boundary to grid if it goes off the map> */

            [minX, minY].forEach( function(val, index, arr) {
                if (val < 0)
                    arr[index] = 0;
            });

            if (maxX > this.grid.width)
                maxX = this.grid.width;
            
            if (maxY > this.grid.height)
                maxY = this.grid.height;

            /** </Reset boundary to grid if it goes off the map> */
            let range = [...this.grid.coordinates].filter( ([point, cell]) => point.x >= minX && point.y >= minY && point.x <= maxX && point.y <= maxY);
            let cloned_range = JSON.parse(JSON.stringify(range));
            return new Map(cloned_range);
    }

    /** Checks the neighbors of the cell, returning new age based on the ruleset */
    private recalcAge(cell: Cell): Age {
        
        /** <Get neighbors, excluding empty cell, surrounding cell> */
        let neighbors : Cell[] = [];
        for (let yOffset = -1; yOffset < 2; yOffset++) {
            for (let xOffset = -1; xOffset < 2; xOffset++) {
                let x = cell.point.x + xOffset;
                let y = cell.point.y + yOffset;
                if ( (x < 0 || y < 0) /*Out of lower bounds */ ||
                     ( x >= this.grid.width || y >= this.grid.height)  /*Out of higher bounds */ ||
                     (x === cell.point.x && y === cell.point.y) /* Same cell */
                    )
                    continue;
                let neighborCell = [...this.grid.coordinates.values()].find( cell => (cell.point.x === x) && (cell.point.y === y) );
                if (neighborCell.age != Age.EMPTY)
                    neighbors.push(neighborCell);
            }
        }
        /** </Get neighbors, excluding empty cell, surrounding cell> */
        
        switch(cell.age) {
            case Age.EMPTY:
                return (neighbors.filter(cell => cell.age === Age.ADULT).length === 2) ? Age.NEWBORN : Age.EMPTY;
            case Age.NEWBORN:
                return (neighbors.length >= 5 || neighbors.length <= 1) ? Age.EMPTY : Age.ADULT
            case Age.ADULT:
                return (neighbors.length >= 3 || neighbors.length == 0) ? Age.EMPTY : Age.SENIOR
            case Age.SENIOR:
                return Age.EMPTY;
            default: 
                throw("Undefined Age");
        }

    }

}


export {Game};