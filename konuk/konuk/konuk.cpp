#include <iostream>
#include <time.h>
#include <queue>
int pow(int st)               // функция степени
{     int res=1;
           if(st==0) return 1;
		        else	{
                     for(int i=1;i<=st;i++)
	                 res*=10;
				}
  
   return res;
}

int convert(char *str)          //преобразование строки в число
{      int k=strlen(str);
       int l=0;
           for(int i=k-1;i>=0;i--)
           l+=(int(str[i])-48)*pow(k-i-1);
	  return l;
}





    using namespace std;
    
	struct Dots
	{
		
		int x;
		int y;
	}dots;
		queue<Dots>q;

	int main(int argc,char* argv[])

{  float fTimeStart = clock()/(float)CLOCKS_PER_SEC;
	int row1,col1,row2,col2,row,col,next_row,next_col,N;
	row1=convert(argv[1]); 
	col1=convert(argv[2]);
    row2=convert(argv[3]);
	col2=convert(argv[4]);
	N=convert(argv[5]);

	
	
	Dots **Matrix=new Dots*[N];
	  bool **visited=new bool*[N];
	   for(int i=0;i<N;i++)
	      { 
             visited[i]=new bool[N];
			  Matrix[i]=new Dots[N];
	       
	   }
	   
	   for(int a=0;a<N;a++)
	      for(int b=0;b<N;b++)
			  visited[a][b]=0;
  

   int drow[8]={+1,+2,+1,-1,-2,-2,+2,-1};
    int dcol[8]={+2,+1,-2,-2,-1,+1,-1,+2};
  
       
		dots.x=row1;
        dots.y=col1;
        
		visited[row1][col1]=true;
        q.push(dots);
		
        while(!q.empty())
    {
		row=q.front().x;
		col=q.front().y;
	        q.pop(); 
       
			         if(visited[row2][col2]) break; // если дошло до вершины то гг
					            for(int k=0;k<8;k++) // цикл возможных ходов
						{
							next_row=row+drow[k]; //перебор шагов!!! next_row - координата след шага
							next_col=col+dcol[k];
								if(next_row<0 || next_row>N-1 || next_col<0 || next_col>N-1 || visited[next_row][next_col]) continue; // выход за границу
							visited[next_row][next_col]=true; // матрица посещений
							Matrix[next_row][next_col].x=row; 
						    Matrix[next_row][next_col].y=col;
							dots.x=next_row;
							dots.y=next_col;
                            q.push(dots);             // заталкивание новой вершины (может быть до 8 вершин за цикл) 
						
						}
    } 

						row=row2; col=col2;
						int counter=0;
							for(;;)
					 { 
								// cout<<row<<' '<<col<<endl;  // вывод путей
										if(row==row1 && col==col1) break;
										next_row=Matrix[row][col].x;
										next_col=Matrix[row][col].y;
											row=next_row;
											col=next_col;
											counter++;

					 }

cout<<endl;

cout<<"Num of steps = "<<counter<<endl;
 float fTimeStop = clock()/(float)CLOCKS_PER_SEC; 


 for(int i=0;i<N;i++)
{	 delete [] Matrix[i];
 delete [] visited[i];
 }
  cout<<"Time execution in sec: "<<fTimeStop - fTimeStart<<endl;

 
return 0;
}