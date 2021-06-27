#include <iostream>
#include <vector>
#include <fstream>

using namespace std;

int is_not_in_sols(vector<int> &solution, vector<vector<int> > &sols){
	int i, j, same;

	for(i = 0; i < sols.size(); i++){

		if(sols[i].size() == solution.size()){
			same = 1;

			for(j = 0; j < sols[i].size(); j++){
				if(sols[i][j] != solution[j]){
					same = 0;
					break;
				}
			}

			if(same == 1){
				return 0;
			}
		}
	}

	return 1;
}

void backtracking(vector<int> &domain, vector<int> &solution, vector<vector<int> > &sols, int sol_sum, int sum){
	int i, j;
	if(sol_sum > sum){
		return;
	}

	if(sol_sum == sum){
		if(is_not_in_sols(solution, sols) == 1){
			sols.push_back(solution);
			return;
		}
	}

	for(i = 0; i < domain.size(); i++){
		if(solution.size() != 0 && domain[i] < solution[solution.size() - 1]){
			continue;
		}
		vector<int> new_domain(domain);
		new_domain.erase(new_domain.begin() + i);

		vector<int> new_solution(solution);
		new_solution.push_back(domain[i]);
		int new_sol_sum = sol_sum + domain[i];

		backtracking(new_domain, new_solution, sols, new_sol_sum, sum);
	}
}

int main() {
	ifstream f("plata.in");
	int i, j, n, times, S, type;

	f >> n >> S;
	vector<int> types(n);

	for(i = 0; i < n; i++){
		f >> types[i];
	}

	vector<int> domain;

	for(i = 0; i < n; i++) {
		f >> times;

		for(j = 0; j < times; j++){
			domain.push_back(types[i]);
		}
	}

	vector<int> solution;
	vector<vector<int> > sols;

	backtracking(domain, solution, sols, 0, S);

	for(i = 0; i < sols.size(); i++){
		for(j = 0; j < sols[i].size(); j++){
			cout << sols[i][j] << " ";
		}

		cout << endl;
	}
	return 0;
}
