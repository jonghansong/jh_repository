#include <string>
#include <vector>
#include <iostream>

using namespace std;

typedef pair<int, int> coord;

vector<int> solution(int rows, int columns, vector<vector<int> > queries) {
    vector<int> answer;
    
    vector<vector<int> > table;
    int i = 1;
    for(int r = 0; r < rows; ++r) {
        vector<int> int_row;
        for(int c = 0; c < columns; ++c) {
            int_row.push_back(i++);
        }
        table.push_back(int_row);
    }
    
    vector<vector<int> >::const_iterator q_it = queries.begin();
    for(; q_it != queries.end(); ++q_it) {
        vector<int> q = *q_it;
        int nR = q[0]-1;
        int nC = q[1]-1;
        
        int next = table[nR][nC++]; 
        int min = next;
        for(; nC < q[3]; ++nC) {
            int toChange = next;
            next = table[nR][nC];
            if(min > next) {
                min = next;
            }
            table[nR][nC] = toChange;
        }

        nC = q[3]-1;
        ++nR;
        for(; nR < q[2]; ++nR) {
            int toChange = next;    
            next = table[nR][nC];
            if(min > next) {
                min = next;
            }
            table[nR][nC] = toChange;
        }

        nR = q[2]-1;
        --nC;
        for(; nC >= q[1]-1; --nC) {
            int toChange = next;
            next = table[nR][nC];
            if(min > next) {
                min = next;
            }
            table[nR][nC] = toChange;
        }

        nC = q[1]-1;
        --nR;
        for(; nR >= q[0]-1; --nR) {
            int toChange = next;
            next = table[nR][nC];
            if(min > next) {
                min = next;
            }
            table[nR][nC] = toChange;
        }
        answer.push_back(min);
    }
    return answer;
}

int
main()
{
    vector<int> a0;
    a0.push_back(2);
    a0.push_back(2);
    a0.push_back(5);
    a0.push_back(4);

    vector<int> a1;
    a1.push_back(3);
    a1.push_back(3);
    a1.push_back(6);
    a1.push_back(6);

    vector<int> a2;
    a2.push_back(5);
    a2.push_back(1);
    a2.push_back(6);
    a2.push_back(3);

    vector<vector<int> > q;
    q.push_back(a0);
    q.push_back(a1);
    q.push_back(a2);

    solution(6,6, q);


}
