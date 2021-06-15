### Description:

You will be building a 2-D cellular automata: a grid of “cells” that exhibits behavior over the
course of iterative generations. Each generation is computed based on the array of cells in the
previous generation. If you are familiar with Conway’s Game of Life, this is a very similar
concept but with a different ruleset.


### Specifications:

A cellular automata is a 2D grid of cells. Cells maybe either empty or alive. You may represent
empty cells with a zero or null value. If cells are alive, they have an “age”: an integer value that
is 1 (newborn), 2 (adult), or 3 (senior).


Below is an example 4 x 4 grid containing three newborns, one adult, and one senior.

|---|---|---|---|---|
|---|---|---|---|---|
|   | 1 |   |   |   |
|   | 1 | 3 |   |   |
|   |   | 1 |   |   |
|   | 2 |   |   |   |

#### Neighbors

The “neighbors” of a cell are the eight cells immediately surrounding it orthogonally or
diagonally. For example, the senior in the example above has three neighbors, all of them
newborns. The adult in the example above has only one neighbor, also a newborn.

Note that edge cells have only 5 potential neighbors, and corners have only 3.

#### Ruleset

In each generation, compute the new value for the grid by the following rules:

<table>
    <thead>
        <tr>
            <th>Old Cell</th>
            <th>Rule</th>
            <th>New Cell</th>
            <th>Comment</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td rowspan=2>empty</td>
            <td>Exactly 2 adult neighbors</td>
            <td>1</td>
            <td>Reproduction</td>
        </tr>
        <tr>
            <td>otherwise</td>
            <td>empty</td>
            <td>No change</td>
        </tr>
        <tr>
            <td rowspan=3>1 (newborn)</td>
            <td>>= 5 total neighbors</td>
            <td>empty</td>
            <td>Overcrowding</td>
        </tr>
        <tr>
            <td><= 1 total neighbors</td>
            <td>empty</td>
            <td>Isolation</td>
        </tr>
        <tr>
            <td>otherwise</td>
            <td>2</td>
            <td>Growing up</td>
        </tr>
        <tr>
            <td rowspan="3">2 (adult)</td>
            <td>>=3 total neighbors</td>
            <td>empty</td>
            <td>Overcrowding</td>
        </tr>
        <tr>
            <td>Zero neighbors</td>
            <td>empty</td>
            <td>Isolation</td>
        </tr>
        <tr>
            <td>otherwise</td>
            <td>3</td>
            <td>Aging</td>
        </tr>
        <tr>
            <td>3 (senior)</td>
            <td>All conditions</td>
            <td>empty</td>
            <td>"Natural Causes"</td>
        </tr>
    </tbody>
</table>

#### Generation Example

##### Generation 1

|---|---|---|---|---|
|---|---|---|---|---|
|   |   | 1 |   |   |
|   |   | 1 | 1 |   |
|   | 2 | 2 | 1 |   |
|   |   |   | 1 |   |
|   |   |   |   |   |


# →

##### Generation 2

|---|---|---|---|---|
|---|---|---|---|---|
|   |   | 2 |   |   |
|   | 1 |   | 2 |   |
|   | 3 |   | 2 |   |
|   | 1 | 1 | 2 |   |
|   |   |   |   |   |

- Three newborns are born near the pair of adults at(1,2) and (2,2).
- One of the adults has 2 neighbors and ages. The other has 5 and dies of overcrowding.
- The newborn at (2,1) dies of overcrowding
- All the other newborns grow up to become adults.

##### Question

If the following 10x10 grid is Generation 1, what is Generation 20?

|---|---|---|---|---|---|---|---|---|---|
|---|---|---|---|---|---|---|---|---|---|
|   |   |   |   |   |   |   |   |   |   |
|   |   | 1 | 1 |   |   |   |   |   |   |
|   |   |   |   | 2 |   |   |   |   |   |
|   |   |   | 1 | 2 |   |   |   |   |   |
|   |   |   |   |   |   |   |   |   |   |
|   |   | 1 |   |   |   |   |   |   |   |
|   | 2 | 1 |   |   |   |   |   |   |   |
|   | 2 |   |   |   |   |   |   |   |   |
|   |   |   |   |   |   |   |   |   |   |
|   |   |   |   |   |   |   |   |   |   |
