#include <bits/stdc++.h>
#include <fstream>
using namespace std;

typedef pair<int, int> Pair;
typedef pair<double, pair<int, int> > pPair;

struct cell {
    int parent_i, parent_j;
    double f, g, h;
};

bool isValid(int row, int col, int n, int m) {
    return (row >= 0) && (row < n) && (col >= 0) && (col < m);
}

bool isUnBlocked(vector<vector<int>> grid, int row, int col) {
    if (grid[row][col] == 1){
        return (true);
    } else {
        return (false);
    }
}

bool isDestination(int row, int col, Pair dest) {
    if (row == dest.first && col == dest.second){
        return (true);
    } else {
        return (false);
    }
}

double calculateHValue(int row, int col, Pair dest) {
    return ((double)sqrt((row - dest.first) * (row - dest.first) + (col - dest.second) * (col - dest.second)));
}
 
void tracePath(vector<vector<cell>> cellDetails, Pair dest) {
    int row = dest.first;
    int col = dest.second;
 
    stack<Pair> Path;
 
    while (!(cellDetails[row][col].parent_i == row && cellDetails[row][col].parent_j == col)) {
        Path.push(make_pair(row, col));
        int temp_row = cellDetails[row][col].parent_i;
        int temp_col = cellDetails[row][col].parent_j;
        row = temp_row;
        col = temp_col;
    }
 
    Path.push(make_pair(row, col));

    while (!Path.empty()) {
        pair<int, int> p = Path.top();
        Path.pop();
        printf("-> (%d,%d) ", p.first, p.second);
    }
    printf("\n");
 
    return;
}
 
void aStarSearch(vector<vector<int>> grid, Pair src, Pair dest, int n, int m) {
    if (isValid(src.first, src.second, n, m) == false || isValid(dest.first, dest.second, n, m) == false) {
        printf("Source or Destination is invalid\n");
        return;
    }

    if (isUnBlocked(grid, src.first, src.second) == false || isUnBlocked(grid, dest.first, dest.second) == false) {
        printf("Source or the destination is blocked\n");
        return;
    }

    if (isDestination(src.first, src.second, dest) == true) {
        printf("We are already at the destination\n");
        return;
    }

    bool closedList[n][m];
    memset(closedList, false, sizeof(closedList));
 
    vector<vector<cell>> cellDetails(n, vector<cell>(m));
 
    int i, j;
 
    for (i = 0; i < n; i++) {
        for (j = 0; j < m; j++) {
            cellDetails[i][j].f = FLT_MAX;
            cellDetails[i][j].g = FLT_MAX;
            cellDetails[i][j].h = FLT_MAX;
            cellDetails[i][j].parent_i = -1;
            cellDetails[i][j].parent_j = -1;
        }
    }

    i = src.first, j = src.second;
    cellDetails[i][j].f = 0.0;
    cellDetails[i][j].g = 0.0;
    cellDetails[i][j].h = 0.0;
    cellDetails[i][j].parent_i = i;
    cellDetails[i][j].parent_j = j;

    set<pPair> openList;

    openList.insert(make_pair(0.0, make_pair(i, j)));

    bool foundDest = false;
 
    while (!openList.empty()) {
        pPair p = *openList.begin();
        openList.erase(openList.begin());
 
        i = p.second.first;
        j = p.second.second;
        closedList[i][j] = true;
 
        double gNew, hNew, fNew;

        if (isValid(i - 1, j, n, m) == true) {
            if (isDestination(i - 1, j, dest) == true) {
                cellDetails[i - 1][j].parent_i = i;
                cellDetails[i - 1][j].parent_j = j;
                printf("The destination cell is found\n");
                tracePath(cellDetails, dest);
                foundDest = true;
                return;
            }

            else if (closedList[i - 1][j] == false && isUnBlocked(grid, i - 1, j) == true) {
                gNew = cellDetails[i][j].g + 1.0;
                hNew = calculateHValue(i - 1, j, dest);
                fNew = gNew + hNew;

                if (cellDetails[i - 1][j].f == FLT_MAX || cellDetails[i - 1][j].f > fNew) {
                    openList.insert(make_pair(fNew, make_pair(i - 1, j)));
 
                    cellDetails[i - 1][j].f = fNew;
                    cellDetails[i - 1][j].g = gNew;
                    cellDetails[i - 1][j].h = hNew;
                    cellDetails[i - 1][j].parent_i = i;
                    cellDetails[i - 1][j].parent_j = j;
                }
            }
        }

        if (isValid(i + 1, j, n, m) == true) { 
            if (isDestination(i + 1, j, dest) == true) { 
                cellDetails[i + 1][j].parent_i = i;
                cellDetails[i + 1][j].parent_j = j;
                printf("The destination cell is found\n");
                tracePath(cellDetails, dest);
                foundDest = true;
                return;
            }

            else if (closedList[i + 1][j] == false && isUnBlocked(grid, i + 1, j) == true) {
                gNew = cellDetails[i][j].g + 1.0;
                hNew = calculateHValue(i + 1, j, dest);
                fNew = gNew + hNew;

                if (cellDetails[i + 1][j].f == FLT_MAX || cellDetails[i + 1][j].f > fNew) {
                    openList.insert(make_pair(fNew, make_pair(i + 1, j)));
                    cellDetails[i + 1][j].f = fNew;
                    cellDetails[i + 1][j].g = gNew;
                    cellDetails[i + 1][j].h = hNew;
                    cellDetails[i + 1][j].parent_i = i;
                    cellDetails[i + 1][j].parent_j = j;
                }
            }
        }

        if (isValid(i, j + 1, n, m) == true) {
            if (isDestination(i, j + 1, dest) == true) {
                cellDetails[i][j + 1].parent_i = i;
                cellDetails[i][j + 1].parent_j = j;
                printf("The destination cell is found\n");
                tracePath(cellDetails, dest);
                foundDest = true;
                return;
            }

            else if (closedList[i][j + 1] == false
                     && isUnBlocked(grid, i, j + 1)
                            == true) {
                gNew = cellDetails[i][j].g + 1.0;
                hNew = calculateHValue(i, j + 1, dest);
                fNew = gNew + hNew;

                if (cellDetails[i][j + 1].f == FLT_MAX || cellDetails[i][j + 1].f > fNew) {
                    openList.insert(make_pair( fNew, make_pair(i, j + 1)));

                    cellDetails[i][j + 1].f = fNew;
                    cellDetails[i][j + 1].g = gNew;
                    cellDetails[i][j + 1].h = hNew;
                    cellDetails[i][j + 1].parent_i = i;
                    cellDetails[i][j + 1].parent_j = j;
                }
            }
        }

        if (isValid(i, j - 1, n, m) == true) {
            if (isDestination(i, j - 1, dest) == true) {
                cellDetails[i][j - 1].parent_i = i;
                cellDetails[i][j - 1].parent_j = j;
                printf("The destination cell is found\n");
                tracePath(cellDetails, dest);
                foundDest = true;
                return;
            }

            else if (closedList[i][j - 1] == false
                     && isUnBlocked(grid, i, j - 1)
                            == true) {
                gNew = cellDetails[i][j].g + 1.0;
                hNew = calculateHValue(i, j - 1, dest);
                fNew = gNew + hNew;

                if (cellDetails[i][j - 1].f == FLT_MAX || cellDetails[i][j - 1].f > fNew) {
                    openList.insert(make_pair(fNew, make_pair(i, j - 1)));
 
                    cellDetails[i][j - 1].f = fNew;
                    cellDetails[i][j - 1].g = gNew;
                    cellDetails[i][j - 1].h = hNew;
                    cellDetails[i][j - 1].parent_i = i;
                    cellDetails[i][j - 1].parent_j = j;
                }
            }
        }
 
        if (isValid(i - 1, j + 1, n, m) == true) {
            if (isDestination(i - 1, j + 1, dest) == true) {
                cellDetails[i - 1][j + 1].parent_i = i;
                cellDetails[i - 1][j + 1].parent_j = j;
                printf("The destination cell is found\n");
                tracePath(cellDetails, dest);
                foundDest = true;
                return;
            }

            else if (closedList[i - 1][j + 1] == false && isUnBlocked(grid, i - 1, j + 1) == true) {
                gNew = cellDetails[i][j].g + 1.414;
                hNew = calculateHValue(i - 1, j + 1, dest);
                fNew = gNew + hNew;

                if (cellDetails[i - 1][j + 1].f == FLT_MAX || cellDetails[i - 1][j + 1].f > fNew) {
                    openList.insert(make_pair(fNew, make_pair(i - 1, j + 1)));
 
                    cellDetails[i - 1][j + 1].f = fNew;
                    cellDetails[i - 1][j + 1].g = gNew;
                    cellDetails[i - 1][j + 1].h = hNew;
                    cellDetails[i - 1][j + 1].parent_i = i;
                    cellDetails[i - 1][j + 1].parent_j = j;
                }
            }
        }
 
        if (isValid(i - 1, j - 1, n, m) == true) { 
            if (isDestination(i - 1, j - 1, dest) == true) {
                cellDetails[i - 1][j - 1].parent_i = i;
                cellDetails[i - 1][j - 1].parent_j = j;
                printf("The destination cell is found\n");
                tracePath(cellDetails, dest);
                foundDest = true;
                return;
            }

            else if (closedList[i - 1][j - 1] == false && isUnBlocked(grid, i - 1, j - 1) == true) {
                gNew = cellDetails[i][j].g + 1.414;
                hNew = calculateHValue(i - 1, j - 1, dest);
                fNew = gNew + hNew;

                if (cellDetails[i - 1][j - 1].f == FLT_MAX || cellDetails[i - 1][j - 1].f > fNew) {
                    openList.insert(make_pair(fNew, make_pair(i - 1, j - 1)));

                    cellDetails[i - 1][j - 1].f = fNew;
                    cellDetails[i - 1][j - 1].g = gNew;
                    cellDetails[i - 1][j - 1].h = hNew;
                    cellDetails[i - 1][j - 1].parent_i = i;
                    cellDetails[i - 1][j - 1].parent_j = j;
                }
            }
        }
 
        if (isValid(i + 1, j + 1, n, m) == true) {
            if (isDestination(i + 1, j + 1, dest) == true) {
                cellDetails[i + 1][j + 1].parent_i = i;
                cellDetails[i + 1][j + 1].parent_j = j;
                printf("The destination cell is found\n");
                tracePath(cellDetails, dest);
                foundDest = true;
                return;
            }
 
            else if (closedList[i + 1][j + 1] == false && isUnBlocked(grid, i + 1, j + 1) == true) {
                gNew = cellDetails[i][j].g + 1.414;
                hNew = calculateHValue(i + 1, j + 1, dest);
                fNew = gNew + hNew;

                if (cellDetails[i + 1][j + 1].f == FLT_MAX || cellDetails[i + 1][j + 1].f > fNew) {
                    openList.insert(make_pair( fNew, make_pair(i + 1, j + 1)));
 
                    cellDetails[i + 1][j + 1].f = fNew;
                    cellDetails[i + 1][j + 1].g = gNew;
                    cellDetails[i + 1][j + 1].h = hNew;
                    cellDetails[i + 1][j + 1].parent_i = i;
                    cellDetails[i + 1][j + 1].parent_j = j;
                }
            }
        }

        if (isValid(i + 1, j - 1, n, m) == true) {
            if (isDestination(i + 1, j - 1, dest) == true) {
                cellDetails[i + 1][j - 1].parent_i = i;
                cellDetails[i + 1][j - 1].parent_j = j;
                printf("The destination cell is found\n");
                tracePath(cellDetails, dest);
                foundDest = true;
                return;
            }

            else if (closedList[i + 1][j - 1] == false && isUnBlocked(grid, i + 1, j - 1) == true) {
                gNew = cellDetails[i][j].g + 1.414;
                hNew = calculateHValue(i + 1, j - 1, dest);
                fNew = gNew + hNew;

                if (cellDetails[i + 1][j - 1].f == FLT_MAX || cellDetails[i + 1][j - 1].f > fNew) {
                    openList.insert(make_pair(fNew, make_pair(i + 1, j - 1)));

                    cellDetails[i + 1][j - 1].f = fNew;
                    cellDetails[i + 1][j - 1].g = gNew;
                    cellDetails[i + 1][j - 1].h = hNew;
                    cellDetails[i + 1][j - 1].parent_i = i;
                    cellDetails[i + 1][j - 1].parent_j = j;
                }
            }
        }
    }

    if (foundDest == false)
        printf("Failed to find the Destination Cell\n");
 
    return;
}

int main(){
    ifstream f("Matrice.in");
    int i, j, n, m;
    f >> n >> m;

    vector<vector<int>> mat(n, vector<int>(m));
    for(i = 0; i < n; i++){
        for(j = 0; j < m; j++){
            f >> mat[i][j];
        }
    }

    f >> i >> j;
    Pair src = make_pair(i, j);
    f >> i >> j;
    Pair dest = make_pair(i, j);
    aStarSearch(mat, src, dest, n ,m);
 
    return (0);
}