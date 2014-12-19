#include <iostream>

using namespace std;

unsigned int SIZE = 10;

void dostuff(double (*a)[3][3])
{
    // access them as (*a)[0][0] .. (*a)[2][2]
    (*a)[0][2] = 42;
}
int main()
{
    double stuff[3][3];

    for(int i = 0; i < 3; i++) {
        for(int j = 0; j < 3; j++) {
            stuff[i][j] = (i + 1) * (j + 1);
        }
    }

    for(int i = 0; i < 3; i++) {
        for(int j = 0; j < 3; j++) {
            cout << stuff[i][j] << " ";
        }
        cout << endl;
    }

    double (*p_stuff)[3][3] = &stuff;
    dostuff(p_stuff);

    cout << endl;

    for(int i = 0; i < 3; i++) {
        for(int j = 0; j < 3; j++) {
            cout << stuff[i][j] << " ";
        }
        cout << endl;
    }

    return 0;
}

/*void moveToNeighbor(int x, int y, bool board[][]) {
    if(x+1 < SIZE && y+2 < SIZE) board[x+1][y+2] = true;
    if(x+1 < SIZE && y-2 >= 0) board[x+1][y-2] = true;

    if(x-1 >= 0 && y+2 < SIZE) board[x-1][y+2] = true;
    if(x-1 >= 0 && y-2 >= 0) board[x-1][y-2] = true;

    if(x+2 < SIZE && y+1 < SIZE) board[x+2][y+1] = true;
    if(x+2 < SIZE && y-1 >= 0) board[x+2][y-1] = true;

    if(x-2 >= 0 && y+1 < SIZE) board[x-2][y+1] = true;
    if(x-2 >= 0 && y-1 >= 0) board[x-2][y-1] = true;
}

int main() {

    bool chessboard[SIZE][SIZE];

    for(int i = 0; i < SIZE; i++) {
        for(int j = 0; j < SIZE; j++) {
            chessboard[i][j] = false;
        }
    }

    //bool (*p_board)[SIZE][SIZE] = &chessboard;

    //moveToNeighbor(0, 0, p_board);

    for(int i = 0; i < SIZE; i++) {
        for(int j = 0; j < SIZE; j++) {
            cout << chessboard[i][j] << " ";
        }
        cout << endl;
    }


    return 0;
}*/