#include <iostream>
#include <queue>
#include <bitset>
#include <time.h>

using namespace std;

const unsigned int N = 10000;

struct cell
{
    int x;
    int y;
    cell* parent;

};

void initCell(struct cell *head, int x, int y)
{
    head->x = x;
    head->y = y;
    head->parent = NULL;
}

int BFS(int startX, int startY, int finishX, int finishY)
{
    if(startX == finishX && startY == finishY)
    {
        cout << "We are on the finish point" << endl;
        return 0;
    }

    struct cell *start = new cell;
    initCell(start, startX, startY);
    
    int steps = 0;
    int iteration = 0;
    int x = 0, y = 0, tmpX = 0, tmpY = 0;

    // Mark all the vertices as not visited
    bool** visited;
    visited = new bool*[N];
    for(int i = 0; i < N; ++i) {
        visited[i] = new bool[N];
        for (int j = 0; j < N; ++j) {
            visited[i][j] = false;
        }
    }

    // Create a queue for BFS
    queue<cell *> queue;

    // Mark the current node as visited and enqueue it
    visited[start->x][start->y] = true;
    queue.push(start);

    // Create an array of possible moves
    int moves[8][2] = {{2, 1}, {2, -1}, {-2, 1}, {-2, -1}, {1, 2}, {1, -2}, {-1, 2}, {-1, -2}};

    while(!queue.empty())
    {
        // Dequeue a vertex from queue
        start = queue.front();
        queue.pop();
        //cout << "Poped new element " << endl;
        ++iteration;
        x = start->x, y = start->y;

        // Mark all children of current cell as visited and enqueue them.
        for(int i = 0; i < 8; ++i)
        {
            tmpX = start->x + moves[i][0];
            tmpY = start->y + moves[i][1];
            if(tmpX >= 0 && tmpX < N && tmpY >= 0 && tmpY < N)
            {
                if(visited[tmpX][tmpY] != true)
                {
                    struct cell *child = new cell;
                    child->parent = start;
                    child->x = tmpX;
                    child->y = tmpY;
                    visited[tmpX][tmpY] = true;

                    if((finishX == tmpX) && (finishY == tmpY))
                    {
                        cout << "Here is the backroute: ";
                        while(child->parent != NULL) // Print the backroute
                        {
                            cout << "(" << child->x << ", " << child->y << ") ";
                            child = child->parent;
                            ++steps;
                        }
                        cout << "(" << child->x << ", " << child->y << ") ";
                        cout << endl;
                        cout << "We made " << iteration << " iteration(s)." << endl;
                        return steps;
                    }
                    queue.push(child);
                }
            }
        }
    }
    return -1;
}

int main()
{
    unsigned int startX = 0, startY = 0, finishX = 0, finishY = 0;

    cout << "Set startpoint X, Y coordinates: ";
    cin >> startX >> startY;

    cout << "Set endpoint X, Y coordinates: ";
    cin >> finishX >> finishY;

    float fTimeStart = clock()/(float)CLOCKS_PER_SEC;
    cout << "We have to make " << BFS(startX, startX, finishX, finishY) << " step(s)." << endl;
    float fTimeStop = clock()/(float)CLOCKS_PER_SEC;
    cout << "Time execution in sec: " << fTimeStop - fTimeStart << endl;

    return 0;
}