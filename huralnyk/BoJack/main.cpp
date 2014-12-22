#include <iostream>
#include <list>
#include <bitset>

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
    struct cell *start = new cell;
    initCell(start, startX, startY);
    
    int steps = 0;
    int iteration = 0;
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
    list<cell*> queue;

    // Mark the current node as visited and enqueue it
    visited[start->x][start->y] = true;
    queue.push_back(start);

    while(!queue.empty())
    {
        // Dequeue a vertex from queue and print it
        start = queue.front();
        queue.pop_front();
        ++iteration;

        // We got endpoint. Finish.
        if((finishX == start->x) && (finishY == start->y))
        {
            cout << "Here is the backroute: ";
            while(start->parent != NULL) // Print the backroute
            {
                cout << "(" << start->x << ", " << start->y << ") ";
                start = start->parent;
                ++steps;
            }
            cout << "(" << start->x << ", " << start->y << ") ";
            cout << endl;
            cout << "We made " << iteration << " iteration(s)." << endl;
            return steps;
        }

        // Mark all children of current cell as visited and enqueue them.
        if((start->x + 2) < N && (start->y + 1) < N)
        {
            if(visited[start->x + 2][start->y + 1] != true)
            {
                struct cell *child = new cell;
                child->parent = start;
                child->x = start->x + 2;
                child->y = start->y + 1;
                visited[start->x + 2][start->y + 1] = true;
                queue.push_back(child);
            }
        }
        if((start->x + 2) < N && (start->y - 1) >= 0)
        {
            if(visited[start->x + 2][start->y - 1] != true)
            {
                struct cell *child = new cell;
                child->parent = start;
                child->x = start->x + 2;
                child->y = start->y - 1;
                visited[start->x + 2][start->y - 1] = true;
                queue.push_back(child);
            }
        }
        if((start->x - 2) >= 0 && (start->y + 1) < N)
        {
            if(visited[start->x - 2][start->y + 1] != true)
            {
                struct cell *child = new cell;
                child->parent = start;
                child->x = start->x - 2;
                child->y = start->y + 1;
                visited[start->x - 2][start->y + 1] = true;
                queue.push_back(child);
            }
        }
        if((start->x - 2) >= 0 && (start->y - 1) >= 0)
        {
            if(visited[start->x - 2][start->y - 1] != true)
            {
                struct cell *child = new cell;
                child->parent = start;
                child->x = start->x - 2;
                child->y = start->y - 1;
                visited[start->x - 2][start->y - 1] = true;
                queue.push_back(child);
            }
        }
        if((start->x + 1) < N && (start->y + 2) < N)
        {
            if(visited[start->x + 1][start->y + 2] != true)
            {
                struct cell *child = new cell;
                child->parent = start;
                child->x = start->x + 1;
                child->y = start->y + 2;
                visited[start->x + 1][start->y + 2] = true;
                queue.push_back(child);
            }
        }
        if((start->x + 1) < N && (start->y - 2) >= 0)
        {
            if(visited[start->x + 1][start->y - 2] != true)
            {
                struct cell *child = new cell;
                child->parent = start;
                child->x = start->x + 1;
                child->y = start->y - 2;
                visited[start->x + 1][start->y - 2] = true;
                queue.push_back(child);
            }
        }
        if((start->x - 1) >= 0 && (start->y + 2) < N)
        {
            if(visited[start->x - 1][start->y + 2] != true)
            {
                struct cell *child = new cell;
                child->parent = start;
                child->x = start->x - 1;
                child->y = start->y + 2;
                visited[start->x - 1][start->y + 2] = true;
                queue.push_back(child);
            }
        }
        if((start->x - 1) >= 0 && (start->y - 2) >= 0)
        {
            if(visited[start->x - 1][start->y - 2] != true)
            {
                struct cell *child = new cell;
                child->parent = start;
                child->x = start->x - 1;
                child->y = start->y - 2;
                visited[start->x - 1][start->y - 2] = true;
                queue.push_back(child);
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

    cout << "We have to make " << BFS(startX, startX, finishX, finishY) << " step(s)." << endl;

    return 0;
}