#include <string>
#include <iostream>
#include <sstream>
#include <vector>

using namespace std;

int fibonacci(int n);

int main(int argc, char* argv[])
{
    if(argc != 2) {
        cout << "Usage: fibonacci num" << endl;
        return -1;
    }

    stringstream ss(argv[1]);
    int i;
    ss >> i;

    cout << fibonacci(i) << endl;

    return 0;
}

int
fibonacci(int n)
{
    vector<int> sum;

    if(n >= 1) {
        sum.push_back(1);    
    }
    if(n >= 2) {
        sum.push_back(1);    
    }

    for(int i = 2 ; i < n; ++i) {
        vector<int>::reverse_iterator rit = sum.rbegin();
        int m1 = *rit;
        int m2 = *(++rit);

        sum.push_back(m1 + m2);
    }

    return sum.back();
}
