//
//  main.cpp
//  Horse 2.0
//
//  Created by Anton Kovernik on 22.12.14.
//  Copyright (c) 2014 Anton Kovernik. All rights reserved.
//

#include <iostream>
#include <queue>

using namespace std;



struct Point {
    Point(unsigned int X, unsigned int Y):x(X), y(Y) {}
    unsigned int x;
    unsigned int y;
};


int main(int argc, const char * argv[]) {

    
    cout << "Start point: " << atoi(argv[1]) << " " << atoi(argv[2])  << endl;
    cout << "End point: " << atoi(argv[3]) << " " << atoi(argv[4])  << endl;
    cout << "Board: " << atoi(argv[5]) << endl;
    
    const float fTimeStart = clock() / (float)CLOCKS_PER_SEC;
   
    const int kSize = atoi(argv[5]);
    int** grid = (int**)malloc(kSize * sizeof(int*));
    for (unsigned int i = 0; i < kSize; i++) {
        grid[i] = (int*)malloc(kSize * sizeof(unsigned char));
    }
   
    // start
    const Point start = Point(atoi(argv[1]), atoi(argv[2]));
    
    // finish
    const Point end = Point(atoi(argv[3]),  atoi(argv[4]));

    queue<Point> moves;
    
    unsigned int x = 0, y = 0;
    moves.push(start);
    
    grid[start.x][start.y] = 1;
    
    while (moves.size()) {
        const Point current = moves.front();
        moves.pop();
        
        /*
         *     *
         *     *
         *     * *
         */
        
        x = current.x + 1;
        y = current.y + 2;
        if (x < kSize)
            if (y < kSize)
                if(!grid[x][y]) {
                    grid[x][y] = 9;
                    moves.push(Point(x,y));
                    if (x == end.x && y == end.y)
                        break;
                }

        
        /*
         *     * * *
         *         *
         */
        
        x = current.x + 2;
        y = current.y + 1;
        if (x < kSize)
            if( y < kSize)
                if(!grid[x][y]) {
                    grid[x][y] = 2;
                    moves.push(Point(x,y));
                    if (x == end.x && y == end.y)
                        break;
                }
        /*
         *     * *
         *     *
         *     *
         */
        
        x = current.x + 1;
        y = current.y - 2;
        if (x < kSize)
            if (y < kSize)
                if(!grid[x][y]) {
                    grid[x][y] = 4;
                    moves.push(Point(x,y));
                    if (x == end.x && y == end.y)
                        break;
                }

        /*
         *         *
         *     * * *
         */
        x = current.x + 2;
        y = current.y - 1;
        if (x < kSize)
            if(y < kSize)
                if(!grid[x][y]) {
                    grid[x][y] = 3;
                    moves.push(Point(x,y));
                    if (x == end.x && y == end.y) break;
                }
        
        
        //
        //   * *
        //     *
        //     *
        //
        
        x = current.x - 1;
        y = current.y - 2;
        if (x < kSize)
            if(y < kSize)
                if(!grid[x][y]) {
            grid[x][y] = 5;
            moves.push(Point(x,y));
            if (x == end.x && y == end.y)
                break;
        }
        
        /*
         *     * * *
         *     *
         */
        
        
        x = current.x - 2;
        y = current.y + 1;
        if (x < kSize)
            if(y < kSize)
                if(!grid[x][y]) {
                    grid[x][y] = 6;
                    moves.push(Point(x,y));
                    if (x == end.x && y == end.y)
                        break;
                }
        
        /*
         *     *
         *     * * *
         */
        
        x = current.x - 2;
        y = current.y - 1;
        if (x < kSize)
            if(y < kSize)
                if(!grid[x][y]) {
                    grid[x][y] = 7;
                    moves.push(Point(x,y));
                    if (x == end.x && y == end.y)
                        break;
                }
        
        /*
         *     *
         *     *
         *   * *
         */
        x = current.x - 1;
        y = current.y + 2;
        if (x < kSize)
            if(y < kSize)
                if(!grid[x][y]) {
            grid[x][y] = 8;
            moves.push(Point(x,y));
            if (x == end.x && y == end.y)
                break;
        }   
       
    }
    int steps = 0;
    while (grid[x][y] != 1) {
        steps++;
        switch (grid[x][y]) {
            case 2:
                x = x - 2;
                y = y - 1;
                break;
            case 3:
                x = x - 2;
                y = y + 1;
                break;
            case 4:
                x = x - 1;
                y = y + 2;
                break;
            case 5:
                x = x + 1;
                y = y + 2;
                break;
            case 6:
                x = x + 2;
                y = y - 1;
                break;
            case 7:
                x = x + 2;
                y = y + 1;
                break;
            case 8:
                x = x + 1;
                y = y - 2;
                break;
            case 9:
                x = x - 1;
                y = y - 2;
                break;
        }
    }
    
    for(unsigned int i = 0; i < kSize; i++)
            delete[] grid[i];
       delete[] grid;
    
    const float fTimeStop = clock()/(float)CLOCKS_PER_SEC;
    cout << "Steps: " << steps << endl;
    cout << "Time execution in sec: " << fTimeStop - fTimeStart << endl;
    return 0;
}
