
#include <iostream>
#include <stack>
#include <vector>

bool **createMatrix (int rows, int columns){
	bool **new_matrix = new bool*[rows];

	for (int i = 0; i < rows; i++){
		new_matrix[i] = new bool[columns];
		for (int j = 0; j < columns; j++)
			new_matrix[i][j] = 0;
	}

	return new_matrix;
}

void fillMap (bool **map, int n){
	for (int i = 0; i < n; i++)
		for (int j = 0; j < n; j++)
			std::cin >> map[i][j];
}

void printMap (bool **map, int n){
	std::cout << std::endl;
	for (int i = 0; i < n; i++){
		for (int j = 0; j < n; j++)
			std::cout << map[i][j];
		std::cout << std::endl; 
	}
	std::cout << std::endl;
}

void spin (bool **map, int n, int x, int y){
	
	if (x < 0 || y < 0 || x >= n || y >= n)
		return;
	if (map[x][y] == 1){
		map[x][y] = 0;
		spin (map, n, x++, y);
		spin (map, n, x, y++);
		spin (map, n, x--, y);
		spin (map, n, x--, y);
		spin (map, n, x, y--);
		spin (map, n, x, y--);
		spin (map, n, x++, y);
		spin (map, n, x++, y);
	}
}

int eagleCounter (bool **map, int n){
	int counter = 0;

	for (int i = 0; i < n; i++){
		for (int j = 0; j < n; j++){
			if (map[i][j] == 1){
				spin (map, n, i, j);
				counter++;
			}
		}
	}

	return counter;
}

/*	Falla con n = 4 y 
	1 0 1 0
	1 0 1 1 
	0 1 0 0 
	1 0 1 0	*/

int main (void){
	bool **map;
	int n, n_eagles;

	std::cin >> n;
	map = createMatrix (n, n);
	fillMap (map, n);
	printMap (map, n);
	n_eagles =	eagleCounter (map, n);
	std::cout << n_eagles << std::endl;
	
	return 0;
}
