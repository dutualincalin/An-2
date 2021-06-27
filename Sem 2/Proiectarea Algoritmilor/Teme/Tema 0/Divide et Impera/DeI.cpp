#include <iostream>
#include <vector>
#include <fstream>
using namespace std;

#define CARDSPERTYPE 13
#define TOTALCARDS 52

typedef struct{
	int numar;
	string type;
} carte;

int Find_card(vector<carte> &pachet, carte &searched, int start, int finish){
	if(start > finish){
		return -1;
	}

	if(start == finish){
		if(pachet[start].numar = searched.numar && pachet[start].type == searched.type){
			return start;
		}

		else return -1; 
	}

	int mid = (start + finish)/2;

	if(pachet[mid].numar == searched.numar && pachet[mid].type == searched.type){
		return mid;
	}

	if(pachet[start].type == searched.type && pachet[finish].type == searched.type){
		if(searched.numar < pachet[mid].numar){
			return Find_card(pachet, searched, start, mid - 1);
		}

		return Find_card(pachet, searched, mid + 1, finish);
	}

	int left = Find_card(pachet, searched, start, mid - 1);
	int right = Find_card(pachet, searched, mid + 1, finish);

	if(left != -1){
		return left;
	}

	return right;
}

int main(){
	ifstream f("Pachet carti.in");

	int i, j;
	vector<carte> pachet(TOTALCARDS);
	carte searched;

	string type;

	for(i = 0; i < 4; i++){
		f >> type;
		
		for(j = 0; j < CARDSPERTYPE; j++){
			pachet[j + i * CARDSPERTYPE].numar = j + 2;
			pachet[j + i * CARDSPERTYPE].type = type;
		}
	}

	f >> searched.numar >> searched.type;
	f.close();

	cout << Find_card(pachet, searched, 0, TOTALCARDS - 1) + 1 << endl;
	return 0;	
}