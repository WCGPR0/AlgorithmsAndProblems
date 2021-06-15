import * as faker from 'faker';
import {Game} from '../app/game';
import {Cell, Point} from '../app/cell';

describe('some tests', () => {

    it("initialization should pass", () => {
        let initialCells = [
            new Cell(new Point(2,0),1), // X coordinate, Y coordinate, age
            new Cell(new Point(2,1),1),
            new Cell(new Point(3,1),1),
            new Cell(new Point(1,2),2),
            new Cell(new Point(2,2),2),
            new Cell(new Point(3,2),1),
            new Cell(new Point(3,3),1)      
        ];

        let projectedCells = [
            new Cell(new Point(2,0),2), // X coordinate, Y coordinate, age
            new Cell(new Point(1,1),1),
            new Cell(new Point(3,1),2),
            new Cell(new Point(1,2),3),
            new Cell(new Point(3,2),2),
            new Cell(new Point(1,3),1),
            new Cell(new Point(2,3),1),
            new Cell(new Point(3,3),2),
        ]
        
        let game: Game = new Game(5,5,initialCells);
        game.incrementGeneration();

        let projectedGame: Game = new Game(5,5, projectedCells);

        let mismatch: number = 0;
        for (const [projectedKey, projectedVal] of projectedGame.grid.coordinates) {
            let key = game.grid.getPoint(projectedKey.x, projectedKey.y);
            let val = game.grid.coordinates.get(key);
            if (val.age !== projectedVal.age)
                mismatch += 1;
        }

        //assert(mismatch == 0, `There are ${mismatch} mismatches`);

    })

})