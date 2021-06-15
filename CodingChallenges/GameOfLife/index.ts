import {Game} from './app/game';
import {Cell, Point} from './app/cell';

export default function() {

    /*let initialCells = [
        new Cell(new Point(2,1),1),
        new Cell(new Point(3,1),1),
        new Cell(new Point(4,2),2),
        new Cell(new Point(3,3),1),
        new Cell(new Point(4,3),2),
        new Cell(new Point(2,5),1),
        new Cell(new Point(1,6),2),
        new Cell(new Point(2,6),1),
        new Cell(new Point(1,7),2)
    ];*/

    //let game: Game = new Game(10,10,initialCells);

    let initialCells = [
        new Cell(new Point(2,0),1), // X coordinate, Y coordinate, age
        new Cell(new Point(2,1),1),
        new Cell(new Point(3,1),1),
        new Cell(new Point(1,2),2),
        new Cell(new Point(2,2),2),
        new Cell(new Point(3,2),1),
        new Cell(new Point(3,3),1)      
    ];

    let game: Game = new Game(5,5,initialCells);

    //for (let i = 1; i < 20; i++) 
        game.incrementGeneration();

    //Prints the game state at the 20th Generation

    console.log(
        game.printGrid()
    );

}