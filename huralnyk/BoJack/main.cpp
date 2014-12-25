#include <iostream>
#include <queue>
#include <time.h>

using namespace std;

const unsigned short N = 40000;

struct cell
{
    short x;
    short y;
};

short BFS(const short& startX, const short& startY, const short& finishX, const short& finishY)
{
    if(startX == finishX && startY == finishY)
    {
        cout << "We are on the finish point" << endl;
        return 0;
    }

    // Create chessboard and mark all cells as unvisited
    char* ChessBoard = new char [N*N];
    for(int i = 0; i < N*N; ++i)
    {
        ChessBoard[i] = 0;
    }

    // Create a queue for BFS
    queue<cell> queue;

    // Mark the current node as visited and enqueue it
    struct cell start;
    struct cell child;
    start.x = startX;
    start.y = startY;
    ChessBoard[startX*N + startY] = 42;
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
            if(x >= 0 && x < N && y >= 0 && y < N)
            {
                if(ChessBoard[x*N + y] == 0)
                {
                    child.x = x;
                    child.y = y;
                    ChessBoard[x*N + y] = i+1;

                    // Check whether next cell is endpoint.
                    // If yes, print backroute and count steps. Return steps
                    if((finishX == x) && (finishY == y))
                    {
                        cout << "Here is the road home: ";
                        while(ChessBoard[x*N + y] != 42) // Print the road home
                        {
                            cout << "(" << x << ", " << y << ") ";
                            j = ChessBoard[x*N + y] - 1;
                            x = x - moves[j][0];
                            y = y - moves[j][1];
                            ++Steps;
                        }
                        cout << "(" << startX << ", " << startY << ") ";
                        cout << endl;
                        cout << "We made " << Iterations << " iteration(s)." << endl;
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


int main()
{
    unsigned short startX = 0, startY = 0, finishX = 0, finishY = 0;

    cout << "Set startpoint X, Y coordinates: ";
    cin >> startX >> startY;

    cout << "Set endpoint X, Y coordinates: ";
    cin >> finishX >> finishY;

    float fTimeStart = clock()/(float)CLOCKS_PER_SEC;
    cout << "We have to make " << BFS(startX, startX, finishX, finishY) << " step(s)" << endl;
    float fTimeStop = clock()/(float)CLOCKS_PER_SEC;
    cout << "Time execution in sec: " << fTimeStop - fTimeStart << endl;

    return 0;
}