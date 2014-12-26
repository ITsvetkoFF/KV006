#include <iostream>
#include <queue>
#include <time.h>
#include <stdlib.h>

using namespace std;

//const unsigned short SIZE = 10000;

struct cell
{
    short x;
    short y;
};

short BFS(const short& startX, const short& startY, const short& finishX, const short& finishY, const short& SIZE)
{
    if(startX == finishX && startY == finishY)
    {
        cout << "We are on the finish point" << endl;
        return 0;
    }

    // Create chessboard and mark all cells as unvisited
    char* ChessBoard = new char [SIZE * SIZE]{0};

    // Create a queue for BFS
    queue<cell> queue;

    // Mark the current node as visited and enqueue it
    struct cell start;
    struct cell child;
    start.x = startX;
    start.y = startY;
    ChessBoard[startX * SIZE + startY] = 42;
    queue.push(start);

    // Create variable to store amount of steps and iterations
    short Steps = 0;
    int Iterations = 0;
    short x = 0, y = 0, i = 0, j = 0;

    // Create an array of possible moves
    char moves[8][2] = {{2, 1}, {2, -1}, {-2, 1}, {-2, -1}, {1, 2}, {1, -2}, {-1, 2}, {-1, -2}};

    while(true)
    {
        // Dequeue a vertex from queue
        start = queue.front();
        queue.pop();

        ++Iterations;

        // Mark all children of current cell as visited and enqueue them.
        for(i = 0; i < 8; ++i)
        {
            x = start.x + moves[i][0];
            y = start.y + moves[i][1];
            if(x >= 0 && x < SIZE && y >= 0 && y < SIZE)
            {
                if(ChessBoard[x * SIZE + y] == 0)
                {
                    child.x = x;
                    child.y = y;
                    ChessBoard[x * SIZE + y] = i + 1;

                    // Check whether next cell is endpoint.
                    // If yes, print the home road and count steps. Return steps.
                    if((finishX == x) && (finishY == y))
                    {
                        //cout << "Here is the road home: ";
                        while(ChessBoard[x * SIZE + y] != 42) // Print the road home
                        {
                            //cout << "(" << x << ", " << y << ") ";
                            j = ChessBoard[x * SIZE + y] - 1;
                            x = x - moves[j][0];
                            y = y - moves[j][1];
                            ++Steps;
                        }
                        //cout << "(" << startX << ", " << startY << ") ";
                        //cout << endl;
                        //cout << "We made " << Iterations << " iteration(s)." << endl;
                        // Free memory
                        delete[] ChessBoard;
                        return Steps;
                    }
                    queue.push(child);
                }
            }
        }
    }
}


int main(int argc, char *argv[])
{
    /*unsigned short startX = 0, startY = 0, finishX = 0, finishY = 0;

    cout << "Set startpoint X, Y coordinates: ";
    cin >> startX >> startY;

    cout << "Set endpoint X, Y coordinates: ";
    cin >> finishX >> finishY;*/

    float fTimeStart = clock()/(float)CLOCKS_PER_SEC;
    cout << "We have to make " << BFS(atoi(argv[1]), atoi(argv[2]), atoi(argv[3]), atoi(argv[4]), atoi(argv[5])) << " step(s)" << endl;
    float fTimeStop = clock()/(float)CLOCKS_PER_SEC;
    cout << "Time execution in sec: " << fTimeStop - fTimeStart << endl;

    return 0;
}