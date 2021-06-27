#include<bits/stdc++.h>
using namespace std;

struct Move {
    int row, col;
    char sign;
    Move(int row, int col, char sign) : row(row), col(col), sign (sign) { }
    Move(const Move& m) { 
        row = m.row; 
        col = m.col; 
        sign = m.sign;
    }
};

struct State{
    char board[3][3];
};

list<Move> get_all_moves(State &state, char player) {
    int i, j;
    list<Move> moveList;


    for(i = 0; i < 3; i++) {
        for(j = 0; j < 3; j++) {
            if (state.board[i][j] == '_') {
                moveList.push_back(Move(i, j, player));
            }
        }
    }

    return moveList;
}

int evaluate(State &state, char player){
    if(state.board[0][0] == player) {
        if((state.board[0][0] == state.board[0][1] && state.board[0][1] == state.board[0][2])
        	|| (state.board[0][0] == state.board[1][0] && state.board[1][0] == state.board[2][0]))
            
            return 10;
    }

    else
    	if(state.board[2][2] == player) {
            if((state.board[2][0] == state.board[2][1] && state.board[2][1] == state.board[2][2])
            	||(state.board[0][2] == state.board[1][2] && state.board[1][2] == state.board[2][2]))
                
                return 10;
        }

        else
	        if(state.board[1][1] == player) {
	            if((state.board[0][1] == state.board[1][1] && state.board[1][1] == state.board[2][1])
	                || (state.board[1][0] == state.board[1][1] && state.board[1][1] == state.board[1][2])
	            	|| (state.board[0][0] == state.board[1][1] && state.board[1][1] == state.board[2][2])
	            	|| (state.board[0][2] == state.board [1][1] && state.board[1][1] == state.board[2][0]))
	                
	                return 10;
	        }

    return -10;
}
 
void apply_move(State &state, Move move){
    state.board[move.row][move.col] = move.sign;
}

void undo_move(State &state, Move move){
    state.board[move.row][move.col] = '_';
}

bool game_over(State &state){
	int i, j;

    for(i = 0; i < 3; i++) {
        for(j = 0; j < 3; j++) {
            if(state.board[i][j] == '_') {
                return false;
            }
        }
    }

    return true;
}
 
// return the opponent for current player
char get_opponent(char player){
    if (player == 'x') {
        return '0';
    }

    return 'x';
}

Move best_move(0,0,'_');

int negamax(State& state, int depth, char player) {
    
    if(game_over(state) || depth == 0) {
       return evaluate(state, player);
    }

    list<Move> all_moves = get_all_moves(state, player);

    int best_score = -10000;

    for(auto const& move : all_moves) {
        apply_move(state, move);
        int score = (-1) * negamax(state, depth - 1, get_opponent(player));

        if(score > best_score) {
            best_score = score;
            best_move = move;
        }
 
        undo_move(state, move);
    }

    return best_score;
}

int main() {
	int i, j;
    State state;

    for(i = 0; i < 3; i++) {
        for(j = 0; j < 3; j++) {
            state.board[i][j] = '_';
        }
    }

    state.board[0][0] = '0';
    state.board[0][1] = '0';
    state.board[1][1] = 'x';

    cout << "Inainte:\n";

    for(i = 0; i < 3; i++) {
        for(j = 0; j < 3; j++) {
            cout << state.board[i][j] << " ";
        }

        cout << "\n";
    }

    cout << "\n";

    int depth = 9;
    char player = 'x';
    int score = negamax(state, depth, player);

    cout << "Miscarea optima este pe linia " << best_move.row << " si coloana " << best_move.col << endl << endl;
    cout << "Dupa:\n";
    
    for(i = 0; i < 3; i++) {
        for(j = 0; j < 3; j++) {
            if(i == best_move.row && j == best_move.col) {
                state.board[i][j] = best_move.sign;
            }

            cout << state.board[i][j] << " ";
        }

        cout << endl;
    }

    cout << endl << "Scor final: " << score << endl;
    return 0;
}


